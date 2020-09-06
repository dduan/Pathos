#if canImport(Glibc)
import Glibc
import LinuxHelpers

extension Path {
    public func metadata(followSymlink: Bool = false) throws -> Metadata {
        let flags: UInt32 = UInt32(followSymlink ? 0 : AT_SYMLINK_NOFOLLOW)
        var mode: UInt16 = 0
        var size: UInt64 = 0
        var atime = timespec()
        var mtime = timespec()
        var btime = timespec()
        if linux_metadata(
            binaryString.cString,
            flags,
            &mode,
            &size,
            &atime,
            &mtime,
            &btime
        ) != 0 {
            throw SystemError(code: errno)
        }

        return Metadata(mode: mode, size: size, atime: atime, mtime: mtime, btime: btime)
    }
}
#endif // canImport(Glibc)
