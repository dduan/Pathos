#if os(Linux)
import Glibc
#else
import Darwin
#endif

// TODO: missing docstring.
public enum SystemError: Error {
    // TODO: missing docstring.
    case unknown(errorNumber: Int32)
    // TODO: missing docstring.
    case ioError
    // TODO: missing docstring.
    case operationNotPermitted
    // TODO: missing docstring.
    case permissionDenied
    // TODO: missing docstring.
    case noSuchFileOrDirectory
    // TODO: missing docstring.
    case notADirectory
    // TODO: missing docstring.
    case badAddress
    // TODO: missing docstring.
    case interuptedSystemCall
    // TODO: missing docstring.
    case noSpaceLeftOnDevice
    // TODO: missing docstring.
    case deviceOrRecourceIsBusy
    // TODO: missing docstring.
    case readOnlyFileSystem
    // TODO: missing docstring.
    case invalidArgument
    // TODO: missing docstring.
    case fileExists

    // TODO: missing docstring.
    public init(posixErrorCode: Int32) {
        switch posixErrorCode {
        case EPERM  : self = .operationNotPermitted
        case EIO    : self = .ioError
        case EACCES : self = .permissionDenied
        case ENOENT : self = .noSuchFileOrDirectory
        case ENOTDIR: self = .notADirectory
        case EFAULT : self = .badAddress
        case EINTR  : self = .interuptedSystemCall
        case ENOSPC : self = .noSpaceLeftOnDevice
        case EBUSY  : self = .deviceOrRecourceIsBusy
        case EROFS  : self = .readOnlyFileSystem
        case EINVAL : self = .invalidArgument
        case EEXIST : self = .fileExists
        default     : self = .unknown(errorNumber: posixErrorCode)
        }
    }
}
