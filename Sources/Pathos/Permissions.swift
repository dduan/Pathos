/// OS agnostic permissions for a file path.
protocol Permissions {
    /// Whether the file is read only.
    var isReadOnly: Bool { get }
}
