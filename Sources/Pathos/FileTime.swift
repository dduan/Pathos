/// A time interval broken down into seconds and nanoseconds. This is used to represent a point in time since 1970-01-01 00:00:00 UTC.
struct FileTime {
    /// The second component of the interval.
    var seconds: Int64

    /// The nanosecond component of the interval.
    var nanoseconds: Int64
}
