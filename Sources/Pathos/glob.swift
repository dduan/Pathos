// TODO: Missing implementation.
// TODO: Missing unit tests.
// TODO: Missing docstring.
public func glob(withPattern pattern: String) -> [String] {
    fatalError("unimplemented")
}

extension PathRepresentable {
    // TODO: Missing unit tests.
    // TODO: Missing docstring.
    public static func glob(withPattern pattern: String) -> [Self] {
        return Pathos.glob(withPattern:)(pattern).map(Self.init)
    }

    // TODO: Missing unit tests.
    // TODO: Missing docstring.
    public func glob(withPattern pattern: String) -> [Self] {
        return Self.glob(withPattern: self.join(with: Self(string: pattern)).pathString)
    }
}
