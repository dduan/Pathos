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

    public func metadata(followSymlink: Bool = false) throws -> Metadata? {
        try Metadata(followSymlink ? _stat(at: binaryString) : _lstat(at: binaryString))
    }
}

#endif // !os(Windows)
