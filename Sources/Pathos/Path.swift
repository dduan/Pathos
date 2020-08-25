struct Path {
#if os(Windows)
    let pure: PureWindowsPath
#else
    let pure: PurePOSIXPath
#endif

    /// Raw representation of the path. This could be a value from the operating system API. It's
    /// agnostic to character encoding.
    public var binaryString: BinaryString { pure.binaryString }

    /// Creates a path from a C String.
    ///
    /// - Parameter cString: a nul-terminated C String.
    public init(cString: UnsafePointer<NativeEncodingUnit>) {
        pure = .init(cString: cString)
    }

    /// Creates a path from a `String`. The string will be interpreted as UTF-8 bytes.
    ///
    /// - Parameter string: The string that represents a path.
    public init(_ string: String) {
        pure = .init(string)
    }

    /// The drive for the path. For POSIX, this is always empty.
    ///
    /// This value is lazily computed when it's accessed for the first time. To manually trigger
    /// its computation, use `parse()`.
    public var drive: BinaryString { pure.drive }

    /// The bytes for the root, if it's present in `bytes`. For example, on POSIX this would be "/".
    ///
    /// This value is lazily computed when it's accessed for the first time. To manually trigger
    /// its computation, use `parse()`.
    public var root: BinaryString { pure.root }

    /// The segments in the path separated by `Path.separatorByte`. Root is not included.
    ///
    /// This value is lazily computed when it's accessed for the first time. To manually trigger
    /// its computation, use `parse()`.
    public var segments: Array<BinaryString> { pure.segments }

    /// Analyze the content of the path. This will result in a cached value for `drive`, `root`,
    /// `segments`, etc.
    public func parse() {
        pure.parse()
    }

    /// The final path component, if any.
    public var name: BinaryString? {
        pure.name
    }
}
