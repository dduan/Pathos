#if !os(Windows)

#if canImport(Darwin)
import Darwin
private let systemGlob = Darwin.glob
#else
import Glibc
private let systemGlob = Glibc.glob
#endif // canImport(Darwin)

let kDefaultWritePermission: POSIXPermissions = [.ownerRead, .ownerWrite, .groupRead, .otherRead]
let kCopyChunkSize = 16 * 1024

extension Path {
    /// Returns the current working directory.
    ///
    /// - Returns: the path representing the current working directory.
    public static func workingDirectory() throws -> Path {
        if let buffer = getcwd(nil, 0) {
            return Path(cString: buffer)
        }

        throw SystemError.unspecified(errorCode: errno)
    }

    /// Set the current working directory.
    ///
    /// - Parameter path: the new working directory.
    public static func setWorkingDirectory(_ path: Path) throws {
        try path.binaryPath.c { cString in
            if chdir(cString) != 0 {
                throw SystemError(code: errno)
            }
        }
    }

    /// List the content of the directory, recursively if required.
    /// - Parameters:
    ///   - recursive: Require content of the directories inside the directory to be included in the
    ///                result, recursively.
    ///   - followSymlink: If a child is a symlink to a directory, include it, and the directory's
    ///                    children. This option has no effect when `recursive` is `false`.
    /// - Returns: A sequence containing pair of path and the file type from the content of the
    ///            directory.
    public func children(recursive: Bool = false, followSymlink: Bool = false) throws
        -> AnySequence<(Path, FileType)>
    {
        try childrenImpl(logicalParent: nil, recursive: recursive, followSymlink: followSymlink)
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

    /// Delete content at `self`.
    /// Content of directory is deleted alongside the directory itself, unless specified otherwise.
    ///
    /// - Parameter recursive: `true` means content of non-empty direcotry will be deleted along
    ///                        with the directory itself. `true` is the default value.
    public func delete(recursive: Bool = true) throws {
        let meta = try metadata()
        if meta.fileType.isDirectory {
            if recursive {
                for child in try children(recursive: false) {
                    try child.0.delete(recursive: true)
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
    ///
    /// - Returns: The target path of the symlink.
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

    /// Create a symbolic link to `self`.
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

    /// Return the canonical path of `self`, eliminating any symbolic links encountered in the path.
    ///
    /// When symbolic link cycles occur, the returned path will be one member of the cycle, but no
    /// guarantee is made about which member that will be.
    ///
    /// - Returns: The canonical path of `self` with all symlinks eliminated.
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

    /// Returns current user's home directory. Pathos will attempt to retrieve this information via
    /// environment variables first. If that's not sufficient, it'll try to infer from other
    /// methods.
    ///
    /// - Returns: The home directory of the current user.
    public static func home() -> Path {
        if let home = getenv("HOME") {
            return Path(cString: home)
        }

        if let passwd = getpwuid(getuid()), let home = passwd.pointee.pw_dir {
            return Path(cString: home)
        }

        return Path("/")
    }

    /// Read from a normal file.
    ///
    /// - Returns: binary content of the normal file.
    public func readBytes() throws -> [UInt8] {
        try binaryPath.c { cPath in
            let feed = open(cPath, O_RDONLY)
            if feed == -1 {
                throw SystemError(code: errno)
            }

            defer {
                close(feed)
            }

            let meta = try metadata()
            if meta.fileType.isDirectory {
                return []
            }

            let size = Int(meta.size)
            return Array(unsafeUninitializedCapacity: size) { buffer, count in
                count = Int(read(feed, buffer.baseAddress, size))
            }
        }
    }

    func matches(pattern: Path) -> Bool {
        pattern.binaryPath.c { cPattern in
            binaryPath.c { cPath in
                fnmatch(cPattern, cPath, 0) == 0
            }
        }
    }

    func simpleGlobImpl() -> [Path] {
        var gt = glob_t()
        defer {
            globfree(&gt)
        }

        let flags = GLOB_TILDE | GLOB_BRACE
        return binaryPath.c { pattern -> [Path] in
            guard systemGlob(pattern, flags, nil, &gt) == 0 else {
                return []
            }

            let count = Int(gt.gl_pathc)
            return (0 ..< count)
                .compactMap { gt.gl_pathv[$0] }
                .compactMap { Path(cString: $0) }
        }
    }

    func childrenImpl(logicalParent: Path?, recursive: Bool = false, followSymlink: Bool = false) throws
        -> AnySequence<(Path, FileType)>
    {
        var result = [(Path, FileType)]()
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
                    { $0.bindMemory(to: POSIXEncodingUnit.self)
                        .baseAddress
                        .map(POSIXBinaryString.init(cString:))
                    }
                ),
                    name.content != [
                        POSIXConstants.binaryCurrentContext,
                        POSIXConstants.binaryCurrentContext,
                    ] && name.content != [POSIXConstants.binaryCurrentContext]
                else {
                    continue
                }

                let pathType: FileType = POSIXFileType(rawFileType: Int32(entry.d_type))
                let child = (logicalParent ?? self).joined(with: name)
                result.append((child, pathType))

                if recursive {
                    if pathType.isDirectory {
                        result += try child.childrenImpl(logicalParent: nil, recursive: true, followSymlink: followSymlink)
                    } else if pathType.isSymlink,
                        followSymlink,
                        let linkTarget = try? child.readSymlink(),
                        case let link = joined(with: linkTarget),
                        try link.metadata().fileType.isDirectory
                    {
                        result += try link.childrenImpl(logicalParent: joined(with: name), recursive: recursive, followSymlink: true)
                    }
                }
            }
        }

        return AnySequence(result)
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

    /// Copy content of `self` to `destination`.
    ///
    /// - Parameters:
    ///   - destination: The target location for the copied content.
    ///   - followSymlink: If the content is a symlink, `true` means the target of the symlink will
    ///                    get copied. Otherwise, the symlink itself gets copied.
    public func copy(to destination: Path, followSymlink: Bool = true) throws {
        let sourceMeta = try metadata()

        if !sourceMeta.fileType.isFile && !sourceMeta.fileType.isSymlink {
            throw SystemError(code: 1) // Operation is not permitted
        }

        // some question from Python's standard library: What about other special files? (sockets, devices...)
        let isLink = sourceMeta.fileType.isSymlink
        if !followSymlink && isLink {
            try readSymlink().makeSymlink(at: destination)
            return
        }

        let source = isLink ? self : try readSymlink()
        let permissions = try source.metadata().permissions as! POSIXPermissions

        try source.binaryPath.c { sourcePath in
            try destination.binaryPath.c { destinationPath in
                let sourceFD = open(sourcePath, O_RDONLY)
                if sourceFD == -1 {
                    throw SystemError(code: errno)
                }
                defer { close(sourceFD) }

                let destinationFD = open(destinationPath, O_WRONLY | O_CREAT)
                if destinationFD == -1 {
                    throw SystemError(code: errno)
                }
                defer { close(destinationFD) }

                let buffer = UnsafeMutableBufferPointer<UInt8>.allocate(capacity: kCopyChunkSize)
                defer { buffer.deallocate() }

                defer {
                    chmod(destinationPath, permissions.rawValue)
                }

                var position: off_t = 0
                while true {
                    let length = pread(sourceFD, buffer.baseAddress!, kCopyChunkSize, position)
                    if length == 0 {
                        break
                    }
                    pwrite(destinationFD, buffer.baseAddress!, length, position)
                    position = position + off_t(length)
                }
            }
        }
    }
}

#endif // !os(Windows)
