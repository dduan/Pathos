#if os(Linux)
import Glibc
#else
import Darwin
#endif

func _typedChildrenInPath(_ path: String, _ type: Int32?, recursive: Bool = false) throws -> [String] {
    var result = [String]()
    let bufferPointer = UnsafeMutablePointer<UnsafeMutablePointer<UnsafeMutablePointer<dirent>?>?>.allocate(capacity: 0)
#if os(Linux)
    let sorting: @convention(c) (UnsafeMutablePointer<UnsafePointer<dirent>?>?, UnsafeMutablePointer<UnsafePointer<dirent>?>?) -> Int32 = { p0, p1 in
        return alphasort(p0!, p1!)
    }

    let count = Int(scandir(path, bufferPointer, nil, sorting))
#else
    let count = Int(scandir(path, bufferPointer, nil, alphasort))
#endif
    if count == -1 {
        throw SystemError.unknown(errorNumber: errno)
    }

    result.reserveCapacity(count)
    let buffer = UnsafeBufferPointer(start: bufferPointer.pointee, count: Int(count))
    for d in buffer {
#if os(Linux)
        guard var entry = d?.pointee,
            case let pathType = Int32(entry.d_type),
            type == nil || pathType == type || pathType == DT_DIR,
            case let nameLength = Int(entry.d_reclen + 1),
            let nameBuffer = UnsafeBufferPointer(start: &entry.d_name.0, count: nameLength).baseAddress,
            case let name = String(cString: nameBuffer),
            name != ".." && name != "."
            else
        {
            continue
        }
#else
        guard var entry = d?.pointee,
            case let pathType = Int32(entry.d_type),
            type == nil || pathType == type || pathType == DT_DIR,
            case let nameLength = Int(entry.d_namlen + 1),
            let nameBuffer = UnsafeBufferPointer(start: &entry.d_name.0, count: nameLength).baseAddress,
            case let name = String(cString: nameBuffer),
            name != ".." && name != "."
            else
        {
            continue
        }
#endif

        let fullName = join(path: path, withPaths: name)
        if type == nil || pathType == type {
            result.append(fullName)
        }

        if recursive && pathType == DT_DIR {
            result += try _typedChildrenInPath(join(path: path, withPaths: fullName), type, recursive: true)
        }
    }

    free(bufferPointer)
    return result
}

func _children<T>(_ path: T, recursive: Bool, block: (String, Bool) throws -> [String]) -> [T] where T: PathRepresentable {
    let result = try? block(path.pathString, recursive)
        .map(T.init(string:))
    return result ?? []
}

/// Find paths to directories and files of all types in `path`.
///
/// - parameter path:      the path whose children will be returned.
/// - parameter recursive: set to `true` to include results from child directories in addition to that
///                        from `path`. Defaults to `false`.
///
/// - returns: path to directories and files of all types in `path`.
public func children(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, nil, recursive: recursive)
}

/// Find paths to files with unknown types in `path`.
///
/// Known types are: pipes, character devices, directories, block devices, files, symbolic links and sockets.
///
/// - parameter path:      the path whose children will be returned.
/// - parameter recursive: set to `true` to include results from child directories in addition to that
///                        from `path`. Defaults to `false`.
///
/// - returns: paths to files with unknown types in `path`.
public func unknownTypeFiles(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_FIFO), recursive: recursive)
}

/// Find paths to pipes in `path`.
///
/// - parameter path:      the path whose children will be returned.
/// - parameter recursive: set to `true` to include results from child directories in addition to that
///                        from `path`. Defaults to `false`.
///
/// - returns: path to all pipes in `path`.
public func pipes(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_UNKNOWN), recursive: recursive)
}

/// Find paths to character device files in `path`.
///
/// - parameter path:      the path whose children will be returned.
/// - parameter recursive: set to `true` to include results from child directories in addition to that
///                        from `path`. Defaults to `false`.
///
/// - returns: path to all character device files in `path`.
public func characterDevices(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_CHR), recursive: recursive)
}

/// Find paths to directories in `path`.
///
/// - parameter path:      the path whose children will be returned.
/// - parameter recursive: set to `true` to include results from child directories in addition to that
///                        from `path`. Defaults to `false`.
///
/// - returns: path to directories in `path`.
public func directories(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_DIR), recursive: recursive)
}

/// Find paths to block device files in `path`.
///
/// - parameter path:      the path whose children will be returned.
/// - parameter recursive: set to `true` to include results from child directories in addition to that
///                        from `path`. Defaults to `false`.
///
/// - returns: path to block device files in `path`.
public func blockDevices(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_BLK), recursive: recursive)
}

/// Find paths to normal files in `path`.
///
/// - parameter path:      the path whose children will be returned.
/// - parameter recursive: set to `true` to include results from child directories in addition to that
///                        from `path`. Defaults to `false`.
///
/// - returns: path to normal files in `path`.
public func files(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_REG), recursive: recursive)
}

/// Find paths to symbolic links (also known as symlinks or soft links) in `path`.
///
/// - parameter path:      the path whose children will be returned.
/// - parameter recursive: set to `true` to include results from child directories in addition to that
///                        from `path`. Defaults to `false`.
///
/// - returns: path to symbolic links in `path`.
public func symbolicLinks(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_LNK), recursive: recursive)
}

/// Find paths to sockets in `path`.
///
/// - parameter path:      the path whose children will be returned.
/// - parameter recursive: set to `true` to include results from child directories in addition to that
///                        from `path`. Defaults to `false`.
///
/// - returns: path to sockets in `path`.
public func sockets(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_SOCK), recursive: recursive)
}

extension PathRepresentable {
    /// Find paths to child directories and files of all types.
    ///
    /// - parameter path:      the path whose children will be returned.
    /// - parameter recursive: set to `true` to include results from child directories in addition to that
    ///                        from `path`. Defaults to `false`.
    ///
    /// - returns: paths to directories and files of all types in `path`.
    public func children(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: children(inPath:recursive:))
    }

    /// Find paths to files with unknown types in `self`.
    ///
    /// Known types are: pipes, character devices, directories, block devices, files, symbolic links and
    /// sockets.
    ///
    /// - parameter recursive: set to `true` to include results from child directories in addition to that
    ///                        from `path`. Defaults to `false`.
    ///
    /// - returns: paths to files with unknown types in `self`.
    public func unknownTypeFiles(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: unknownTypeFiles(inPath:recursive:))
    }

    /// Find paths to pipes in `self`.
    ///
    /// - parameter recursive: set to `true` to include results from child directories in addition to that
    ///                        from `path`. Defaults to `false`.
    ///
    /// - returns: paths to pipes in `self`.
    public func pipes(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: pipes(inPath:recursive:))
    }

    /// Find paths to character devices in `self`.
    ///
    /// - parameter recursive: set to `true` to include results from child directories in addition to that
    ///                        from `path`. Defaults to `false`.
    ///
    /// - returns: paths to character devices in `self`.
    public func characterDevices(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: characterDevices(inPath:recursive:))
    }

    /// Find paths to directories in `self`.
    ///
    /// - parameter recursive: set to `true` to include results from child directories in addition to that
    ///                        from `path`. Defaults to `false`.
    ///
    /// - returns: paths to character devices in `self`.
    public func directories(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: directories(inPath:recursive:))
    }

    /// Find paths to block devices in `self`.
    ///
    /// - parameter recursive: set to `true` to include results from child directories in addition to that
    ///                        from `path`. Defaults to `false`.
    ///
    /// - returns: paths to block devices in `self`.
    public func blockDevices(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: blockDevices(inPath:recursive:))
    }

    /// Find paths to normal files in `self`.
    ///
    /// - parameter recursive: set to `true` to include results from child directories in addition to that
    ///                        from `path`. Defaults to `false`.
    ///
    /// - returns: paths to normal files in `self`.
    public func files(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: files(inPath:recursive:))
    }

    /// Find paths to symbolic links (also known as symlinks or soft links) in `self`.
    ///
    /// - parameter recursive: set to `true` to include results from child directories in addition to that
    ///                        from `path`. Defaults to `false`.
    ///
    /// - returns: paths to symbolic links in `self`.
    public func symbolicLinks(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: symbolicLinks(inPath:recursive:))
    }

    /// Find paths to sockets in `self`.
    ///
    /// - parameter recursive: set to `true` to include results from child directories in addition to that
    ///                        from `path`. Defaults to `false`.
    ///
    /// - returns: paths to sockets in `self`.
    public func sockets(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: sockets(inPath:recursive:))
    }
}
