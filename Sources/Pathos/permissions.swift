#if os(Linux)
import Glibc
#else
import Darwin
#endif

/// Get file permissions for path. This function will *not* follow symbolic links, it'll return permissions
/// for the link itself instead.
///
/// - Parameter path: The path for which the permissions are get.
/// - Throws: System error encountered while attempting to read permissions at the path.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.permissions`.
public func permissions(forPath path: String) throws -> FilePermission {
    var status = stat()
    if lstat(path, &status) != 0 {
        throw SystemError(posixErrorCode: errno)
    }
    return FilePermission(rawValue: status.st_mode)
}

/// Set additional permissions to existing permission at file or directories at path. This function will *not*
/// follow symbolic links, it'll change permissions for the link itself instead.
///
/// - Parameters:
///   - permissions: Additional permissions to be set at the path.
///   - path: The path whose permission is being changed.
/// - Throws: System error encountered while attempting to read or change permissions at the path.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.add(_:)`.
public func add(_ permissions: FilePermission, forPath path: String) throws {
    let existingPermission = try permissions(forPath:)(path)
    try set(existingPermission.union(permissions), forPath: path)
}

/// Remove permissions from existing permission at a path. This function will *not* follow symbolic links,
/// it'll change permissions for the link itself instead.
///
/// - Parameters:
///   - permissions: Permissions to be removed at the path.
///   - path: The path whose permission is being changed.
/// - Throws: System error encountered while attempting to read or change permissions at the path.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.remove(_:)`.
public func remove(_ permissions: FilePermission, forPath path: String) throws {
    let existingPermission = try permissions(forPath:)(path)
    try set(existingPermission.subtracting(permissions), forPath: path)
}

/// Set permissions at a path. This function will *not* follow symbolic links, it'll change permissions for
/// the link itself instead.
///
/// - Parameters:
///   - permissions: Permissions to be set at the path.
///   - path: The path whose permission is being changed.
/// - Throws: System error encountered while attempting to read or change permissions at the path.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.permissions`.
public func set(_ permissions: FilePermission, forPath path: String) throws {
    if chmod(path, permissions.rawValue) != 0 {
        throw SystemError(posixErrorCode: errno)
    }
}

extension PathRepresentable {
    /// The permissions at this path.
    ///
    /// If an error is encountered while reading the permission, `FilePermission(rawValue: 0)` will be the
    /// value. If an error is encountered while setting the permission, this will be a no-op.
    /// - SeeAlso: `permissions(forPath:)`.
    public var permissions: FilePermission {
        get {
            return (try? permissions(forPath:)(self.pathString)) ?? FilePermission(rawValue: 0)
        }
        set {
            try? set(_:forPath:)(newValue, self.pathString)
        }
    }

    /// Set additional permissions to existing permission at this path. If this is an symbolic link, the
    /// permission for the link itself will be changed.
    /// - SeeAlso: `add(_:forPath:)`.
    public func add(_ permissions: FilePermission) {
        try? add(_:forPath:)(permissions, self.pathString)
    }

    /// Remove permissions from existing permission at a path. If this is an symbolic link, the
    /// permission for the link itself will be changed.
    /// - SeeAlso: `remove(_:forPath:)`.
    public func remove(_ permissions: FilePermission) {
        try? remove(_:forPath:)(permissions, self.pathString)
    }
}
