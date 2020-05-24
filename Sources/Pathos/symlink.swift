#if os(Linux)
import Glibc
#elseif os(macOS)
import Darwin
#endif

#if !os(Windows)
/// Create a symbolic link for file or directory at `source` in the location of `destination`.
///
/// - Parameters:
///   - source: path to the original file or directory.
///   - destination: the location for the symbolic link to be created.
/// - Throws: system error. Example of cause includes lack of write permission at destination, lack of additional space, etc.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.createSymlink(at:)`.
@available(*, deprecated, renamed: "createSymlink(fromPath:toPath:)")
public func createSymolicLink(fromPath source: String, toPath destination: String) throws {
    try createSymlink(fromPath: source, toPath: destination)
}

/// Create a symbolic link for file or directory at `source` in the location of `destination`.
///
/// - Parameters:
///   - source: path to the original file or directory.
///   - destination: the location for the symbolic link to be created.
/// - Throws: system error. Example of cause includes lack of write permission at destination, lack of additional space, etc.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.createSymlink(at:)`.
public func createSymlink(fromPath source: String, toPath destination: String) throws {
    if symlink(source, destination) != 0 {
        throw SystemError(posixErrorCode: errno)
    }
}

/// Return a string representing the path to which the symbolic link points. The result may be either an absolute or relative pathname.
///
/// - Parameter path: the location of the symbolic link.
/// - Returns: string reprentation of the link's destination.
/// - Throws: system error encountered while attempting to read the content of the link.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.readSymlink()`.
@available(*, deprecated, renamed: "readSymlink(atPath:)")
public func readSymbolicLink(atPath path: String) throws -> String {
    try readSymlink(atPath: path)
}

/// Return a string representing the path to which the symbolic link points. The result may be either an absolute or relative pathname.
///
/// - Parameter path: the location of the symbolic link.
/// - Returns: string reprentation of the link's destination.
/// - Throws: system error encountered while attempting to read the content of the link.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.readSymlink()`.
public func readSymlink(atPath path: String) throws -> String {
    let buffer = UnsafeMutableBufferPointer<Int8>.allocate(capacity: kMaxPathNameLength + 1)
    defer { buffer.deallocate() }
    let count = readlink(path, buffer.baseAddress!, kMaxPathNameLength)
    if count == -1 {
        throw SystemError(posixErrorCode: errno)
    }
    buffer[count] = 0
    return String(cString: buffer.baseAddress!)
}

extension PathRepresentable {
    /// Create a symbolic link for file or directory at this path in the location `destination`.
    ///
    /// - Parameter destination: the location for the symbolic link to be created.
    /// - Returns: `true` if the symbolic link is successfully created. `false` otherwise.
    /// - SeeAlso: `createSymlink(fromPath:toPath:)`.
    @available(*, deprecated, renamed: "createSymlink(at:)")
    @discardableResult
    public func createSymbolicLink(at destination: Self) -> Bool {
        self.createSymlink(at: destination)
    }

    /// Create a symbolic link for file or directory at this path in the location `destination`.
    ///
    /// - Parameter destination: the location for the symbolic link to be created.
    /// - Returns: `true` if the symbolic link is successfully created. `false` otherwise.
    /// - SeeAlso: `createSymlink(fromPath:toPath:)`.
    @discardableResult
    public func createSymlink(at destination: Self) -> Bool {
        do {
            try createSymlink(fromPath:toPath:)(self.pathString, destination.pathString)
        } catch {
            return false
        }
        return true
    }

    /// Return a string representing the path to which the symbolic link points. The result may be either an absolute or relative pathname.
    ///
    /// - Parameter path: the location of the symbolic link.
    /// - Returns: string reprentation of the link's destination. nil if an error is encountered while trying to read the link.
    /// - SeeAlso: `readSymlink(atPath:)`.
    @available(*, deprecated, renamed: "readSymlink()")
    public func readSymbolicLink() -> String? {
        self.readSymlink()
    }

    /// Return a string representing the path to which the symbolic link points. The result may be either an absolute or relative pathname.
    ///
    /// - Parameter path: the location of the symbolic link.
    /// - Returns: string reprentation of the link's destination. nil if an error is encountered while trying to read the link.
    /// - SeeAlso: `readSymlink(atPath:)`.
    public func readSymlink() -> String? {
        try? readSymlink(atPath:)(self.pathString)
    }
}
#endif
