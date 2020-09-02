#if canImport(Darwin)
import Darwin

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
