#if os(Linux)
import Glibc
#else
import Darwin
#endif

// TODO: missing unit tests.
// TODO: missing docstring.
public func permissions(forPath path: String) throws -> FileMode {
    var status = stat()
    if stat(path, &status) != 0 {
        throw SystemError(posixErrorCode: errno)
    }
    return FileMode(rawValue: status.st_mode)
}

// TODO: missing unit tests.
// TODO: missing docstring.
public func setPermissions(forPath path: String, _ mode: FileMode) throws {
    if chmod(path, mode.rawValue) != 0 {
        throw SystemError(posixErrorCode: errno)
    }
}

extension PathRepresentable {
    // TODO: missing unit tests.
    // TODO: missing docstring.
    public var permissions: FileMode {
        get {
            return (try? permissions(forPath:)(self.pathString)) ?? FileMode(rawValue: 0)
        }
        set {
            try? setPermissions(forPath:_:)(self.pathString, newValue)
        }
    }
}
