#if canImport(Darwin)
import Darwin

extension Metadata {
    public init(_ stat: stat) {
        fileType = POSIXFileType(rawMode: stat.st_mode & S_IFMT)
        permissions = POSIXPermissions(rawValue: stat.st_mode)
        size = stat.st_size
        accessed = FileTime(stat.st_atimespec)
        modified = FileTime(stat.st_mtimespec)
        created = FileTime(stat.st_birthtimespec)
    }
}
#endif
