public struct PurePOSIXPath {
    private let parts = Box<Optional<PathParts>>(nil)

    public let bytes: Bytes

    public init(cString: UnsafePointer<CChar>) {
        bytes = Bytes(cString: cString)
    }

    public init(_ string: String) {
        bytes = Bytes(string)
    }

    public var drive: Bytes {
        parts.getOrCreateParts(from: bytes, isWindows: false).drive
    }

    public var root: Bytes {
        parts.getOrCreateParts(from: bytes, isWindows: false).root
    }

    public var segments: Array<Bytes> {
        parts.getOrCreateParts(from: bytes, isWindows: false).segments
    }

    public func parse() {
        _ = parts.getOrCreateParts(from: bytes, isWindows: false)
    }
}
