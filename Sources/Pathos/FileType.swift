#if os(Linux)
import Glibc
#else
import Darwin
#endif

// TODO: missing docstring
public enum FileType: Int, Equatable, Codable {
    case unknown
    case pipe
    case characterDevice
    case directory
    case blockDevice
    case file
    case symbolicLink
    case socket

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
            self = .symbolicLink
        case Int32(DT_SOCK):
            self = .socket
        default:
            self = .unknown
        }
    }

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
            self = .symbolicLink
        case S_IFSOCK:
            self = .socket
        default:
            self = .unknown
        }
    }

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
        case .socket:
            return Int32(DT_SOCK)
        }
    }

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
        case .socket:
            return S_IFSOCK
        }
    }
}

