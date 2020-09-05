public enum POSIXConstants {
    /// Appropriate path separator native to the current operating system.
    public static let pathSeparator: CChar = "/".utf8CString[0]
    static let currentContext: CChar = ".".utf8CString[0]
}
