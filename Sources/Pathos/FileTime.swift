/// A time interval broken down into seconds and nanoseconds. This is used to represent a point in
/// time since 1970-01-01 00:00:00 UTC
public struct FileTime {
    /// Number of seconds since 1970-01-01 00:00:00 UTC
    public var seconds: Int

    /// Number of nanoseconds since `seconds`.
    public var nanoseconds: Int
}
