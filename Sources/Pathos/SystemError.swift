/// An error returned by the OS.
public enum SystemError: Error {
    /// Unspecified error returned by the OS.
    case unspecified(errorCode: Code)

    public init(errorCode: Code) {
        self = .unspecified(errorCode: errorCode)
    }

    #if os(Windows)
    public typealias Code = UInt32
    #else
    public typealias Code = Int32
    #endif
}
