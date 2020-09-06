public struct PureWindowsPath {
    @LazyBoxed
    private var parts: Path.Parts

    let binaryString: WindowsBinaryString

    init(_ binary: WindowsBinaryString) {
        binaryString = binary
        _parts = .init { Path.Parts(forWindowsWithBinary: binary) }
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

        let result = (drive ?? "")
            + (root ?? "")
            + segments.joined(separator: [WindowsConstants.pathSeparator])
        return PureWindowsPath(result)
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
}

extension PureWindowsPath: CustomStringConvertible {
    public var description: String {
        binaryString.description
    }
}

extension PureWindowsPath: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.binaryString == rhs.binaryString
    }
}

extension PureWindowsPath: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(binaryString)
    }
}
