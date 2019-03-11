// Default conformation to `PathRepresentable`. See `PathRepresentable` for more.
public struct Path: PathRepresentable {
    public let pathString: String

    public init(_ string: String) {
        self.pathString = string
    }
}
