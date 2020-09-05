extension Path {
    public func joined(with others: PathConvertible...) -> Self {
        joined(with: others)
    }

    public func joined(with others: [PathConvertible]) -> Self {
        Path(pure.joined(with: others))
    }

    public static func + (lhs: Self, rhs: Self) -> Self {
        lhs.joined(with: rhs)
    }

    public static func + (lhs: Self, rhs: PurePath) -> Self {
        lhs.joined(with: rhs)
    }

    public static func + (lhs: PurePath, rhs: Path) -> Self {
        Path(lhs.joined(with: rhs.pure))
    }

    public static func + (lhs: Self, rhs: String) -> Self {
        lhs.joined(with: rhs)
    }

    static func + (lhs: Self, rhs: BinaryString) -> Self {
        lhs.joined(with: rhs)
    }

    #if os(Windows)
    public static func + (lhs: String, rhs: Self) -> Self {
        Path(lhs.asWindowsPath.joined(with: rhs.pure))
    }

    static func + (lhs: BinaryString, rhs: Self) -> Self {
        Path(lhs.asWindowsPath.joined(with: rhs.pure))
    }
    #else
    public static func + (lhs: String, rhs: Self) -> Self {
        Path(lhs.asPOSIXPath.joined(with: rhs.pure))
    }

    static func + (lhs: BinaryString, rhs: Self) -> Self {
        Path(lhs.asPOSIXPath.joined(with: rhs.pure))
    }
    #endif // os(Windows)
}
