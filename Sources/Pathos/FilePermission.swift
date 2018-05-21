import Darwin

public struct FilePermission: OptionSet {
    public let rawValue: mode_t

    public init(rawValue: mode_t) {
        self.rawValue = rawValue & 0o7777
    }

    public static let ownerAll                 = FilePermission(rawValue: S_IRWXU) /* RWX mask for owner */
    public static let ownerRead                = FilePermission(rawValue: S_IRUSR) /* R for owner */
    public static let ownerWrite               = FilePermission(rawValue: S_IWUSR) /* W for owner */
    public static let ownerExecute             = FilePermission(rawValue: S_IXUSR) /* X for owner */

    public static let groupAll                 = FilePermission(rawValue: S_IRWXG) /* RWX mask for group */
    public static let groupRead                = FilePermission(rawValue: S_IRGRP) /* R for group */
    public static let groupWrite               = FilePermission(rawValue: S_IWGRP) /* W for group */
    public static let groupExecute             = FilePermission(rawValue: S_IXGRP) /* X for group */

    public static let otherAll                 = FilePermission(rawValue: S_IRWXO) /* RWX mask for other */
    public static let otherRead                = FilePermission(rawValue: S_IROTH) /* R for other */
    public static let otherWrite               = FilePermission(rawValue: S_IWOTH) /* W for other */
    public static let otherExecute             = FilePermission(rawValue: S_IXOTH) /* X for other */

    public static let setUserIDOnExecution     = FilePermission(rawValue: S_ISUID) /* set user id on execution */
    public static let setGroupIDOnExecution    = FilePermission(rawValue: S_ISGID) /* set group id on execution */
    public static let saveSwappedTextAfterUser = FilePermission(rawValue: S_ISVTX) /* save swapped text even after use */
}

extension FilePermission: ExpressibleByIntegerLiteral {
    public init(integerLiteral: mode_t) {
        self.rawValue = integerLiteral
    }
}
