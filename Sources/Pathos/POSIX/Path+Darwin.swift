#if canImport(Darwin)

@inlinable
private func _ifmt(_ status: stat) -> mode_t {
    status.st_mode & S_IFMT
}

@inlinable
private func _stat(at path: POSIXBinaryString) throws -> stat {
    var status = stat()
    if stat(path.withUnsafeBufferPointer { $0.baseAddress }, &status) != 0 {
        throw SystemError(code: errno)
    }

    return status
}

@inlinable
private func _lstat(at path: POSIXBinaryString) throws -> stat {
    var status = stat()
    if lstat(path.withUnsafeBufferPointer { $0.baseAddress }, &status) != 0 {
        throw SystemError(code: errno)
    }

    return status
}

extension Path {
    public func metadata(followSymlink: Bool = false) throws -> Metadata? {
        try Metadata(followSymlink ? _stat(at: binaryString) : _lstat(at: binaryString))
    }
}
#endif // canImport(Darwin)
