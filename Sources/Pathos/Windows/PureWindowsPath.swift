public struct PureWindowsPath {
    typealias BinaryString = WindowsBinaryString
    private let partsStorage = Box<Optional<PathParts<WindowsEncodingUnit>>>(nil)

    private var parts: PathParts<WindowsEncodingUnit> {
        partsStorage.getOrCreateParts(forWindowsFrom: binaryString)
    }

    public let binaryString: WindowsBinaryString

    public init(cString: UnsafePointer<WindowsEncodingUnit>) {
        binaryString = WindowsBinaryString(cString: cString)
    }

    public init(_ string: String) {
        binaryString = WindowsBinaryString(string)
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
        _ = partsStorage.getOrCreateParts(forWindowsFrom: binaryString)
    }

    public var name: WindowsBinaryString? {
        parts.segments.last
    }
}
