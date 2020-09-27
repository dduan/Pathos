#if !os(Windows)

#if canImport(Darwin)
import Darwin
#else
import Glibc
#endif // canImport(Darwin)

let kDefaultWritePermission: POSIXPermissions = [.ownerRead, .ownerWrite, .groupRead, .otherRead]

extension Path {
    public static func workingDirectory() throws -> Path {
        if let buffer = getcwd(nil, 0) {
            return Path(cString: buffer)
        }

        throw SystemError.unspecified(errorCode: errno)
    }

    public static func setWorkingDirectory(_ path: Path) throws {
        try path.binaryPath.c { cString in
            if chdir(cString) != 0 {
                throw SystemError(code: errno)
            }
        }
    }

    public func children(recursive: Bool = false) throws -> AnySequence<Path> {
        var result = [Path]()
        try binaryPath.c { cString in
            guard let streamPtr = opendir(cString) else {
                throw SystemError(code: errno)
            }

            defer {
                closedir(streamPtr)
            }

            while let entryPtr = readdir(streamPtr) {
                let entry = entryPtr.pointee
                guard let name = withUnsafeBytes(
                    of: entry.d_name,
                    { $0.bindMemory(to: POSIXEncodingUnit.self).baseAddress.map(POSIXBinaryString.init(cString:))
                    }
                ),
                    name.content != [POSIXConstants.binaryCurrentContext, POSIXConstants.binaryCurrentContext] && name.content != [POSIXConstants.binaryCurrentContext]
                else {
                    continue
                }

                let pathType: FileType = POSIXFileType(rawFileType: Int32(entry.d_type))
                let child = joined(with: name)
                result.append(child)

                if recursive && pathType.isDirectory {
                    result += try child.children(recursive: true)
                }
            }
        }

        return AnySequence(result)
    }

    /// Set new permissions for a file path.
    ///
    /// - Parameter permissions: The new file permission.
    public func set(_ permissions: Permissions) throws {
        guard let posixPermissions = permissions as? POSIXPermissions else {
            fatalError("Attempting to set incompatable permissions")
        }

        try binaryPath.c { cString in
            if chmod(cString, posixPermissions.rawValue) != 0 {
                throw SystemError(code: errno)
            }
        }
    }

    public func makeDirectory(withParents: Bool = false) throws {
        func _makeDirectory() throws {
            try binaryPath.c { cString in
                if mkdir(cString, 0o755) != 0 {
                    let error = SystemError(code: errno)
                    // Cannot rely on checking for EEXIST, since the operating system
                    // could give priority to other errors like EACCES or EROFS
                    if !exists() || error == .fileExists && !withParents {
                        throw error
                    }
                }
            }
        }

        if withParents && !pure.segments.isEmpty {
            let parents = self.parents.makeIterator()
            try parents.next()?.makeDirectory(withParents: true)
        }

        try _makeDirectory()
    }

    public func delete(recursive: Bool = true) throws {
        let meta = try metadata()
        if meta.fileType.isDirectory {
            if recursive {
                for child in try children(recursive: false) {
                    try child.delete(recursive: true)
                }
            }
            try binaryPath.c { cString in
                if rmdir(cString) != 0 {
                    throw SystemError(code: errno)
                }
            }
        } else {
            try binaryPath.c { cString in
                if unlink(cString) != 0 {
                    throw SystemError(code: errno)
                }
            }
        }
    }

    /// Move a file or direcotry to a new path. If the destination already exist, write over it.
    ///
    /// - Parameter newPath: New path for the content at the current path.
    public func move(to newPath: Path) throws {
        try binaryPath.c { fromBuffer in
            try newPath.binaryPath.c { toBuffer in
                if rename(fromBuffer, toBuffer) != 0 {
                    throw SystemError(code: errno)
                }
            }
        }
    }

    /// Return a path to which a symbolic link points to.
    public func readSymlink() throws -> Path {
        guard try metadata().fileType.isSymlink else {
            return self
        }

        return try Path(
            CString(
                nulTerminatedStorage: ContiguousArray<POSIXEncodingUnit>(
                    unsafeUninitializedCapacity: Constants.maxPathLength + 1
                ) { buffer, count in
                    try binaryPath.c { cString in
                        let length = Int(
                            readlink(cString, buffer.baseAddress!, Constants.maxPathLength)
                        )

                        if length == -1 {
                            throw SystemError(code: errno)
                        }

                        buffer[length] = 0
                        count = length + 1
                    }
                }
            )
        )
    }

    /// Create a symbolic link to this path.
    ///
    /// - Parameter path: The path at which to create the symlink.
    public func makeSymlink(at path: Path) throws {
        try binaryPath.c { source in
            try path.binaryPath.c { target in
                if symlink(source, target) != 0 {
                    throw SystemError(code: errno)
                }
            }
        }
    }

    public func real() throws -> Path {
        func resolve(path: Path, rest: Path, seen: inout [Path: Path]) throws -> (Path, Bool) {
            var path = path
            var rest = rest
            if rest.isAbsolute {
                path = Path(PurePOSIXPath(parts: Path.Parts(drive: rest.drive, root: rest.root, segments: [])))
                rest = Path(PurePOSIXPath(parts: Path.Parts(drive: nil, root: nil, segments: rest.segments)))
            }
            while let name = rest.segments.first {
                rest = Path(PurePOSIXPath(parts: Path.Parts(drive: nil, root: nil, segments: Array(rest.segments[1...]))))
                if name == ".." {
                    if path.isEmpty {
                        path = Path("..")
                    } else {
                        if path.segments.last == ".." {
                            path = path + ".."
                        }
                    }

                    continue
                }

                let newPath = path + name
                if (try? newPath.metadata().fileType.isSymlink) != true {
                    path = newPath
                    continue
                }

                if let newPath = seen[newPath] {
                    if !path.isEmpty {
                        continue
                    }

                    return (newPath + rest, false)
                }

                seen[newPath] = nil
                let (resolved, ok) = try resolve(path: path, rest: newPath.readSymlink(), seen: &seen)
                path = resolved
                if !ok {
                    return (path + rest, false)
                }
            }

            return (path, true)
        }

        let empty = Path(PurePOSIXPath(parts: Path.Parts(drive: nil, root: nil, segments: [])))
        var cache = [Path: Path]()
        let (result, _) = try resolve(path: empty, rest: self, seen: &cache)
        return try result.absolute()
    }

    func write(bytes: UnsafeRawPointer, byteCount: Int, createIfNecessary: Bool = true, truncate: Bool = true) throws {
        let oflag = O_WRONLY | (createIfNecessary ? O_CREAT : 0) | (truncate ? O_TRUNC : 0)
        try binaryPath.c { path in
            let fd = open(path, oflag, kDefaultWritePermission.rawValue)
            defer { close(fd) }
            if fd == -1 {
                throw SystemError(code: errno)
            }
            if pwrite(fd, bytes, byteCount, 0) == -1 {
                throw SystemError(code: errno)
            }
        }
    }
}

#endif // !os(Windows)
