// TODO: Missing implementation.
// TODO: Missing unit tests.
// TODO: Missing docstring.
public func glob(_ pattern: String) -> [String] {
    fatalError("unimplemented")
}

extension PathRepresentable {
    // TODO: Missing unit tests.
    // TODO: Missing docstring.
    public static func glob(_ pattern: String) -> [Self] {
        return Pathos.glob(_:)(pattern).map(Self.init)
    }
}
