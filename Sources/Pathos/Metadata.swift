#if os(Linux)
import Glibc
#else
import Darwin
#endif

/// Data structure for path's metadata such as access permissions, modification times, file size etc.
public struct Metadata {
    /// Time attributes.
    public let time: Time
    /// File type.
    public let type: FileType
    /// File size.
    public let size: Int64
    /// File permissions.
    public let permissions: FilePermission

    /// Create metadata from a `stat` structure from POSIX.
    public init(_ stat: stat) {
        self.time = Time(stat)
        self.type = FileType(posixMode: _ifmt(stat))
        self.size = Int64(stat.st_size)
        self.permissions = FilePermission(rawValue: stat.st_mode)
    }

    /// A data structure that encapsulates time-related attributes.
    public struct Time {
        /// Last time the file was accessed.
        let accessed: FileTime
        /// Last time the file was modified.
        let modified: FileTime
        /// Last time the file status changed.
        let statusChanged: FileTime

        /// Create Time from a `stat` structure from POSIX.
        public init(_ stat: stat) {
#if os(Linux)
        self.accessed = FileTime(stat.st_atim)
        self.modified = FileTime(stat.st_mtim)
        self.statusChanged = FileTime(stat.st_ctim)
#else
        self.accessed = FileTime(stat.st_atimespec)
        self.modified = FileTime(stat.st_mtimespec)
        self.statusChanged = FileTime(stat.st_ctimespec)
#endif
        }
    }
}
