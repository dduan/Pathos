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
        if let cString = path.binaryString.cString, chdir(cString) != 0 {
            throw SystemError(code: errno)
        }
    }

    public func children(recursive: Bool = false) throws -> [(Path, FileType)] {
        var result = [(Path, FileType)]()
        guard let cString = binaryString.cString, let streamPtr = opendir(cString) else {
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
                name != [Constants.currentContext, Constants.currentContext] && name != [Constants.currentContext]
            else {
                continue
            }

            let pathType: FileType = POSIXFileType(rawFileType: Int32(entry.d_type))
            let child = joined(with: name)
            result.append((child, pathType))

            if recursive && pathType.isDirectory {
                result += try child.children(recursive: true)
            }
        }

        return result
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
}

#endif // !os(Windows)
