/// OS agnostic information regarding type of the file.
protocol FileType {
    /// Whether the path is a file.
    var isFile: Bool { get }

    /// Whether the path is a directory.
    var isDirectory: Bool { get }

    /// Whether the path is a symlink.
    var isSymlink: Bool { get }
}
