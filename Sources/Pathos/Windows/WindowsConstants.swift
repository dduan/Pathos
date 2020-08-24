public enum WindowsConstants {
    /// Appropriate path separator native to the current operating system.
    public static let separatorByte: UInt16 = "\\".utf16.first!
    static let currentDirectoryByte: UInt16 = ".".utf16.first!
}
