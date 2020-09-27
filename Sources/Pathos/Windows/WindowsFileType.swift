#if os(Windows)
public struct WindowsFileType: Equatable, FileType {
    public let isFile: Bool
    public let isDirectory: Bool
    public let isSymlink: Bool
}
#endif
