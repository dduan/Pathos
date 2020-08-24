public enum POSIXConstants {
    /// Appropriate path separator native to the current operating system.
    public static let separatorByte: CChar = "/".utf8CString[0]
    static let currentDirectoryByte: CChar = ".".utf8CString[0]
}
