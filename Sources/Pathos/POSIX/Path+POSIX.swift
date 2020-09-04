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
                { $0.bindMemory(to: POSIXEncodingUnit.self).baseAddress.map(String.init(cString:))
                }
            ),
                name != ".." && name != "."
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
}

#endif // !os(Windows)
