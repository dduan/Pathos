public struct PurePOSIXPath {
    @LazyBoxed
    private var parts: Path.Parts

    let binaryString: POSIXBinaryString

    init(_ binary: POSIXBinaryString) {
        binaryString = binary
        _parts = .init { Path.Parts(forPOSIXWithBinary: binary) }
    }

    public init(cString: UnsafePointer<CChar>) {
        self.init(POSIXBinaryString(cString: cString))
    }

    public init(_ string: String) {
        self.init(POSIXBinaryString(string))
    }

    public var drive: String? {
        parts.drive
    }

    public var root: String? {
        parts.root
    }

    public var segments: Array<String> {
        parts.segments
    }

    public func parse() {
        _ = parts
    }

    public var name: String? {
        parts.segments.last
    }

    public var `extension`: String? {
        parts.extension
    }

    public var extensions: [String] {
        parts.extensions
    }

    public func joined(with paths: POSIXPathConvertible...) -> Self {
        joined(with: paths)
    }

    public func joined(with paths: [POSIXPathConvertible]) -> Self {
        let paths = [self] + paths.map(\.asPOSIXPath)
        var resultString = ContiguousArray<POSIXEncodingUnit>()
        for path in paths {
            if path.binaryString.first == POSIXConstants.binaryPathSeparator {
                resultString = path.binaryString
            } else if resultString.isEmpty || resultString.last == POSIXConstants.binaryPathSeparator {
                resultString += path.binaryString
            } else {
                resultString += [POSIXConstants.binaryPathSeparator] + path.binaryString
            }
        }

        return Self(resultString)
    }

    public var isAbsolute: Bool {
        root != nil
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

    public func relative(to other: POSIXPathConvertible) -> PurePOSIXPath {
        let other = other.asPOSIXPath
        let all = relativeSegments(from: segments, to: other.segments)

        if all.isEmpty {
            return PurePOSIXPath(".")
        } else {
            return PurePOSIXPath(all.joined(separator: "\(POSIXConstants.pathSeparator)"))
        }
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

extension Collection where Element: Equatable {
    func commonPrefix(with other: Self) -> Self.SubSequence {
        let limit = Swift.min(endIndex, other.endIndex)
        var end = startIndex
        while end < limit && self[end] == other[end] {
            end = index(after: end)
        }

        return self[startIndex ..< end]
    }
}
