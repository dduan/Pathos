/// OS agnostic permissions for a file path.
public protocol Permissions {
    /// Whether the file is read only.
    var isReadOnly: Bool { get }
}
