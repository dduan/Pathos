#if os(Linux)
import Glibc
#else
import Darwin
#endif

public enum SystemError: Error {
    case unknown(errorNumber: Int32)
    case ioError
    case operationNotPermitted
    case permissionDenied
    case noSuchFileOrDirectory
    case notADirectory
    case badAddress
    case interuptedSystemCall
    case noSpaceLeftOnDevice
    case deviceOrRecourceIsBusy
    case readOnlyFileSystem
    case invalidArgument
    case fileExists

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
