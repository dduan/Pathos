#if !os(Windows)

#if canImport(Darwin)
import Darwin
#else
import Glibc
#endif // canImport(Darwin)

extension Path {
    public static func workingDirectory() throws -> Path {
        if let buffer = getcwd(nil, 0) {
            return Path(cString: buffer)
        }

        throw SystemError.unspecified(errorCode: errno)
    }

    public static func setWorkingDirectory(_ path: Path) throws {
        if chdir(path.binaryString.cString) != 0 {
            throw SystemError(code: errno)
        }
    }

    public func children(recursive: Bool = false) throws -> AnySequence<Path> {
        var result = [Path]()
        guard let streamPtr = opendir(binaryString.cString) else {
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
                name != [POSIXConstants.binaryCurrentContext, POSIXConstants.binaryCurrentContext] && name != [POSIXConstants.binaryCurrentContext]
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

        return AnySequence(result)
    }

    /// Set new permissions for a file path.
    ///
    /// - Parameter permissions: The new file permission.
    public func set(_ permissions: Permissions) throws {
        guard let posixPermissions = permissions as? POSIXPermissions else {
            fatalError("Attempting to set incompatable permissions")
        }

        if chmod(binaryString.cString, posixPermissions.rawValue) != 0 {
            throw SystemError(code: errno)
        }
    }

    public func makeDirectory(withParents: Bool = false) throws {
        func _makeDirectory() throws {
            if mkdir(binaryString.cString, 0o755) != 0 {
                let error = SystemError(code: errno)
                // Cannot rely on checking for EEXIST, since the operating system
                // could give priority to other errors like EACCES or EROFS
                if !exists() || error == .fileExists && !withParents {
                    throw error
                }
            }
        }

        if !withParents {
            try _makeDirectory()
        } else if !pure.segments.isEmpty {
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

            if rmdir(binaryString.cString) != 0 {
                throw SystemError(code: errno)
            }
        } else {
            if unlink(binaryString.cString) != 0 {
                throw SystemError(code: errno)
            }
        }
    }
}

#endif // !os(Windows)
