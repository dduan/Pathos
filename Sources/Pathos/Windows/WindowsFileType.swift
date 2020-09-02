#if os(Windows)
public enum WindowsFileType: Equatable {
    case file
    case directory
    case symlink
}

extension WindowsFileType: FileType {
    public var isFile: Bool { self == .file }
    public var isDirectory: Bool { self == .directory }
    public var isSymlink: Bool { self == .symlink }
}
#endif
