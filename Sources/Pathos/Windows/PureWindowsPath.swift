public struct PureWindowsPath {
    typealias BinaryString = WindowsBinaryString
    private let partsStorage = Box<Optional<PathParts<WindowsEncodingUnit>>>(nil)

    private var parts: PathParts<WindowsEncodingUnit> {
        partsStorage.getOrCreateParts(binaryString)
    }

    public let binaryString: WindowsBinaryString

    public init(cString: UnsafePointer<WindowsEncodingUnit>) {
        binaryString = WindowsBinaryString(cString: cString)
    }

    public init(_ string: String) {
        binaryString = WindowsBinaryString(string)
    }

    public init(_ binary: WindowsBinaryString) {
        binaryString = binary
    }

    public var drive: WindowsBinaryString {
        parts.drive
    }

    public var root: WindowsBinaryString {
        parts.root
    }

    public var segments: Array<WindowsBinaryString> {
        parts.segments
    }

    public func parse() {
        _ = partsStorage.getOrCreateParts(binaryString)
    }

    public var name: WindowsBinaryString? {
        parts.segments.last
    }

    public func joined(with others: WindowsPathConvertible...) -> Self {
        joined(with: others)
    }

    public func joined(with paths: [WindowsPathConvertible]) -> Self {
        let paths = [self] + paths.map(\.asWindowsPath)

        var drive = WindowsBinaryString()
        var root = WindowsBinaryString()
        var segments = [WindowsBinaryString]()

        for path in paths {
            if !path.drive.isEmpty {
                drive = path.drive
                root = path.root
                segments = path.segments
            } else if !path.root.isEmpty {
                root = path.root
                segments = path.segments
            } else {
                segments += path.segments
            }
        }

        let result = drive
            + root
            + ContiguousArray(segments.joined(separator: [WindowsConstants.separatorByte]))
        return PureWindowsPath(result)
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
