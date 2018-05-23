#if os(Linux)
import Glibc
#else
import Darwin
#endif

/// Whether file at path is a named pipe (FIFO).
///
/// - Parameter path: the path to be tested.
/// - Returns: `true` if file at path is a named pipe (FIFO), `false` otherwise.
/// - Throws: A `SystemError` originated from the OS.
func isPipe(atPath path: String) throws -> Bool {
    return try _ifmt(_stat(at: path)) == S_IFIFO
}

// TODO: can this be described better? macOS headers refers to this as "character special"
/// Whether file at path is a character device.
///
/// - Parameter path: the path to be tested.
/// - Returns: `true` if file at path is a character device, `false` otherwise.
/// - Throws: A `SystemError` originated from the OS.
func isCharacterDevice(atPath path: String) throws -> Bool {
    return try _ifmt(_stat(at: path)) == S_IFCHR
}

/// Whether file at path is a directory.
///
/// - Parameter path: the path to be tested.
/// - Returns: `true` if file at path is a directory, `false` otherwise.
/// - Throws: A `SystemError` originated from the OS.
func isDirectory(atPath path: String) throws -> Bool {
    return try _ifmt(_stat(at: path)) == S_IFDIR
}

// TODO: can this be described better? macOS headers refers to this as "block special"
/// Whether file at path is a block device.
///
/// - Parameter path: the path to be tested.
/// - Returns: `true` if file at path is a block device, `false` otherwise.
/// - Throws: A `SystemError` originated from the OS.
func isBlockDevice(atPath path: String) throws -> Bool {
    return try _ifmt(_stat(at: path)) == S_IFBLK
}

/// Whether file at path is a regular file.
///
/// - Parameter path: the path to be tested.
/// - Returns: `true` if file at path is a regular file, `false` otherwise.
/// - Throws: A `SystemError` originated from the OS.
func isFile(atPath path: String) throws -> Bool {
    return try _ifmt(_stat(at: path)) == S_IFREG
}

/// Whether file at path is a symbolic link.
///
/// - Parameter path: the path to be tested.
/// - Returns: `true` if file at path is a symbolic link, `false` otherwise.
/// - Throws: A `SystemError` originated from the OS.
func isSymbolicLink(atPath path: String) throws -> Bool {
    return try _ifmt(_lstat(at: path)) == S_IFLNK
}

/// Whether file at path is a socket.
///
/// - Parameter path: the path to be tested.
/// - Returns: `true` if file at path is a socket, `false` otherwise.
/// - Throws: A `SystemError` originated from the OS.
func isSocket(atPath path: String) throws -> Bool {
    return try _ifmt(_stat(at: path)) == S_IFSOCK
}

/// Return `true` if path refers to an existing path or an open file descriptor. Returns `false` for
/// broken symbolic links. On some platforms, this function may return `false` if permission is not
/// granted to execute `stat` on the requested file, even if the path physically exists.
///
/// - Parameter path: the path to be tested.
/// - Returns: whether path refers to an existing path or an open file descriptor.
func exists(atPath path: String) -> Bool {
    var status = stat()
    return stat(path, &status) == 0
}

/// Return `true` if path refers to an existing path. Returns `true` for broken symbolic links.
/// Equivalent to exists() on platforms lacking `lstat`.
///
/// - Parameter path: the path to be tested.
/// - Returns: whether path refers to an existing path or an open file descriptor. `true` for broken links.
func existsSymbolically(atPath path: String) -> Bool {
    var status = stat()
    return lstat(path, &status) == 0
}

/// Return the size in bytes of path.
///
/// - Parameter path: the path to be tested.
/// - Returns: size of the file at path.
/// - Throws: A `SystemError` if the file does not exist or is inaccessible.
func size(atPath path: String) throws -> Int64 {
    return Int64(try _stat(at: path).st_size)
}

/// Return the time of last modification of path.
///
/// - Parameter path: path to be queried.
/// - Returns: modification time in `FileTime`.
/// - Throws: A `SystemError` if the file does not exist or is inaccessible.
func modificationTime(atPath path: String) throws -> FileTime {
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
func accessTime(atPath path: String) throws -> FileTime {
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
func metadataChangeTime(atPath path: String) throws -> FileTime {
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
/// - Returns: whethec the 2 paths points to the same file.
/// - Throws: A `SystemError` if either path cannot be accessed for some reason.
func sameFile(atPath path: String, otherPath: String) throws -> Bool {
    return try _sameStat(_stat(at: path), _stat(at: otherPath))
}

extension PathRepresentable {
    /// Whether file at path is a named pipe (FIFO). Returns `false` if the path does not exist or is
    /// not accessible.
    var isPipe: Bool {
        return (try? isPipe(atPath:)(self.pathString)) ?? false
    }

    // TODO: can this be described better? macOS headers refers to this as "character special"
    /// Whether file at path is a character device. Returns `false` if the path does not exist or is
    /// not accessible.
    var isCharacterDevice: Bool {
        return (try? isCharacterDevice(atPath:)(self.pathString)) ?? false
    }

    /// Whether file at path is a directory. Returns `false` if the path does not exist or is
    /// not accessible.
    var isDirectory: Bool {
        return (try? isDirectory(atPath:)(self.pathString)) ?? false
    }

    // TODO: can this be described better? macOS headers refers to this as "block special"
    /// Whether file at path is a block device. Returns `false` if the path does not exist or is
    /// not accessible.
    var isBlockDevice: Bool {
        return (try? isBlockDevice(atPath:)(self.pathString)) ?? false
    }

    /// Whether file at path is a regular file. Returns `false` if the path does not exist or is
    /// not accessible.
    var isFile: Bool {
        return (try? isFile(atPath:)(self.pathString)) ?? false
    }

    /// Whether file at path is a symbolic link. Returns `false` if the path does not exist or is
    /// not accessible.
    var isSymbolicLink: Bool {
        return (try? isSymbolicLink(atPath:)(self.pathString)) ?? false
    }

    /// Whether file at path is a symbolic link. Returns `false` if the path does not exist or is
    /// not accessible.
    var isSocket: Bool {
        return (try? isSocket(atPath:)(self.pathString)) ?? false
    }

    /// Return `true` if path refers to an existing path or an open file descriptor. Returns `false` for
    /// broken symbolic links. On some platforms, this function may return `false` if permission is not
    /// granted to execute `stat` on the requested file, even if the path physically exists.
    var exists: Bool {
        return exists(atPath:)(self.pathString)
    }

    /// Return `true` if path refers to an existing path. Returns `true` for broken symbolic links.
    /// Equivalent to exists() on platforms lacking `lstat`.
    var existsSymbolically: Bool {
        return existsSymbolically(atPath:)(self.pathString)
    }

    /// Return the size in bytes of path. Returns `false` if the path does not exist or is
    /// not accessible.
    var size: Int64 {
        return (try? size(atPath:)(self.pathString)) ?? 0
    }

    /// Return the time of last modification. Returns `nil` if the path does not exist or is
    /// not accessible.
    var modificationTime: FileTime? {
        return try? modificationTime(atPath:)(self.pathString)
    }

    /// Return the time of last access. Returns `nil` if the path does not exist or is
    /// not accessible.
    var accessTime: FileTime? {
        return try? accessTime(atPath:)(self.pathString)
    }

    /// Return the system’s ctime which, on some systems (like Unix) is the time of the last metadata change,
    /// Returns `nil` if the path does not exist or is not accessible.
    var metadataChangeTime: FileTime? {
        return try? metadataChangeTime(atPath:)(self.pathString)
    }

    /// Return whether `path` points to the same file as `other`. Returns `false` if either path cannot
    /// be accessed for some reason.
    ///
    /// - Parameter other: the other path in comparison.
    /// - Returns: whethec the 2 paths points to the same file.
    func isSame(as other: Self) -> Bool {
        return (try? sameFile(atPath:otherPath:)(self.pathString, other.pathString)) ?? false
    }
}

