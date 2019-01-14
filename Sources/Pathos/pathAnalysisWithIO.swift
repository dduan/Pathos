#if os(Linux)
import Glibc
#else
import Darwin
#endif

// TODO: missing docstring.
public func expandUserDirectory(inPath path: String) throws -> String {
    if !path.starts(with: "~") {
        return path
    }

    var foundOne = false
    let secondSeparatorIndex = path.firstIndex { c in
        if c == kSeparatorCharacter {
            foundOne = true
            return false
        }
        return foundOne && c == kSeparatorCharacter
    }
    var userHome = ""
    let index = secondSeparatorIndex ?? path.firstIndex(of: kSeparatorCharacter) ?? path.endIndex
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

    let result = _stripFromRight(userHome, kSeparatorCharacter) + String(path[index...])
    return result.isEmpty ? "/" : result
}

// TODO: missing docstring.
// TODO: `makeAboslute` sounds like the path is being altered
public func makeAbsolute(path: String) throws -> String {
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
public func relativePath(ofPath path: String) throws -> String {
    let startingPath = try makeAbsolute(path: kCurrentDirectory)
    let path = try makeAbsolute(path: path)
    return relativePath(ofPath: path, startingFromPath: startingPath)
}

/// Return the canonical path of the specified filename, eliminating any symbolic links encountered in the
/// path (if they are supported by the operating system). The result is alway an absolute path.
///
/// - Parameter path: the path to look up for.
/// - Throws: System error encountered while reading link content or converting relative path to absolute
///           path.
public func realPath(ofPath path: String) throws -> String {
    func _join(_ path: String, _ rest: String, seen: inout [String: String]) throws -> (String, Bool) {
        var path = path
        var rest = rest
        if isAbsolute(path: rest) {
            rest = String(rest.dropFirst())
            path = kSeparator
        }

        while !rest.isEmpty {
            var parts = rest.split(separator: kSeparatorCharacter, maxSplits: 1,
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
            if !((try? isSymbolicLink(atPath: newPath)) ?? false) {
                path = newPath
                continue
            }

            if let cachedPath = seen[newPath] {
                path = cachedPath
                if !path.isEmpty {
                    continue
                }
                return try (join(paths: path, readSymbolicLink(atPath: newPath)), false)
            }

            seen[newPath] = ""
            var success = false
            (path, success) = try _join(path, readSymbolicLink(atPath: newPath), seen: &seen)
            if !success {
                return (join(paths: path, rest), false)
            }

            seen[newPath] = path
        }

        return (path, true)
    }

    var cache = [String: String]()
    let (result, _) = try _join("", path, seen: &cache)
    return try makeAbsolute(path: result)
}

extension PathRepresentable {
    // TODO: missing docstring.
    public func expandUserDirectory() -> Self {
        return Self(string: (try? expandUserDirectory(inPath:)(self.pathString)) ?? "/")
    }

    // TODO: missing docstring.
    public func makeAbsolute() -> Self {
        return (try? makeAbsolute(path:)(self.pathString)).map(Self.init) ?? self
    }

    /// Return the relative location from the current working directory. The original value is returned if an
    /// error was encountered while trying to access current working directory.
    /// Example: starting from `/Users/dan`, the relative path of `/` would be `../..`.
    /// - Returns: a relative file path to current working directory.
    public func relativePath() -> Self {
        let result = try? relativePath(ofPath:)(self.pathString)
        return result.map(Self.init(string:)) ?? self
    }

    /// Return the canonical path of self, eliminating any symbolic links encountered in the
    /// path (if they are supported by the operating system). The original path is returned if any error
    /// occurs (see documentation for `realPath(ofPath:)` for errors that could occur).
    public var realPath: Self {
        return (try? realPath(ofPath:)(self.pathString)).map(Self.init) ?? self
    }
}
