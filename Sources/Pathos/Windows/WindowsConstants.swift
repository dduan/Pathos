public enum WindowsConstants {
    /// Appropriate path separator native to the current operating system.
    public static let binaryPathSeparator: UInt16 = "\\".utf16.first!
    public static let pathSeparator: Character = "\\"
    static let binaryCurrentContext: UInt16 = ".".utf16.first!
    static var currentContextCharacter: Character = "."
    static var currentContext = "."
}
