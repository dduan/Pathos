/// OS agnostic information about a file, besides the file itself.
struct Metadata {
    /// What kind of file is it.
    let fileType: FileType

    /// What permission does current process has regarding the file.
    let permissions: Permissions

    /// Length of the file in bytes.
    let size: Int

    /// Last time the file was accessed.
    let accessed: FileTime

    /// Last time the file was modified.
    let modified: FileTime

    /// Time of creation for the file.
    let created: FileTime
}
