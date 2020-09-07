public struct Path {
    #if os(Windows)
    let pure: PureWindowsPath
    #else
    let pure: PurePOSIXPath
    #endif

    var binaryString: BinaryString { pure.binaryString }

    public init(_ pure: PurePath) {
        self.pure = pure
    }

    public init(cString: UnsafePointer<NativeEncodingUnit>) {
        self.init(PurePath(cString: cString))
    }

    public init(_ string: String) {
        self.init(PurePath(string))
    }

    init(_ binary: BinaryString) {
        self.init(PurePath(binary))
    }

    public var drive: String? { pure.drive }

    public var root: String? { pure.root }

    public var segments: Array<String> { pure.segments }

    public var name: String? { pure.name }

    public var isAbsolute: Bool { pure.isAbsolute }

    public var `extension`: String? { pure.extension }

    public var extensions: [String] { pure.extensions }

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

    public func relative(to other: PathConvertible) -> Path {
        Path(pure.relative(to: other))
    }

    public var parent: Path {
        Path(pure.parent)
    }

    public var parents: AnySequence<Path> {
        let parents = pure.parents.makeIterator()
        return AnySequence<Path> {
            AnyIterator<Path> {
                parents.next().map { Path($0) }
            }
        }
    }

    /// Return `true` if path refers to an existing path.
    /// On some platforms, this function may return `false` if permission is not
    /// granted to retrieve metadata on the requested file, even if the path physically exists.
    ///
    /// - Parameter followSymlink: whether to follow symbolic links. If `true`, return `false` for
    ///                            broken symbolic links.
    /// - Returns: whether path refers to an existing path or an open file descriptor.
    public func exists(followSymlink: Bool = false) -> Bool {
        (try? metadata(followSymlink: followSymlink)) != nil
    }

    /// Return the absolute path for this path.
    ///
    /// - Returns: the absolute path.
    public func absolute() throws -> Path {
        if !isAbsolute {
            return try Path.workingDirectory().joined(with: self)
        } else {
            return self
        }
    }

    struct Parts: Equatable {
        let drive: String?
        let root: String?
        let segments: Array<String>

        struct Parents: Sequence, IteratorProtocol {
            var parts: Path.Parts
            var terminated: Bool = false

            init(initialParts: Path.Parts) {
                parts = initialParts
            }

            mutating func next() -> Path.Parts? {
                if terminated {
                    return nil
                }

                let parentParts = parts.parentParts
                if parentParts == parts && !terminated {
                    terminated = true
                    return nil
                } else {
                    parts = parentParts
                    return parts
                }
            }
        }
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
