#if DEBUG
protocol PurePathRepresentable {
    associatedtype NativeEncodingUnit
    associatedtype BinaryString
    var binaryString: BinaryString { get }

    /// Creates a path from a C String.
    ///
    /// - Parameter cString: a nul-terminated C String.
    init(cString: UnsafePointer<NativeEncodingUnit>)

    /// Creates a path from a `String`. The string will be interpreted as UTF-8 bytes.
    ///
    /// - Parameter string: The string that represents a path.
    init(_ string: String)

    /// The drive for the path. For POSIX, this is always empty.
    ///
    /// This value is lazily computed when it's accessed for the first time. To manually trigger
    /// its computation, use `parse()`.
    var drive: BinaryString { get }

    /// The bytes for the root, if it's present in `bytes`. For example, on POSIX this would be "/".
    ///
    /// This value is lazily computed when it's accessed for the first time. To manually trigger
    /// its computation, use `parse()`.
    var root: BinaryString { get }

    /// The segments in the path separated by `Path.separatorByte`. Root is not included.
    ///
    /// This value is lazily computed when it's accessed for the first time. To manually trigger
    /// its computation, use `parse()`.
    var segments: Array<BinaryString> { get }

    /// Analyze the content of the path. This will result in a cached value for `drive`, `root`,
    /// `segments`, etc.
    func parse()

    /// The final path component, if any.
    var name: BinaryString? { get }
}

extension PureWindowsPath: PurePathRepresentable {}
extension PurePOSIXPath: PurePathRepresentable {}
extension Path: PurePathRepresentable {}
#endif
