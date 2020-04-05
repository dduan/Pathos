#if os(Linux)
import Glibc
#else
import Darwin
#endif

/// Return the argument with an initial component of `~` or `~user` replaced by that user’s home directory.
/// - Parameter path: The path whose initial component is to be expanded.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.withExpandedUserDirectory`.
public func expandUserDirectory(inPath path: String) throws -> String {
    if !path.starts(with: "~") {
        return path
    }

    var foundOne = false
    let secondSeparatorIndex = path.firstIndex { c in
        if c == pathSeparatorCharacter {
            foundOne = true
            return false
        }
        return foundOne && c == pathSeparatorCharacter
    }
    var userHome = ""
    let index = secondSeparatorIndex ?? path.firstIndex(of: pathSeparatorCharacter) ?? path.endIndex
    if foundOne && secondSeparatorIndex == nil || index == path.index(after: path.startIndex)  {
        let homeFromEnv = getenv("HOME")
        errno = 0
        let userPasswd = getpwuid(getuid())
        if userPasswd == nil && errno != 0 {
            throw SystemError(posixErrorCode: errno)
        }

        guard let homePointer = userPasswd?.pointee.pw_dir else {
            return path
        }
        userHome = String(cString: homeFromEnv ?? homePointer)
    } else {
        let userName = String(path[path.index(after: path.startIndex)..<index])
        errno = 0
        let userPasswd = getpwnam(userName)
        if userPasswd == nil && errno != 0 {
            throw SystemError(posixErrorCode: errno)
        }

        guard let homePointer = userPasswd?.pointee.pw_dir else {
            return path
        }
        userHome = String(cString: homePointer)
    }

    let result = _stripFromRight(userHome, pathSeparatorCharacter) + String(path[index...])
    return result.isEmpty ? "/" : result
}

/// Return a normalized absolutized version of the path.
/// - Parameter path: the path which is is to be absolutized.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.absolutePath`.
public func absolutePath(ofPath path: String) throws -> String {
    var path = path
    if !isAbsolute(path: path) {
        guard let buffer = getcwd(nil, 0) else {
            throw SystemError(posixErrorCode: errno)
        }

        path = join(paths: String(cString: buffer), path)
    }

    return normalize(path: path)
}

/// Return the relative location of `path` from the current working directory.
/// Example: starting from `/Users/dan`, the relative path of `/` would be `../..`.
/// - Parameter path: the path the result is relative to.
/// - Returns: a relative file path to current working directory.
/// - Throws: system error resulted from trying to access current working directory.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.relativePath`.
public func relativePath(ofPath path: String) throws -> String {
    let startingPath = try absolutePath(ofPath: kCurrentDirectory)
    let path = try absolutePath(ofPath: path)
    return relativePath(ofPath: path, startingFromPath: startingPath)
}

/// Return the canonical path of the specified filename, eliminating any symbolic links encountered in the
/// path (if they are supported by the operating system). The result is alway an absolute path.
///
/// - Parameter path: the path to look up for.
/// - Throws: System error encountered while reading link content or converting relative path to absolute
///           path.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.realPath`.
public func realPath(ofPath path: String) throws -> String {
    func _join(_ path: String, _ rest: String, seen: inout [String: String]) throws -> (String, Bool) {
        var path = path
        var rest = rest
        if isAbsolute(path: rest) {
            rest = String(rest.dropFirst())
            path = pathSeparator
        }

        while !rest.isEmpty {
            var parts = rest.split(separator: pathSeparatorCharacter, maxSplits: 1,
                                   omittingEmptySubsequences: false)
            if parts.count < 2 {
                parts.append("")
            }

            var name = String(parts[0])
            if name.isEmpty || name == kCurrentDirectory {
                continue
            }

            rest = String(parts[1])

            if name == kParentDirectory {
                if !path.isEmpty {
                    (path, name) = split(path: path)
                    if name == kParentDirectory {
                        path = join(paths: path, kParentDirectory, kParentDirectory)
                    }
                } else {
                    path = join(paths: path, name)
                }

                continue
            }

            let newPath = join(paths: path, name)
            if !((try? isA(.symlink, atPath: newPath)) ?? false) {
                path = newPath
                continue
            }

            if let cachedPath = seen[newPath] {
                path = cachedPath
                if !path.isEmpty {
                    continue
                }
                return try (join(paths: path, readSymlink(atPath: newPath)), false)
            }

            seen[newPath] = ""
            var success = false
            (path, success) = try _join(path, readSymlink(atPath: newPath), seen: &seen)
            if !success {
                return (join(paths: path, rest), false)
            }

            seen[newPath] = path
        }

        return (path, true)
    }

    var cache = [String: String]()
    let (result, _) = try _join("", path, seen: &cache)
    return try absolutePath(ofPath: result)
}

extension PathRepresentable {
    /// Return the path with an initial component of `~` or `~user` replaced by that user’s home directory.
    /// - SeeAlso: `expandUserDirectory(inPath:)`.
    public var withExpandedUserDirectory: Self {
        return Self((try? expandUserDirectory(inPath:)(self.pathString)) ?? "/")
    }

    /// Return a normalized absolutized version of path.
    /// - SeeAlso: `absolutePath(ofPath:)`.
    public var absolutePath: Self {
        return (try? absolutePath(ofPath:)(self.pathString)).map(Self.init) ?? self
    }

    /// Return the relative location from the current working directory. The original value is returned if an
    /// error was encountered while trying to access current working directory.
    /// Example: starting from `/Users/dan`, the relative path of `/` would be `../..`.
    /// - Returns: a relative file path to current working directory.
    /// - SeeAlso: `relativePath(ofPath:)`.
    public var relativePath: Self {
        let result = try? relativePath(ofPath:)(self.pathString)
        return result.map(Self.init) ?? self
    }

    /// Return the canonical path of self, eliminating any symbolic links encountered in the
    /// path (if they are supported by the operating system). The original path is returned if any error
    /// occurs (see documentation for `realPath(ofPath:)` for errors that could occur).
    /// - SeeAlso: `realPath(ofPath:)`.
    public var realPath: Self {
        return (try? realPath(ofPath:)(self.pathString)).map(Self.init) ?? self
    }
}
