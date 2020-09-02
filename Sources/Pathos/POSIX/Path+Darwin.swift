#if canImport(Darwin)
import Darwin

private func _stat(at path: POSIXBinaryString) throws -> stat {
    var status = stat()
    if stat((path + [0]).withUnsafeBufferPointer { $0.baseAddress }, &status) != 0 {
        throw SystemError(code: errno)
    }

    return status
}

private func _lstat(at path: POSIXBinaryString) throws -> stat {
    var status = stat()
    if lstat((path + [0]).withUnsafeBufferPointer { $0.baseAddress }, &status) != 0 {
        throw SystemError(code: errno)
    }

    return status
}

extension Path {
    public func metadata(followSymlink: Bool = false) throws -> Metadata {
        var status = stat()
        let correctStat = followSymlink ? stat : lstat
        if correctStat(binaryString.cString, &status) != 0 {
            throw SystemError(code: errno)
        }

        return Metadata(status)
    }
}
#endif // canImport(Darwin)
