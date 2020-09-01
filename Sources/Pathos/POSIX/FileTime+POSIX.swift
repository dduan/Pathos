#if !os(Windows)

#if canImport(Darwin)
import Darwin
#else
import Glibc
#endif // canImport(Darwin)
extension FileTime {
    /// Create a FileTime from POSIX timespec.
    ///
    /// - Parameter time: a timespec struct from `stat`.
    public init(_ time: timespec) {
        seconds = time.tv_sec
        nanoseconds = time.tv_nsec
    }
}

#endif // !os(Windows)
