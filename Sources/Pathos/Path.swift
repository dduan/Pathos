// Default conformation to `PathRepresentable`. See `PathRepresentable` for more.
public struct Path: Codable, Equatable, Hashable {
    public let pathString: String

    public init(_ string: String) {
        self.pathString = string
    }
}

extension Path: PathRepresentable {}
