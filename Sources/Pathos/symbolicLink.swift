#if os(Linux)
import Glibc
#else
import Darwin
#endif

/// Create a symbolic link for file or directory at `source` in the location of `destination`.
///
/// - Parameters:
///   - source: path to the original file or directory.
///   - destination: the location for the symbolic link to be created.
/// - Throws: system error. Example of cause includes lack of write permission at destination, lack of additional space, etc.
public func createSymbolicLink(fromPath source: String, toPath destination: String) throws {
    if symlink(source, destination) != 0 {
        throw SystemError(posixErrorCode: errno)
    }
}

// TODO: missing docstring.
public func readSymbolicLink(atPath path: String) throws -> String {
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
    public func createSymbolicLink(at destination: Self) -> Bool {
        do {
            try createSymbolicLink(fromPath:toPath:)(self.pathString, destination.pathString)
        } catch {
            return false
        }
        return true
    }

    // TODO: missing docstring.
    public func readSymbolicLink() -> String? {
        return try? readSymbolicLink(atPath:)(self.pathString)
    }
}
