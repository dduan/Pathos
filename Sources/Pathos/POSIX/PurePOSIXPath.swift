public struct PurePOSIXPath {
    private let parts = Box<Optional<PathParts<POSIXEncodingUnit>>>(nil)

    public let binaryString: POSIXBinaryString

    public init(cString: UnsafePointer<POSIXEncodingUnit>) {
        binaryString = POSIXBinaryString(cString: cString)
    }

    public init(_ string: String) {
        binaryString = POSIXBinaryString(string)
    }

    public var drive: POSIXBinaryString {
        parts.getOrCreateParts(forPOSIXFrom: binaryString).drive
    }

    public var root: POSIXBinaryString {
        parts.getOrCreateParts(forPOSIXFrom: binaryString).root
    }

    public var segments: Array<POSIXBinaryString> {
        parts.getOrCreateParts(forPOSIXFrom: binaryString).segments
    }

    public func parse() {
        _ = parts.getOrCreateParts(forPOSIXFrom: binaryString)
    }
}
