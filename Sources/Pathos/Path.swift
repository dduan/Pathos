public struct Path {
    #if os(Windows)
    let pure: PureWindowsPath
    #else
    let pure: PurePOSIXPath
    #endif

    public var binaryString: BinaryString { pure.binaryString }

    public init(_ pure: PurePath) {
        self.pure = pure
    }

    public init(cString: UnsafePointer<NativeEncodingUnit>) {
        self.init(PurePath(cString: cString))
    }

    public init(_ string: String) {
        self.init(PurePath(string))
    }

    public init(_ binary: BinaryString) {
        self.init(PurePath(binary))
    }

    public var drive: BinaryString { pure.drive }

    public var root: BinaryString { pure.root }

    public var segments: Array<BinaryString> { pure.segments }

    public var name: BinaryString? { pure.name }

    public var isAbsolute: Bool { pure.isAbsolute }

    public func parse() {
        pure.parse()
    }

    public func asWorkingDirectory(execute action: @escaping () throws -> Void) throws {
        let currentDirectory = try Path.workingDirectory()
        defer {
            try? Path.setWorkingDirectory(currentDirectory)
        }

        try Path.setWorkingDirectory(self)
        try action()
    }
}

extension Path: CustomStringConvertible {
    public var description: String {
        binaryString.description
    }
}

extension Path: Equatable, Hashable {
    public static func == (lhs: Path, rhs: Path) -> Bool {
        lhs.pure == rhs.pure
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(pure)
    }
}
