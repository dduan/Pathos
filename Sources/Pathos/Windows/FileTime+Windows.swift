#if os(Windows)
import WinSDK

private let kSecondsFromWindowsEpoch: UInt64 = 11_644_473_600
private let k100NanosIn1Second: UInt64 = 10_000_000
extension FileTime {
    /// Converts to Unix epoch and in-library representation.
    ///
    /// Windows `FILETIME` is a 64-bit value representing the number of 100-nanosecond intervals since 1601-1-1 UTC.
    public init(_ time: FILETIME) {
        let hundredNanos = UInt64(time.dwHighDateTime) << 32 | UInt64(time.dwLowDateTime)
        let hundredNanosSinceUnixEpoch = hundredNanos - kSecondsFromWindowsEpoch * k100NanosIn1Second
        seconds = Int(hundredNanosSinceUnixEpoch / k100NanosIn1Second)
        nanoseconds = Int(hundredNanosSinceUnixEpoch % k100NanosIn1Second * 100)
    }
}

#endif // os(Windows)
