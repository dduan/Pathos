public struct PurePOSIXPath {
    @LazyBoxed
    private var parts: PathParts<POSIXEncodingUnit>

    public let binaryString: POSIXBinaryString

    public init(_ binary: POSIXBinaryString) {
        binaryString = binary
        _parts = .init { PathParts(forPOSIXWithBinary: binary) }
    }

    public init(cString: UnsafePointer<POSIXEncodingUnit>) {
        self.init(POSIXBinaryString(cString: cString))
    }

    public init(_ string: String) {
        self.init(POSIXBinaryString(string))
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
        _ = parts
    }

    public var name: POSIXBinaryString? {
        parts.segments.last
    }

    public func joined(with paths: POSIXPathConvertible...) -> Self {
        joined(with: paths)
    }

    public func joined(with paths: [POSIXPathConvertible]) -> Self {
        let paths = [self] + paths.map(\.asPOSIXPath)
        var resultString = ContiguousArray<POSIXEncodingUnit>()
        for path in paths {
            if path.binaryString.first == POSIXConstants.separatorByte {
                resultString = path.binaryString
            } else if resultString.isEmpty || resultString.last == POSIXConstants.separatorByte {
                resultString += path.binaryString
            } else {
                resultString += [POSIXConstants.separatorByte] + path.binaryString
            }
        }

        return Self(resultString)
    }

    public var isAbsolute: Bool {
        !root.isEmpty
    }

    public static func + (lhs: Self, rhs: Self) -> Self {
        lhs.joined(with: rhs)
    }

    public static func + (lhs: Self, rhs: POSIXPathConvertible) -> Self {
        lhs.joined(with: rhs)
    }

    public static func + (lhs: POSIXPathConvertible, rhs: Self) -> Self {
        lhs.asPOSIXPath.joined(with: rhs)
    }
}

extension PurePOSIXPath: CustomStringConvertible {
    public var description: String {
        binaryString.description
    }
}

extension PurePOSIXPath: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.binaryString == rhs.binaryString
    }
}

extension PurePOSIXPath: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(binaryString)
    }
}
