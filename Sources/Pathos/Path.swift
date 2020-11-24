// `Path` is the primary access point for Pathos APIs. It stores a path's value in binary format.
// A `Path` points to a theoretical location in the virtual file system. It does not represent what
// does or does not actually resides at the location.
public struct Path {
    #if os(Windows)
    let pure: PureWindowsPath
    #else
    let pure: PurePOSIXPath
    #endif

    var binaryPath: BinaryString { pure.binaryPath }

    public init(_ pure: PurePath) {
        self.pure = pure
    }

    init(cString: UnsafePointer<NativeEncodingUnit>) {
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

    public func asWorkingDirectory(run action: @escaping () throws -> Void) throws {
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

    public var normal: Path {
        Path(pure.normal)
    }

    public var base: Self {
        Path(pure.base)
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

    public func write<Bytes>(
        bytes: Bytes,
        createIfNecessary: Bool = true,
        truncate: Bool = true
    ) throws where Bytes: Collection, Bytes.Element == UInt8 {
        try ContiguousArray(bytes).withUnsafeBytes { bytes in
            try write(
                bytes: bytes.baseAddress!,
                byteCount: bytes.count,
                createIfNecessary: createIfNecessary,
                truncate: truncate
            )
        }
    }

    public func write<Bytes>(
        bytes: Bytes,
        createIfNecessary: Bool = true,
        truncate: Bool = true
    ) throws where Bytes: Collection, Bytes.Element == Int8 {
        try write(
            bytes: ContiguousArray(bytes.map(UInt8.init(bitPattern:))),
            createIfNecessary: createIfNecessary,
            truncate: truncate
        )
    }

    public func write<Encoding>(
        _ string: String,
        encoding: Encoding.Type,
        createIfNecessary: Bool = true,
        truncate: Bool = true
    ) throws where Encoding: _UnicodeEncoding {
        try string.withCString(encodedAs: encoding) { encodedBuffer in
            var data = [Encoding.CodeUnit]()
            data.reserveCapacity(string.count)
            var length = 0
            while case let datum = encodedBuffer.advanced(by: length).pointee, datum != 0 {
                data.append(datum)
                length += 1
            }

            try data.withUnsafeBytes { byteBuffer in
                try write(
                    bytes: byteBuffer.baseAddress!,
                    byteCount: byteBuffer.count,
                    createIfNecessary: createIfNecessary,
                    truncate: truncate
                )
            }
        }
    }

    public func write(
        _ string: String,
        createIfNecessary: Bool = true,
        truncate: Bool = true
    ) throws {
        try string.withCString { buffer in
            try write(
                bytes: UnsafeRawPointer(buffer),
                byteCount: string.utf8.count,
                createIfNecessary: createIfNecessary,
                truncate: truncate
            )
        }
    }

    /// Find all the path names matching a specified pattern according to the rules used by the native OS shells.
    /// On POSIX, home directory (tilde, `~`) gets expanded. "Globstar" (`**`) can be included as part of the pattern
    /// to represent all intermediary directories, making the search recursive, similar¹ to pattern expansion on Zsh,
    /// Fish and Bash 4+.
    ///
    /// ¹ globstar expansion has many quirks and differences among different implementations. Pathos use the
    /// following algorithm:
    ///   - find the leftmost occurance of `**` (ignore the rest of occurances).
    ///   - split the pattern by middle of the globstar. So `a/**/c/*.swift`, for example, would become `a/*` and
    ///     `*/c/*.swift`.
    ///   - perform a non-recursive, system glob with the first half (`a/*` from previous example).
    ///   - for each result from previous glob that is a directory, recursively find all of its children.
    ///   - perform an `fnmatch` or `PathMatchSpecW` with the *full* pattern with each child, return the ones that
    ///     match.
    ///
    /// ² due to libc implementation, there are subtle behaviral differences among platforms. Specifically, broken
    /// symbolic links will not be found on Linux, but it will be included on Darwin.
    ///
    /// - Returns: paths in current working directory that matches the pattern.
    public func glob() throws -> [Path] {
        guard var globStarPosition = binaryPath.content.firstIndex(of: [42, 42]) else {
            return simpleGlobImpl()
        }

        func recursiveFNMatch(_ path: Path) throws -> [Path] {
            try path.children(recursive: true)
                .map(\.0)
                .filter { $0.matches(pattern: self) }
        }

        while binaryPath.content[globStarPosition - 1] == 92 {
            globStarPosition -= 1
        }

        return try Path(BinaryString(nulTerminatedStorage: binaryPath.content.prefix(globStarPosition) + [0]))
            .simpleGlobImpl()
            .filter { try $0.metadata().fileType.isDirectory }
            .flatMap(recursiveFNMatch)
    }

    public var isEmpty: Bool {
        pure.isEmpty
    }

    public func readString<Encoding>(as _: Encoding.Type) throws -> String
        where Encoding: _UnicodeEncoding
    {
        try readBytes().withUnsafeBytes { rawBytes in
            String(decoding: rawBytes.bindMemory(to: Encoding.CodeUnit.self), as: Encoding.self)
        }
    }

    public func readUTF8String() throws -> String {
        try readString(as: UTF8.self)
    }

    struct Parts: Equatable {
        var drive: String?
        var root: String?
        var segments: Array<String>

        var isEmpty: Bool {
            drive == nil && root == nil && segments.isEmpty
        }

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

extension Path: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }
}

extension Path: CustomStringConvertible {
    public var description: String {
        binaryPath.description
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

extension Path: Comparable {
    public static func < (lhs: Path, rhs: Path) -> Bool {
        lhs.binaryPath < rhs.binaryPath
    }
}
