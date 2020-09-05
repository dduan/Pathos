#if !os(Windows)

#if canImport(Darwin)
import Darwin
#else
import Glibc
#endif // canImport(Darwin)

/// Represents the POSIX file permission bits. These bits determines read/write/execution access to a file as
/// well as some miscellaneous information.
public struct POSIXPermissions: OptionSet {
    /// The file permission as the native `mode_t` type. A de-abstraction to help interact with POSIX APIs directly.
    public var rawValue: mode_t

    /// Creates a `FilePermission` from native `mode_t`.
    public init(rawValue: mode_t) {
        self.rawValue = rawValue & 0o7777
    }

    /// This is equivalent to `[.ownerRead, .ownerWrite, .ownerExecute]` (`S_IRWXU`).
    public static let ownerAll = POSIXPermissions(rawValue: S_IRWXU)

    /// Read permission bit for the owner of the file (`S_IRUSR`).
    public static let ownerRead = POSIXPermissions(rawValue: S_IRUSR)

    /// Write permission bit for the owner of the file (`S_IWUSR`).
    public static let ownerWrite = POSIXPermissions(rawValue: S_IWUSR)

    /// Execute (for ordinary files) or search (for directories) permission bit for the owner of the file (`S_IXUSR`).
    public static let ownerExecute = POSIXPermissions(rawValue: S_IXUSR)

    /// This is equivalent to `[.groupRead, .groupWrite, .groupExecute]` (`S_IRWXG`).
    public static let groupAll = POSIXPermissions(rawValue: S_IRWXG)

    /// Read permission bit for the group owner of the file (`S_IRGRP`).
    public static let groupRead = POSIXPermissions(rawValue: S_IRGRP)

    /// Write permission bit for the group owner of the file (`S_IWGRP`).
    public static let groupWrite = POSIXPermissions(rawValue: S_IWGRP)

    /// Execute or search permission bit for the group owner of the file (`S_IXGRP`).
    public static let groupExecute = POSIXPermissions(rawValue: S_IXGRP)

    /// This is equivalent to `[.otherRead, .otherWrite, .otherExecute]` (`S_IRWXO`).
    public static let otherAll = POSIXPermissions(rawValue: S_IRWXO)

    /// Read permission bit for other users (`S_IROTH`).
    public static let otherRead = POSIXPermissions(rawValue: S_IROTH)

    /// Write permission bit for other users (`S_IWOTH`).
    public static let otherWrite = POSIXPermissions(rawValue: S_IWOTH)

    /// Execute or search permission bit for other users (`S_IXOTH`).
    public static let otherExecute = POSIXPermissions(rawValue: S_IXOTH)

    /// This is the set-user-ID on execute bit.
    /// See [Process Persona](http://www.gnu.org/software/libc/manual/html_node/Process-Persona.html#Process-Persona)
    /// to learm more.
    public static let setUserIDOnExecution = POSIXPermissions(rawValue: S_ISUID)

    /// This is the set-group-ID on execute bit
    /// See [Process Persona](http://www.gnu.org/software/libc/manual/html_node/Process-Persona.html#Process-Persona)
    /// to learm more.
    public static let setGroupIDOnExecution = POSIXPermissions(rawValue: S_ISGID)

    /// This is the sticky bit.
    ///
    /// For a directory it gives permission to delete a file in that directory only if you own that file.
    /// Ordinarily, a user can either delete all the files in a directory or cannot delete any of them (based on
    /// whether the user has write permission for the directory). The same restriction applies—you must have
    /// both write permission for the directory and own the file you want to delete. The one exception is that
    /// the owner of the directory can delete any file in the directory, no matter who owns it (provided the
    /// owner has given himself write permission for the directory). This is commonly used for the /tmp
    /// directory, where anyone may create files but not delete files created by other users.
    public static let saveSwappedTextAfterUser = POSIXPermissions(rawValue: S_ISVTX)
}

extension POSIXPermissions: ExpressibleByIntegerLiteral {
    public init(integerLiteral: UInt16) {
        rawValue = mode_t(integerLiteral)
    }
}

extension POSIXPermissions: Permissions {
    public var isReadOnly: Bool {
        get {
            !contains(.ownerWrite)
        }

        set {
            if newValue {
                remove(.ownerWrite)
            } else {
                insert(.ownerWrite)
            }
        }
    }
}

#endif // !os(Windows)
