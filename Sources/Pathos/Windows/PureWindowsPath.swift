public struct PureWindowsPath {
    typealias BinaryString = WindowsBinaryString
    private let parts = Box<Optional<PathParts<WindowsEncodingUnit>>>(nil)

    public let binaryString: WindowsBinaryString

    public init(cString: UnsafePointer<WindowsEncodingUnit>) {
        binaryString = WindowsBinaryString(cString: cString)
    }

    public init(_ string: String) {
        binaryString = WindowsBinaryString(string)
    }

    public var drive: WindowsBinaryString {
        parts.getOrCreateParts(forWindowsFrom: binaryString).drive
    }

    public var root: WindowsBinaryString {
        parts.getOrCreateParts(forWindowsFrom: binaryString).root
    }

    public var segments: Array<WindowsBinaryString> {
        parts.getOrCreateParts(forWindowsFrom: binaryString).segments
    }

    public func parse() {
        _ = parts.getOrCreateParts(forWindowsFrom: binaryString)
    }
}
