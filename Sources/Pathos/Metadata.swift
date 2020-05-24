#if os(Linux)
import Glibc
#elseif os(macOS)
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
#if !os(Windows)
    /// File permissions.
    public let permissions: FilePermission
#endif

    /// A data structure that encapsulates time-related attributes.
    public struct Time {
        /// Last time the file was accessed.
        public let accessed: FileTime
        /// Last time the file was modified.
        public let modified: FileTime
        /// Last time the file status changed.
        public let statusChanged: FileTime
    }
}

#if !os(Windows)
extension Metadata {
    /// Create metadata from a `stat` structure from POSIX.
    public init(_ stat: stat) {
        self.time = Time(stat)
        self.type = FileType(posixMode: _ifmt(stat))
        self.size = Int64(stat.st_size)
        self.permissions = FilePermission(rawValue: stat.st_mode)
    }

}
#endif

#if os(Linux)
extension Metadata.Time {
    /// Create Time from a `stat` structure from POSIX.
    public init(_ stat: stat) {
        self.accessed = FileTime(stat.st_atim)
        self.modified = FileTime(stat.st_mtim)
        self.statusChanged = FileTime(stat.st_ctim)
    }
}
#endif

#if os(macOS)
extension Metadata.Time {
    /// Create Time from a `stat` structure from POSIX.
    public init(_ stat: stat) {
        self.accessed = FileTime(stat.st_atimespec)
        self.modified = FileTime(stat.st_mtimespec)
        self.statusChanged = FileTime(stat.st_ctimespec)
    }
}
#endif
