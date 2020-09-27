#if os(Windows)
import WinSDK
#else

#if canImport(Darwin)
import Darwin
#else
import Glibc
#endif // canImport(Darwin)

#endif // os(Windows)

/// An error returned by the OS.
public enum SystemError: Error, Equatable {
    case fileExists
    /// Unspecified error returned by the OS.
    case unspecified(errorCode: Code)

    public init(code: Code) {
        switch code {
        #if !os(Windows)
        case EEXIST:
            self = .fileExists
        #else
        case UInt32(ERROR_ALREADY_EXISTS):
            self = .fileExists
        #endif
        default:
            self = .unspecified(errorCode: code)
        }
    }

    #if os(Windows)
    public typealias Code = UInt32
    #else
    public typealias Code = Int32
    #endif

    var rawValue: Code {
        #if os(Windows)
        switch self {
        case .fileExists:
            return Code(ERROR_ALREADY_EXISTS)
        case let .unspecified(code):
            return code
        }
        #else

        switch self {
        case .fileExists:
            return EEXIST
        case let .unspecified(code):
            return code
        }
        #endif
    }
}
