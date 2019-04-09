#if os(Linux)
import Glibc
#else
import Darwin
#endif

private func _typedChildrenInPath(_ path: String, _ type: Int32?, recursive: Bool = false) throws -> [String] {
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
        throw SystemError(posixErrorCode: errno)
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

        let fullName = join(paths: path, name)
        if type == nil || pathType == type {
            result.append(fullName)
        }

        if recursive && pathType == DT_DIR {
            result += try _typedChildrenInPath(fullName, type, recursive: true)
        }
    }

    free(bufferPointer)
    return result
}

private func _children<T>(_ path: T, recursive: Bool, block: (String, Bool) throws -> [String]) -> [T] where T: PathRepresentable {
    let result = try? block(path.pathString, recursive)
        .map(T.init)
    return result ?? []
}

/// Find paths to directories and files of all types in `path`.
///
/// - Parameters:
///   - path: the path whose children will be returned.
///   - recursive: set to `true` to include results from child directories in addition to that from `path`.
///                Defaults to `false`.
///
/// - Returns: path to directories and files of all types in `path`.
/// - Throws: A `SystemError` if path cannot be opened as a directory or there's not enough memory to hold all
///           data for the results.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.children(recursive:)`.
public func children(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, nil, recursive: recursive)
}

/// Find paths to files with unknown types in `path`. Known types are: pipes, character devices,
/// directories, block devices, files, symbolic links and sockets.
///
/// - Parameters:
///   - path: the path whose children will be returned.
///   - recursive: set to `true` to include results from child directories in addition to that from `path`.
///                Defaults to `false`.
///
/// - Returns: paths to files with unknown types in `path`.
/// - Throws: A `SystemError` if path cannot be opened as a directory or there's not enough memory to hold all
///           data for the results.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.childUnknownTypeFiles(recursive:)`.
public func childUnknownTypeFiles(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_UNKNOWN), recursive: recursive)
}

/// Find paths to pipes in `path`.
///
/// - Parameters:
///   - path: the path whose children will be returned.
///   - recursive: set to `true` to include results from child directories in addition to that from `path`.
///                Defaults to `false`.
///
/// - Returns: path to all pipes in `path`.
/// - Throws: A `SystemError` if path cannot be opened as a directory or there's not enough memory to hold all
///           data for the results.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.childPipes(recursive:)`.
public func childPipes(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_FIFO), recursive: recursive)
}

/// Find paths to character device files in `path`.
///
/// - Parameters:
///   - path: the path whose children will be returned.
///   - recursive: set to `true` to include results from child directories in addition to that from `path`.
///                Defaults to `false`.
///
/// - Returns: path to all character device files in `path`.
/// - Throws: A `SystemError` if path cannot be opened as a directory or there's not enough memory to hold all
///           data for the results.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.childCharacterDevices(recursive:)`.
public func childCharacterDevices(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_CHR), recursive: recursive)
}

/// Find paths to directories in `path`.
///
/// - Parameters:
///   - path: the path whose children will be returned.
///   - recursive: set to `true` to include results from child directories in addition to that from `path`.
///                Defaults to `false`.
///
/// - Returns: path to directories in `path`.
/// - Throws: A `SystemError` if path cannot be opened as a directory or there's not enough memory to hold all
///           data for the results.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.childDirectories(recursive:)`.
public func childDirectories(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_DIR), recursive: recursive)
}

/// Find paths to block device files in `path`.
///
/// - Parameters:
///   - path: the path whose children will be returned.
///   - recursive: set to `true` to include results from child directories in addition to that from `path`.
///                Defaults to `false`.
///
/// - Returns: path to block device files in `path`.
/// - Throws: A `SystemError` if path cannot be opened as a directory or there's not enough memory to hold all
///           data for the results.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.childBlockDevices(recursive:)`.
public func childBlockDevices(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_BLK), recursive: recursive)
}

/// Find paths to normal files in `path`.
///
/// - Parameters:
///   - path: the path whose children will be returned.
///   - recursive: set to `true` to include results from child directories in addition to that from `path`.
///                Defaults to `false`.
///
/// - Returns: path to normal files in `path`.
/// - Throws: A `SystemError` if path cannot be opened as a directory or there's not enough memory to hold all
///           data for the results.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.childFiles(recursive:)`.
public func childFiles(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_REG), recursive: recursive)
}

/// Find paths to symbolic links (also known as symlinks or soft links) in `path`.
///
/// - Parameters:
///   - path: the path whose children will be returned.
///   - recursive: set to `true` to include results from child directories in addition to that from `path`.
///                Defaults to `false`.
///
/// - Returns: path to symbolic links in `path`.
/// - Throws: A `SystemError` if path cannot be opened as a directory or there's not enough memory to hold all
///           data for the results.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.childSymbolicLinks(recursive:)`.
public func childSymbolicLinks(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_LNK), recursive: recursive)
}

/// Find paths to sockets in `path`.
///
/// - Parameters:
///   - path: the path whose children will be returned.
///   - recursive: set to `true` to include results from child directories in addition to that from `path`.
///                Defaults to `false`.
///
/// - Returns: path to sockets in `path`.
/// - Throws: A `SystemError` if path cannot be opened as a directory or there's not enough memory to hold all
///           data for the results.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.childSockets(recursive:)`.
public func childSockets(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_SOCK), recursive: recursive)
}

extension PathRepresentable {
    /// Find paths to child directories and files of all types.
    ///
    /// Result will be empty if this path cannot be opened or there's not enough memory to hold all data for
    /// the results.
    ///
    /// - Parameter recursive: set to `true` to include results from child directories in addition to that
    ///                        in this path. Defaults to `false`.
    ///
    /// - Returns: paths to directories and files of all types in `path`.
    /// - SeeAlso: `children(inPath:recursive:)`.
    public func children(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: children(inPath:recursive:))
    }

    /// Find paths to files with unknown types in `self`. Known types are: pipes, character devices,
    /// directories, block devices, files, symbolic links and sockets.
    ///
    /// Result will be empty if this path cannot be opened or there's not enough memory to hold all data for
    /// the results.
    ///
    /// - Parameter recursive: set to `true` to include results from child directories in addition to that
    ///                        in this path. Defaults to `false`.
    ///
    /// - Returns: paths to files with unknown types in `self`.
    /// - SeeAlso: `childUnknownTypeFiles(inPath:recursive:)`.
    public func childUnknownTypeFiles(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: childUnknownTypeFiles(inPath:recursive:))
    }

    /// Find paths to pipes in `self`.
    ///
    /// Result will be empty if this path cannot be opened or there's not enough memory to hold all data for
    /// the results.
    ///
    /// - Parameter recursive: set to `true` to include results from child directories in addition to that
    ///                        in this path. Defaults to `false`.
    ///
    /// - Returns: paths to pipes in `self`.
    /// - SeeAlso: `childPipes(inPath:recursive:)`.
    public func childPipes(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: childPipes(inPath:recursive:))
    }

    /// Find paths to character devices in `self`.
    ///
    /// Result will be empty if this path cannot be opened or there's not enough memory to hold all data for
    /// the results.
    ///
    /// - Parameter recursive: set to `true` to include results from child directories in addition to that
    ///                        in this path. Defaults to `false`.
    ///
    /// - Returns: paths to character devices in `self`.
    /// - SeeAlso: `childCharacterDevices(inPath:recursive:)`.
    public func childCharacterDevices(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: childCharacterDevices(inPath:recursive:))
    }

    /// Find paths to directories in `self`.
    ///
    /// Result will be empty if this path cannot be opened or there's not enough memory to hold all data for
    /// the results.
    ///
    /// - Parameter recursive: set to `true` to include results from child directories in addition to that
    ///                        in this path. Defaults to `false`.
    ///
    /// - Returns: paths to character devices in `self`.
    /// - SeeAlso: `childDirectories(inPath:recursive:)`.
    public func childDirectories(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: childDirectories(inPath:recursive:))
    }

    /// Find paths to block devices in `self`.
    ///
    /// Result will be empty if this path cannot be opened or there's not enough memory to hold all data for
    /// the results.
    ///
    /// - Parameter recursive: set to `true` to include results from child directories in addition to that
    ///                        in this path. Defaults to `false`.
    ///
    /// - Returns: paths to block devices in `self`.
    /// - SeeAlso: `childBlockDevices(inPath:recursive:)`.
    public func childBlockDevices(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: childBlockDevices(inPath:recursive:))
    }

    /// Find paths to normal files in `self`.
    ///
    /// Result will be empty if this path cannot be opened or there's not enough memory to hold all data for
    /// the results.
    ///
    /// - Parameter recursive: set to `true` to include results from child directories in addition to that
    ///                        in this path. Defaults to `false`.
    ///
    /// - Returns: paths to normal files in `self`.
    /// - SeeAlso: `childFiles(inPath:recursive:)`.
    public func childFiles(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: childFiles(inPath:recursive:))
    }

    /// Find paths to symbolic links (also known as symlinks or soft links) in `self`.
    ///
    /// Result will be empty if this path cannot be opened or there's not enough memory to hold all data for
    /// the results.
    ///
    /// - Parameter recursive: set to `true` to include results from child directories in addition to that
    ///                        in this path. Defaults to `false`.
    ///
    /// - Returns: paths to symbolic links in `self`.
    /// - SeeAlso: `childSymbolicLinks(inPath:recursive:)`.
    public func childSymbolicLinks(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: childSymbolicLinks(inPath:recursive:))
    }

    /// Find paths to sockets in `self`.
    ///
    /// Result will be empty if this path cannot be opened or there's not enough memory to hold all data for
    /// the results.
    ///
    /// - Parameter recursive: set to `true` to include results from child directories in addition to that
    ///                        in this path. Defaults to `false`.
    ///
    /// - Returns: paths to sockets in `self`.
    /// - SeeAlso: `childSockets(inPath:recursive:)`.
    public func childSockets(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: childSockets(inPath:recursive:))
    }
}
