public struct PurePOSIXPath {
    @LazyBoxed
    private var parts: Path.Parts

    let binaryPath: POSIXBinaryString

    init(_ binary: POSIXBinaryString) {
        binaryPath = binary
        _parts = LazyBoxed { Path.Parts(forPOSIXWithBinary: binary) }
    }

    init(root: String?, segments: [String]) {
        self.init((root ?? "") + segments.joined(separator: [POSIXConstants.pathSeparator]))
    }

    init(parts: Path.Parts) {
        self.init(
            root: parts.root,
            segments: parts.segments
        )
        _parts.wrappedValue = parts
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

    public var name: String? {
        parts.segments.last
    }

    public var `extension`: String? {
        parts.extension
    }

    public var extensions: [String] {
        parts.extensions
    }

    public var base: Self {
        Self(parts: parts.base)
    }

    public func joined(with paths: POSIXPathConvertible...) -> Self {
        joined(with: paths)
    }

    public func joined(with paths: [POSIXPathConvertible]) -> Self {
        let paths = [self] + paths.map(\.asPOSIXPath)
        var resultString = ContiguousArray<POSIXEncodingUnit>()
        for path in paths {
            if path.binaryPath.content.first == POSIXConstants.binaryPathSeparator {
                resultString = .init(path.binaryPath.content)
            } else if resultString.isEmpty || resultString.last == POSIXConstants.binaryPathSeparator {
                resultString += path.binaryPath.content
            } else {
                resultString += [POSIXConstants.binaryPathSeparator] + path.binaryPath.content
            }
        }

        return Self(CString(nulTerminatedStorage: resultString + [0]))
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

    public var parent: PurePOSIXPath {
        let newParts = parts.parentParts
        return PurePOSIXPath(root: newParts.root, segments: newParts.segments)
    }

    public var parents: AnySequence<PurePOSIXPath> {
        var parents = Path.Parts.Parents(initialParts: parts)
        return AnySequence<PurePOSIXPath> {
            AnyIterator {
                parents.next().map { PurePOSIXPath(root: $0.root, segments: $0.segments) }
            }
        }
    }

    public var normal: PurePOSIXPath {
        PurePOSIXPath(parts: parts.normalized)
    }

    var isEmpty: Bool {
        parts.isEmpty
    }
}

extension PurePOSIXPath: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }
}

extension PurePOSIXPath: CustomStringConvertible {
    public var description: String {
        binaryPath.description
    }
}

extension PurePOSIXPath: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.binaryPath == rhs.binaryPath
    }
}

extension PurePOSIXPath: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(binaryPath)
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
