#if canImport(Glibc)
import Glibc

extension Metadata {
    public init(mode: UInt16, size: UInt64, atime: timespec, mtime: timespec, btime: timespec) {
        let mode = mode_t(mode)
        fileType = POSIXFileType(rawMode: mode & S_IFMT)
        permissions = POSIXPermissions(rawValue: mode)
        self.size = Int64(size)
        accessed = FileTime(atime)
        modified = FileTime(mtime)
        created = FileTime(btime)
    }
}
#endif // canImport(Glibc)
