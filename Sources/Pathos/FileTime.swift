#if os(Linux)
import Glibc
#elseif os(macOS)
import Darwin
#endif

/// A time interval broken down into seconds and nanoseconds.
public struct FileTime {
    /// The second component of the interval.
    public var second: Int
    /// The nanosecond component of the interval.
    public var nanosecond: Int

    /// Create a FileTime
    ///
    /// - Parameters:
    ///   - second: second component
    ///   - nanosecond: nanosecond component
    public init(second: Int, nanosecond: Int) {
        self.second = second
        self.nanosecond = nanosecond
    }
}

#if !os(Windows)
extension FileTime {
    /// Create a FileTime from POSIX timespec.
    ///
    /// - Parameter time: a timespec struct from `stat`.
    public init(_ time: timespec) {
        self.second = time.tv_sec
        self.nanosecond = time.tv_nsec
    }
}
#endif
