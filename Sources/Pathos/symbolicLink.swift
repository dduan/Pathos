#if os(Linux)
import Glibc
#else
import Darwin
#endif

public func makeSymbolicLink(fromPath source: String, toPath destination: String) throws {
    if symlink(source, destination) != 0 {
        throw SystemError(posixErrorCode: errno)
    }
}

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
    public func makeSymbolicLink(to destination: Self) -> Bool {
        do {
            try makeSymbolicLink(fromPath:toPath:)(self.pathString, destination.pathString)
        } catch {
            return false
        }
        return true
    }

    public var symbolicLinkValue: String? {
        return try? readSymbolicLink(atPath: self.pathString)
    }
}
