#if os(Linux)
import Glibc
#else
import Darwin
#endif

/// Type of files found in standards such as POSIX.
/// NOTE: a directory is a type of file as everything else.
public enum FileType: Int, Equatable, Codable {
    /// Unknown type.
    case unknown
    /// FIFO pipe.
    case pipe
    /// Character device, or character special file.
    case characterDevice
    /// Directory.
    case directory
    /// Block special files.
    case blockDevice
    /// A regular file.
    case file
    /// A symbolic link, or symlink.
    @available(*, deprecated, renamed: "symlink")
    case symbolicLink
    /// A symbolic link, or symlink.
    case symlink
    /// A socket.
    case socket

    /// Creates a `FileType` from a POSIX file type such as `DT_REG`.
    public init(posixFileType: Int32) {
        switch posixFileType {
        case Int32(DT_FIFO):
            self = .pipe
        case Int32(DT_CHR):
            self = .characterDevice
        case Int32(DT_DIR):
            self = .directory
        case Int32(DT_BLK):
            self = .blockDevice
        case Int32(DT_REG):
            self = .file
        case Int32(DT_LNK):
            self = .symlink
        case Int32(DT_SOCK):
            self = .socket
        default:
            self = .unknown
        }
    }

    /// Creates a `FileType` from a POSIX inode protection mode (`stat.st_mode`) such as `S_IFREG`.
    public init(posixMode: mode_t) {
        switch posixMode {
        case S_IFIFO:
            self = .pipe
        case S_IFCHR:
            self = .characterDevice
        case S_IFDIR:
            self = .directory
        case S_IFBLK:
            self = .blockDevice
        case S_IFREG:
            self = .file
        case S_IFLNK:
            self = .symlink
        case S_IFSOCK:
            self = .socket
        default:
            self = .unknown
        }
    }

    /// A corresponding POSIX file type such as `DT_REG`.
    public var posixFileType: Int32 {
        switch self {
        case .unknown:
            return Int32(DT_UNKNOWN)
        case .pipe:
            return Int32(DT_FIFO)
        case .characterDevice:
            return Int32(DT_CHR)
        case .directory:
            return Int32(DT_DIR)
        case .blockDevice:
            return Int32(DT_BLK)
        case .file:
            return Int32(DT_REG)
        case .symbolicLink:
            return Int32(DT_LNK)
        case .symlink:
            return Int32(DT_LNK)
        case .socket:
            return Int32(DT_SOCK)
        }
    }

    /// A corresponding POSIX inode protection mode value (`stat.st_mode`) such as `S_IFREG`.
    public var posixMode: mode_t {
        switch self {
        case .unknown:
            return 0
        case .pipe:
            return S_IFIFO
        case .characterDevice:
            return S_IFCHR
        case .directory:
            return S_IFDIR
        case .blockDevice:
            return S_IFBLK
        case .file:
            return S_IFREG
        case .symbolicLink:
            return S_IFLNK
        case .symlink:
            return S_IFLNK
        case .socket:
            return S_IFSOCK
        }
    }
}

