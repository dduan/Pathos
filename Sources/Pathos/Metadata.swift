/// OS agnostic information about a file, besides the file itself.
public struct Metadata {
    /// What kind of file is it.
    public let fileType: FileType

    /// What permission does current process has regarding the file.
    public let permissions: Permissions

    /// Length of the file in bytes.
    public let size: Int64

    /// Last time the file was accessed.
    public let accessed: FileTime

    /// Last time the file was modified.
    public let modified: FileTime

    /// Time of creation for the file.
    public let created: FileTime
}
