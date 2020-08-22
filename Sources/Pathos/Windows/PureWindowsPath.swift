public struct PureWindowsPath {
    private let parts = Box<Optional<PathParts>>(nil)

    public let bytes: Bytes

    public init(cString: UnsafePointer<CChar>) {
        bytes = Bytes(cString: cString)
    }

    public init(_ string: String) {
        bytes = Bytes(string)
    }

    public var drive: Bytes {
        parts.getOrCreateParts(from: bytes).drive
    }

    public var root: Bytes {
        parts.getOrCreateParts(from: bytes).root
    }

    public var segments: Array<Bytes> {
        parts.getOrCreateParts(from: bytes).segments
    }

    public func parse() {
        _ = parts.getOrCreateParts(from: bytes)
    }
}
