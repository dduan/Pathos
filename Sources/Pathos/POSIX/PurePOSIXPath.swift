public struct PurePOSIXPath {
    private let partsStorage = Box<Optional<PathParts<POSIXEncodingUnit>>>(nil)
    private var parts: PathParts<POSIXEncodingUnit> {
        partsStorage.getOrCreateParts(forPOSIXFrom: binaryString)
    }

    public let binaryString: POSIXBinaryString

    public init(cString: UnsafePointer<POSIXEncodingUnit>) {
        binaryString = POSIXBinaryString(cString: cString)
    }

    public init(_ string: String) {
        binaryString = POSIXBinaryString(string)
    }

    public var drive: POSIXBinaryString {
        parts.drive
    }

    public var root: POSIXBinaryString {
        parts.root
    }

    public var segments: Array<POSIXBinaryString> {
        parts.segments
    }

    public func parse() {
        _ = partsStorage.getOrCreateParts(forPOSIXFrom: binaryString)
    }

    public var name: POSIXBinaryString? {
        parts.segments.last
    }
}
