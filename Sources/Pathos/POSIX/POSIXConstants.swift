public enum POSIXConstants {
    /// Appropriate path separator native to the current operating system.
    public static let binaryPathSeparator: CChar = "/".utf8CString[0]
    public static let pathSeparator: Character = "/"
    static let binaryCurrentContext: CChar = ".".utf8CString[0]
    static var currentContext: Character = "."
}
