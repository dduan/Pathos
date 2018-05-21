import Darwin
func permissions(forPath path: String) throws -> FilePermission {
    var status = stat()
    if stat(path, &status) != 0 {
        throw SystemError(posixErrorCode: errno)
    }
    return FilePermission(rawValue: status.st_mode)
}

func setPermissions(forPath path: String, _ mode: FilePermission) throws {
    if chmod(path, mode.rawValue) != 0 {
        throw SystemError(posixErrorCode: errno)
    }
}

extension PathRepresentable {
    var permissions: FilePermission? {
        get {
            return try? permissions(forPath:)(self.pathString)
        }
        set {
            if let newPermissions = newValue {
                try? setPermissions(forPath:_:)(self.pathString, newPermissions)
            }
        }
    }
}
