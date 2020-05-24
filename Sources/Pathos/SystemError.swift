#if os(Linux)
import Glibc
#elseif os(macOS)
import Darwin
#endif

/// POSIX errors.
public enum SystemError: Error {
    /// A raw, uncategorized POSIX error. `SystemError` includes some but not all POSIX errors.
    case unknown(errorNumber: Int32)
    /// Input/output error (POSIX `EIO`).
    case ioError
    /// Operation not permitted (POSIX `EPERM`).
    case operationNotPermitted
    /// Permission denied (POSIX `EACCES`).
    case permissionDenied
    /// No such file or directory (POSIX `ENOENT`).
    case noSuchFileOrDirectory
    /// Not a directory (POSIX `ENOTDIR`).
    case notADirectory
    /// Bad address (POSIX `EFAULT`).
    case badAddress
    /// Interrupted system call (POSIX `EINTR`).
    case interuptedSystemCall
    /// No space left on device (POSIX `ENOSPC`).
    case noSpaceLeftOnDevice
    /// Device or resource is busy (POSIX `EBUSY`).
    case deviceOrRecourceIsBusy
    /// Read-only file system (POSIX `EROFS`).
    case readOnlyFileSystem
    /// Invalid argument (POSIX `EINVAL`).
    case invalidArgument
    /// File exists (POSIX `EEXIST`).
    case fileExists
}

#if !os(Windows)
extension SystemError {
    /// Create a `SystemError` from a code that corresponds to a POSIX error.
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
#endif
