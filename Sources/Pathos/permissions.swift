#if os(Linux)
import Glibc
#else
import Darwin
#endif

// TODO: missing docstring.
public func permissions(forPath path: String) throws -> FilePermission {
    var status = stat()
    if stat(path, &status) != 0 {
        throw SystemError(posixErrorCode: errno)
    }
    return FilePermission(rawValue: status.st_mode)
}

// TODO: missing docstring.
public func setPermissions(forPath path: String, _ mode: FilePermission) throws {
    if chmod(path, mode.rawValue) != 0 {
        throw SystemError(posixErrorCode: errno)
    }
}

extension PathRepresentable {
    // TODO: missing docstring.
    public var permissions: FilePermission {
        get {
            return (try? permissions(forPath:)(self.pathString)) ?? FilePermission(rawValue: 0)
        }
        set {
            try? setPermissions(forPath:_:)(self.pathString, newValue)
        }
    }
}
