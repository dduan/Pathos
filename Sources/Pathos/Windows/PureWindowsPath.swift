public struct PureWindowsPath {
    // public typealias BinaryString = WindowsBinaryString

    @LazyBoxed
    private var parts: PathParts

    public let binaryString: WindowsBinaryString

    public init(_ binary: WindowsBinaryString) {
        binaryString = binary
        _parts = .init { PathParts(forWindowsWithBinary: binary) }
    }

    public init(cString: UnsafePointer<WindowsEncodingUnit>) {
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
