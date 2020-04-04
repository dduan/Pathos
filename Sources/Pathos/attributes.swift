#if os(Linux)
import Glibc
#else
import Darwin
#endif

/// Return metadata regarding a path.
///
/// - Parameters:
///   - path: the path to be tested.
///   - followSymbol: whether to follow symbolic links when retrieving the metadata.
/// - Throws: A `SystemError` if the file does not exist or is inaccessible.
/// - Returns: metadata regarding file at the given path.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.metadata(followSymbol:)`.
public func metadata(atPath path: String, followSymbol: Bool = true) throws -> Metadata {
    return try Metadata(followSymbol ? _stat(at: path) : _lstat(at: path))
}

/// Whether file at path is of a type. Returns `false` if the path does not exist or is
///
/// not accessible.
/// - Parameter type: The type in question. See `FileType`.
/// - SeeAlso: `PathRepresentable.isA(_:)`.
public func isA(_ type: FileType, atPath path: String) throws -> Bool {
    if type == .symbolicLink {
        return try _ifmt(_lstat(at: path)) == S_IFLNK
    }

    return try _ifmt(_stat(at: path)) == type.posixMode
}

/// Return `true` if path refers to an existing path or an open file descriptor.
/// On some platforms, this function may return `false` if permission is not
/// granted to execute `stat` on the requested file, even if the path physically exists.
///
/// - Parameters:
///   - path: the path to be tested.
///   - followSymbol: whether to follow symbolic links. If `true`, return `false` for broken symbolic links.
/// - Returns: whether path refers to an existing path or an open file descriptor.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.exists(followSymbol:)`.
public func exists(atPath path: String, followSymbol: Bool = true) -> Bool {
    var status = stat()
    return followSymbol ? stat(path, &status) == 0 : lstat(path, &status) == 0
}

/// Return the size in bytes of path.
///
/// - Parameter path: the path to be tested.
/// - Returns: size of the file at path.
/// - Throws: A `SystemError` if the file does not exist or is inaccessible.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.size`.
@available(*, deprecated, message: "Use `metadata(atPath:followSymbol:).size` instead.")
public func size(atPath path: String) throws -> Int64 {
    return Int64(try _stat(at: path).st_size)
}

/// Return the time of last modification of path.
///
/// - Parameter path: path to be queried.
/// - Returns: modification time in `FileTime`.
/// - Throws: A `SystemError` if the file does not exist or is inaccessible.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.modificationTime`.
@available(*, deprecated, message: "Use `metadata(atPath:followSymbol:).time.modified` instead.")
public func modificationTime(atPath path: String) throws -> FileTime {
#if os(Linux)
    return unsafeBitCast(try _stat(at: path).st_mtim, to: FileTime.self)
#else
    return unsafeBitCast(try _stat(at: path).st_mtimespec, to: FileTime.self)
#endif
}

/// Return the time of last access of path.
///
/// - Parameter path: path to be queried.
/// - Returns: time of last access in `FileTime`.
/// - Throws: A `SystemError` if the file does not exist or is inaccessible.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.accessTime`.
@available(*, deprecated, message: "Use `metadata(atPath:followSymbol:).time.accessed` instead.")
public func accessTime(atPath path: String) throws -> FileTime {
#if os(Linux)
    return unsafeBitCast(try _stat(at: path).st_atim, to: FileTime.self)
#else
    return unsafeBitCast(try _stat(at: path).st_atimespec, to: FileTime.self)
#endif
}

/// Return the system’s ctime which, on some systems (like Unix) is the time of the last metadata change
///
/// - Parameter path: path to be queried.
/// - Returns: time of last metadata change in `FileTime`.
/// - Throws: A `SystemError` if the file does not exist or is inaccessible.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.metadataChangeTime`.
@available(*, deprecated, message: "Use `metadata(atPath:followSymbol:).time.statusChanged` instead.")
public func metadataChangeTime(atPath path: String) throws -> FileTime {
#if os(Linux)
    return unsafeBitCast(try _stat(at: path).st_ctim, to: FileTime.self)
#else
    return unsafeBitCast(try _stat(at: path).st_ctimespec, to: FileTime.self)
#endif
}

/// Return whether `path` points to the same file as `otherPath`.
///
/// - Parameters:
///   - path: the first path in comparison.
///   - otherPath: the other path in comparison.
/// - Returns: whether the 2 paths points to the same file.
/// - Throws: A `SystemError` if either path cannot be accessed for some reason.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.isSame(as:)`.
public func sameFile(atPath path: String, otherPath: String) throws -> Bool {
    return try _sameStat(_stat(at: path), _stat(at: otherPath))
}

extension PathRepresentable {

    /// Whether file at path is of a type. Returns `false` if the path does not exist or is
    /// not accessible.
    /// - Parameter type: The type in question.
    /// - SeeAlso: `isA(_:atPath:)`.
    public func isA(_ type: FileType) -> Bool {
        return (try? isA(_:atPath:)(type, self.pathString)) ?? false
    }
    /// Return `true` if path refers to an existing path or an open file descriptor. Returns `false` for
    /// broken symbolic links. On some platforms, this function may return `false` if permission is not
    /// granted to execute `stat` on the requested file, even if the path physically exists.
    ///
    /// - Parameter followSymbol: whether to follow symbolic links. If `true`, return `false` for broken
    ///                           symbolic links.
    /// - Returns: whether path refers to an existing path or an open file descriptor.
    /// - SeeAlso: `exists(atPath:followSymbol:)`.
    public func exists(followSymbol: Bool = true) -> Bool {
        return exists(atPath:followSymbol:)(self.pathString, followSymbol)
    }

    /// Return the size in bytes of path. Returns `false` if the path does not exist or is
    /// not accessible.
    /// - SeeAlso: `size(atPath:)`.
    @available(*, deprecated, message: "use `self.metadata(followSymbol:).size` instead.")
    public var size: Int64 {
        return (try? size(atPath:)(self.pathString)) ?? 0
    }

    /// Return the time of last modification. Returns `nil` if the path does not exist or is
    /// not accessible.
    /// - SeeAlso: `modificationTime(atPath:)`.
    @available(*, deprecated, message: "use `self.metadata(followSymbol:).time.modified` instead.")
    public var modificationTime: FileTime? {
        return try? modificationTime(atPath:)(self.pathString)
    }

    /// Return the time of last access. Returns `nil` if the path does not exist or is
    /// not accessible.
    /// - SeeAlso: `accessTime(atPath:)`.
    @available(*, deprecated, message: "use `self.metadata(followSymbol:).time.accessed` instead.")
    public var accessTime: FileTime? {
        return try? accessTime(atPath:)(self.pathString)
    }

    /// Return the system’s ctime which, on some systems (like Unix) is the time of the last metadata change,
    /// Returns `nil` if the path does not exist or is not accessible.
    /// - SeeAlso: `metadataChangeTime(atPath:)`.
    @available(*, deprecated, message: "use `self.metadata(followSymbol:).time.statusChanged` instead.")
    public var metadataChangeTime: FileTime? {
        return try? metadataChangeTime(atPath:)(self.pathString)
    }

    /// Return whether `path` points to the same file as `other`. Returns `false` if either path cannot
    /// be accessed for some reason.
    ///
    /// - Parameter other: the other path in comparison.
    /// - Returns: whether the 2 paths points to the same file.
    /// - SeeAlso: `sameFile(atPath:otherPath:)`.
    public func isSame(as other: Self) -> Bool {
        return (try? sameFile(atPath:otherPath:)(self.pathString, other.pathString)) ?? false
    }

    /// Return metadata regarding the path.
    ///
    /// - Parameter followSymbol: whether to follow symbolic links when retrieving the metadata.
    /// - Returns: metadata regarding file at the given path. `nil` if the file does not exist or is
    ///            inaccessible.
    /// - SeeAlso: To work with `Path` or `PathRepresentable`, use
    ///            `PathRepresentable.metadata(followSymbol:)`.
    public func metadata(followSymbol: Bool = true) -> Metadata? {
        return try? metadata(atPath:followSymbol:)(self.pathString, followSymbol)
    }
}
