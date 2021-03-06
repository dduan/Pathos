#if DEBUG
protocol PurePathRepresentable: Hashable, CustomStringConvertible, ExpressibleByStringLiteral {
    associatedtype NativeEncodingUnit
    associatedtype BinaryStringLike
    associatedtype PathLike

    var binaryPath: BinaryStringLike { get }

    /// Creates a path from a C String.
    ///
    /// - Parameter cString: a nul-terminated C String.
    init(cString: UnsafePointer<NativeEncodingUnit>)

    /// Creates a path from a `String`.
    ///
    /// - Parameter string: The string that represents a path.
    init(_ string: String)

    /// Creates a path from a `BinaryString`.
    ///
    /// - Parameter string: The string that represents a path.
    init(_ string: BinaryStringLike)

    /// The drive for the path. For POSIX, this is always empty.
    var drive: String? { get }

    /// Root component of the path. For example, on POSIX this is typically "/".
    var root: String? { get }

    /// The segments in the path separated by `Constants.binaryPathSeparator`.
    /// Root is not included.
    ///
    /// Example: `Path("/usr/bin/env").segments` is `["usr", "bin", "env"]`.
    var segments: Array<String> { get }

    /// The final path component, if any.
    ///
    /// Example: `Path("src/Pathos/README.md").name` is `"README.md"`.
    var name: String? { get }

    /// Join with other paths. Absolute path will override existing value.
    /// For example:
    ///   Path("/a/b").joined(with: "c") => Path("/a/b/c")
    ///   Path("/a/b").joined(with: "/c") => Path("/c")
    ///
    /// - Parameter paths: Other values that represents a path.
    ///
    /// - Returns: Result of joining paths.
    func joined(with paths: PathLike...) -> Self

    /// Join with other paths. Absolute path will override existing value.
    /// For example:
    ///   Path("/a/b").joined(with: "c") => Path("/a/b/c")
    ///   Path("/a/b").joined(with: "/c") => Path("/c")
    ///
    /// - Parameter paths: Other values that represents a path.
    ///
    /// - Returns: Result of joining paths.
    func joined(with paths: [PathLike]) -> Self

    /// Indicates whether this path is absolute.
    ///
    /// An absolute path is one that has a root and, if applicable, a drive.
    var isAbsolute: Bool { get }

    /// Final suffix that begins with a `.` in the `name` the path. Leading `.`
    /// in the name does not count.
    ///
    /// Example: `Path("archive/Pathos.tar.gz").extension` is `"gz"`.
    var `extension`: String? { get }

    /// Suffixes that begin with a `.` in the `name` the path, in the order they appear.
    /// Leading `.` in the name does not count.
    ///
    /// Example: `Path("archive/Pathos.tar.gz").extension` is `["tar", "gz"]`.
    var extensions: [String] { get }

    /// Path value without the `extension`. `path.base + path.extension` should be equal to `path`.
    var base: Self { get }

    /// Returns a path that connects this location and another.
    ///
    /// This is a pure computation: the file system is not accessed to confirm the existence or
    /// nature of this path or `other`.
    /// Example: the relative path of `/` to `/Users/dan` is `../..`.
    ///
    /// - Parameter other: The path, through the return value, can be reached from this path.
    /// - Returns: The path through which other can be reached from this branch.
    func relative(to other: PathLike) -> Self

    /// The logical parent of the path. The parent of an anchor is the anchor itself.
    /// The parent of `.` is `.`. The parent of `/a/b/c` is `/a/b`.
    var parent: Self { get }

    /// A sequence composed of the `self.parent`, `self.parent.parent`, etc. The
    /// final value is either the current context (`Path(".")`) or the root.
    ///
    /// Example: `Array(Path("a/b/c")` is `[Path("a/b"), Path("a"), Path(".")]`.
    var parents: AnySequence<Self> { get }

    /// The path does not have a drive nor a root, and its `segments` is empty.
    var isEmpty: Bool { get }
}

extension PureWindowsPath: PurePathRepresentable {}
extension PurePOSIXPath: PurePathRepresentable {}
extension Path: PurePathRepresentable {}
#endif
