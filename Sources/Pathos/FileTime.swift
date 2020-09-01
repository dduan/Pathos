/// A time interval broken down into seconds and nanoseconds. This is used to represent a point in time since 1970-01-01 00:00:00 UTC.
public struct FileTime {
    /// The second component of the interval.
    public var seconds: Int

    /// The nanosecond component of the interval.
    public var nanoseconds: Int
}
