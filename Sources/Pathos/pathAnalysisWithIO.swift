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
public func makeAbsolute(path: String) throws -> String {
    var path = path
    if !isAbsolute(path: path) {
        let buffer = getcwd(nil, 0)
        if buffer == nil {
            throw SystemError(posixErrorCode: errno)
        }
        path = join(path: String(cString: buffer!), withPaths: path)
    }
    return normalize(path: path)
}

// TODO: Missing implementation.
// TODO: Missing unit tests.
/// Return the canonical path of the specified filename, eliminating any symbolic links encountered in the
/// path (if they are supported by the operating system).
///
/// - parameter ofPath: the path to look up for.
public func realPath(ofPath: String) throws -> String {
    fatalError("unimplemented")
}

extension PathRepresentable {
    // TODO: missing docstring.
    public func expandUserDirectory() -> Self {
        return Self(string: (try? expandUserDirectory(inPath:)(self.pathString)) ?? "/")
    }

    // TODO: missing docstring.
    public func makeAbsolute() -> Self {
        return (try? makeAbsolute(path:)(self.pathString)).map(Self.init(string:)) ?? self
    }

    // TODO: Missing unit tests.
    /// Return the canonical path of self, eliminating any symbolic links encountered in the
    /// path (if they are supported by the operating system).
    public var realPath: Self {
        return (try? realPath(ofPath:)(self.pathString)).map(Self.init) ?? self
    }
}
