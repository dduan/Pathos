#if os(Linux)
import Glibc
#else
import Darwin
#endif

// TODO: missing docstring.
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
    // TODO: missing docstring.
    public func createSymbolicLink(to destination: Self) -> Bool {
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
