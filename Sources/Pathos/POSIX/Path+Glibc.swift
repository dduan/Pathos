#if canImport(Glibc)
import Glibc
import LinuxHelpers

extension Path {
    public func metadata(followSymlink: Bool = false) throws -> Metadata {
        let flags: UInt32 = UInt32(followSymlink ? 0 : AT_SYMLINK_NOFOLLOW)
        var status = stat()
        var btime = timespec()
        if _stat_with_btime(binaryString.cString!, flags, &status, &btime) != 0 {
            throw SystemError(code: errno)
        }

        return Metadata(status, btime)
    }
}
#endif // canImport(Glibc)
