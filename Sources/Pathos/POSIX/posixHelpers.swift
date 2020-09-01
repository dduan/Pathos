#if !os(Windows)

#if canImport(Darwin)
import Darwin
#else
import Glibc
#endif

@inlinable
func _stat(at path: POSIXBinaryString) throws -> stat {
    var status = stat()
    if stat(path.withUnsafeBufferPointer { $0.baseAddress }, &status) != 0 {
        throw SystemError(code: errno)
    }

    return status
}

@inlinable
func _lstat(at path: POSIXBinaryString) throws -> stat {
    var status = stat()
    if lstat(path.withUnsafeBufferPointer { $0.baseAddress }, &status) != 0 {
        throw SystemError(code: errno)
    }

    return status
}

@inlinable
func _ifmt(_ status: stat) -> mode_t {
    status.st_mode & S_IFMT
}

#endif // !os(Windows)
