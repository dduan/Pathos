/// A type that represents a path. All Pathos methods is available to the conforming type.
public protocol PathRepresentable {
    /// A string value that is the path.
    var pathString: String { get }
    /// Initialize the type providing a string as path.
    ///
    /// - parameter string: string value for the path.
    init(_ string: String)
}
