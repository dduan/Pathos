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

    public static func + (lhs: Self, rhs: PathConvertible) -> Self {
        lhs.joined(with: rhs)
    }
}
