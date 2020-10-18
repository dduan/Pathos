public struct PureWindowsPath {
    @LazyBoxed
    private var parts: Path.Parts

    let binaryPath: WindowsBinaryString

    init(_ binary: WindowsBinaryString) {
        binaryPath = binary
        _parts = .init { Path.Parts(forWindowsWithBinary: binary) }
    }

    init(drive: String?, root: String?, segments: [String]) {
        self.init(
            (drive ?? "") + (root ?? "") + segments.joined(separator: [WindowsConstants.pathSeparator]))
    }

    init(parts: Path.Parts) {
        self.init(
            drive: parts.drive,
            root: parts.root,
            segments: parts.segments
        )
        _parts.wrappedValue = parts
    }

    public init(cString: UnsafePointer<UInt16>) {
        self.init(WindowsBinaryString(cString: cString))
    }

    public init(_ string: String) {
        self.init(WindowsBinaryString(string))
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

    public func joined(with others: WindowsPathConvertible...) -> Self {
        joined(with: others)
    }

    public func joined(with paths: [WindowsPathConvertible]) -> Self {
        let paths = [self] + paths.map(\.asWindowsPath)
        var drive: String?
        var root: String?
        var segments = [String]()

        for path in paths {
            if let pathDrive = path.drive {
                drive = pathDrive
                root = path.root
                segments = path.segments
            } else if let pathRoot = path.root {
                root = pathRoot
                segments = path.segments
            } else {
                segments += path.segments
            }
        }

        return PureWindowsPath(drive: drive, root: root, segments: segments)
    }

    public var isAbsolute: Bool {
        root != nil && drive != nil
    }

    public static func + (lhs: Self, rhs: Self) -> Self {
        lhs.joined(with: rhs)
    }

    public static func + (lhs: Self, rhs: WindowsPathConvertible) -> Self {
        lhs.joined(with: rhs)
    }

    public static func + (lhs: WindowsPathConvertible, rhs: Self) -> Self {
        lhs.asWindowsPath.joined(with: rhs)
    }

    public func relative(to other: WindowsPathConvertible) -> PureWindowsPath {
        let other = other.asWindowsPath
        let all = relativeSegments(from: segments, to: other.segments)

        if all.isEmpty {
            return PureWindowsPath(".")
        } else {
            return PureWindowsPath(all.joined(separator: "\(WindowsConstants.pathSeparator)"))
        }
    }

    public var parent: PureWindowsPath {
        PureWindowsPath(parts: parts.parentParts)
    }

    public var parents: AnySequence<PureWindowsPath> {
        var parents = Path.Parts.Parents(initialParts: parts)
        return AnySequence<PureWindowsPath> {
            AnyIterator {
                parents.next().map { PureWindowsPath(drive: $0.drive, root: $0.root, segments: $0.segments) }
            }
        }
    }

    public var normal: PureWindowsPath {
        PureWindowsPath(parts: parts.normalized)
    }

    var isEmpty: Bool {
        parts.isEmpty
    }
}

extension PureWindowsPath: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }
}

extension PureWindowsPath: CustomStringConvertible {
    public var description: String {
        binaryPath.description
    }
}

extension PureWindowsPath: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.binaryPath == rhs.binaryPath
    }
}

extension PureWindowsPath: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(binaryPath)
    }
}
