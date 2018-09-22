#if os(Linux)
import Glibc
#else
import Darwin
#endif

// Represents the POSIX file mode.
public struct FileMode: OptionSet {
    // TODO: missing docstring.
    public let rawValue: mode_t

    // TODO: missing docstring.
    public init(rawValue: mode_t) {
        self.rawValue = rawValue & 0o7777
    }

    // TODO: missing docstring.
    public static let ownerAll                 = FileMode(rawValue: S_IRWXU) /* RWX mask for owner */
    // TODO: missing docstring.
    public static let ownerRead                = FileMode(rawValue: S_IRUSR) /* R for owner */
    // TODO: missing docstring.
    public static let ownerWrite               = FileMode(rawValue: S_IWUSR) /* W for owner */
    // TODO: missing docstring.
    public static let ownerExecute             = FileMode(rawValue: S_IXUSR) /* X for owner */

    // TODO: missing docstring.
    public static let groupAll                 = FileMode(rawValue: S_IRWXG) /* RWX mask for group */
    // TODO: missing docstring.
    public static let groupRead                = FileMode(rawValue: S_IRGRP) /* R for group */
    // TODO: missing docstring.
    public static let groupWrite               = FileMode(rawValue: S_IWGRP) /* W for group */
    // TODO: missing docstring.
    public static let groupExecute             = FileMode(rawValue: S_IXGRP) /* X for group */

    // TODO: missing docstring.
    public static let otherAll                 = FileMode(rawValue: S_IRWXO) /* RWX mask for other */
    // TODO: missing docstring.
    public static let otherRead                = FileMode(rawValue: S_IROTH) /* R for other */
    // TODO: missing docstring.
    public static let otherWrite               = FileMode(rawValue: S_IWOTH) /* W for other */
    // TODO: missing docstring.
    public static let otherExecute             = FileMode(rawValue: S_IXOTH) /* X for other */

    // TODO: missing docstring.
    public static let setUserIDOnExecution     = FileMode(rawValue: S_ISUID) /* set user id on execution */
    // TODO: missing docstring.
    public static let setGroupIDOnExecution    = FileMode(rawValue: S_ISGID) /* set group id on execution */
    // TODO: missing docstring.
    public static let saveSwappedTextAfterUser = FileMode(rawValue: S_ISVTX) /* save swapped text even after use */
}

extension FileMode: ExpressibleByIntegerLiteral {
    public init(integerLiteral: UInt16) {
        self.rawValue = mode_t(integerLiteral)
    }
}
