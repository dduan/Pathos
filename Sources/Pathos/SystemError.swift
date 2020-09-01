/// An error returned by the OS.
public enum SystemError: Error {
    /// Unspecified error returned by the OS.
    case unspecified(errorCode: Code)

    public init(code: Code) {
        self = .unspecified(errorCode: code)
    }

    #if os(Windows)
    public typealias Code = UInt32
    #else
    public typealias Code = Int32
    #endif
}
