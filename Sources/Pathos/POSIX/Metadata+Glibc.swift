#if canImport(Glibc)
import Glibc

extension Metadata {
    public init(_ stat: stat, _ btime: timespec) {
        fileType = POSIXFileType(rawMode: stat.st_mode & S_IFMT)
        permissions = POSIXPermissions(rawValue: stat.st_mode)
        size = Int64(stat.st_size)
        accessed = FileTime(stat.st_atim)
        modified = FileTime(stat.st_mtim)
        created = FileTime(btime)
    }
}
#endif // canImport(Glibc)
