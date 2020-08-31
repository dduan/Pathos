public struct Path: Equatable, Hashable {
    #if os(Windows)
    let pure: PureWindowsPath
    #else
    let pure: PurePOSIXPath
    #endif

    public var binaryString: BinaryString { pure.binaryString }

    public init(cString: UnsafePointer<NativeEncodingUnit>) {
        pure = .init(cString: cString)
    }

    public init(_ string: String) {
        pure = .init(string)
    }

    public init(_ binary: BinaryString) {
        pure = PurePath(binary)
    }

    public init(_ pure: PurePath) {
        self.pure = pure
    }

    public var drive: BinaryString { pure.drive }

    public var root: BinaryString { pure.root }

    public var segments: Array<BinaryString> { pure.segments }

    public func parse() {
        pure.parse()
    }

    public var name: BinaryString? {
        pure.name
    }

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

    public static func + (lhs: Self, rhs: BinaryString) -> Self {
        lhs.joined(with: rhs)
    }

    #if os(Windows)
    public static func + (lhs: String, rhs: Self) -> Self {
        Path(lhs.asWindowsPath.joined(with: rhs.pure))
    }

    public static func + (lhs: BinaryString, rhs: Self) -> Self {
        Path(lhs.asWindowsPath.joined(with: rhs.pure))
    }
    #else
    public static func + (lhs: String, rhs: Self) -> Self {
        Path(lhs.asPOSIXPath.joined(with: rhs.pure))
    }

    public static func + (lhs: BinaryString, rhs: Self) -> Self {
        Path(lhs.asPOSIXPath.joined(with: rhs.pure))
    }
    #endif // os(Windows)
}

extension Path: CustomStringConvertible {
    public var description: String {
        binaryString.description
    }
}
