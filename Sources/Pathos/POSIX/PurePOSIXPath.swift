public struct PurePOSIXPath {
    private let partsStorage = Box<Optional<PathParts<POSIXEncodingUnit>>>(nil)
    private var parts: PathParts<POSIXEncodingUnit> {
        partsStorage.getOrCreateParts(binaryString)
    }

    public let binaryString: POSIXBinaryString

    public init(cString: UnsafePointer<POSIXEncodingUnit>) {
        binaryString = POSIXBinaryString(cString: cString)
    }

    public init(_ string: String) {
        binaryString = POSIXBinaryString(string)
    }

    public init(_ binary: POSIXBinaryString) {
        binaryString = binary
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
        _ = partsStorage.getOrCreateParts(binaryString)
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

    public static func + (lhs: Self, rhs: POSIXPathConvertible) -> Self {
        lhs.joined(with: rhs)
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
