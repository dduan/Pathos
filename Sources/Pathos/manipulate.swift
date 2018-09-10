#if os(Linux)
import Glibc
#else
import Darwin
#endif

/// Create directory at given path.
///
/// - Parameters:
///   - path: The path at witch the directory is to be created.
///   - mode: Access flags (combined with the proccess's `umask`) for the directory to be created.
///   - createParents: If `true`, any missing parents of this path are created as needed; they are created
///                    with the default permissions without taking mode into account (mimicking the POSIX
///                    `mkdir -p` command). If `false`, a missing parent will cause a `SystemError`. Defaults
///                    to `false`
///   - existOkay: If `false`, a `SystemError` is thrown if the target directory (or any of it's parent, if it
///                needs creation) already exists.
/// - Throws: A `SystemError`.
public func makeDirectory(atPath path: String, mode: FilePermission = 0o0755, createParents: Bool = false, existOkay: Bool = false) throws {
    func _makeDirectory() throws {
        if mkdir(path, mode.rawValue) != 0 {
            // Cannot rely on checking for EEXIST, since the operating system
            // could give priority to other errors like EACCES or EROFS
            let error = errno
            if (try? isDirectory(atPath: path)) != true || !existOkay {
                throw SystemError(posixErrorCode: error)
            }
        }
    }

    if !createParents {
        try _makeDirectory()
    }

    var (head, tail) = split(path: path)
    if tail.isEmpty {
        (head, tail) = split(path: head)
    }

    if !head.isEmpty && !tail.isEmpty && !exists(atPath: head) {
        try makeDirectory(atPath: head, createParents: true, existOkay: existOkay)
    }

    if tail == kCurrentDirectory {
        return
    }

    try _makeDirectory()
}

public func deletePath(_ path: String, recursive: Bool = false) throws {
    let status = try _stat(at: path)
    if _ifmt(status) == S_IFDIR {
        if recursive {
            for child in try children(inPath: path) {
                try deletePath(child, recursive: true)
            }
        }
        if rmdir(path) != 0 {
            throw SystemError(posixErrorCode: errno)
        }
    } else {
        if unlink(path) != 0 {
            throw SystemError(posixErrorCode: errno)
        }
    }
}

public func movePath(_ path: String, to other: String) throws {
    if rename(path, other) != 0 {
        throw SystemError(posixErrorCode: errno)
    }
}


extension PathRepresentable {
    /// Create a directory at `pathString`.
    ///
    /// - Parameters:
    ///   - mode: Access flags (combined with the proccess's `umask`) for the directory to be created.
    ///   - createParents: If `true`, any missing parents of this path are created as needed; they are created
    ///                    with the default permissions without taking mode into account (mimicking the POSIX
    ///                    `mkdir -p` command). If `false`, a missing parent will cause a `SystemError`.
    ///                    Defaults to `false`
    ///   - existOkay: If `false`, a `SystemError` is thrown if the target directory (or any of it's parent,
    ///                if it needs creation) already exists.
    /// - Returns: `true` if a directory is created, `false` if an error occured and the directory was not
    ///            created.
    public func makeDirectory(createParents: Bool = false, mode: FilePermission = 0o0755, existOkay: Bool = false) -> Bool {
        do {
            try makeDirectory(atPath:mode:createParents:existOkay:)(self.pathString, mode, createParents, existOkay)
        } catch {
            return false
        }
        return true
    }

    public func delete(recursive: Bool = false) -> Bool {
        do {
            try deletePath(_:recursive:)(self.pathString, recursive)
        } catch {
            return false
        }
        return true
    }

    public func move(to destination: Self) -> Bool {
        do {
            try movePath(_:to:)(self.pathString, destination.pathString)
        } catch {
            return false
        }
        return true
    }
}
