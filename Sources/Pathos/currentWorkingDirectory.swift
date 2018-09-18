#if os(Linux)
import Glibc
#else
import Darwin
#endif

// TODO: missing docstring.
public func getCurrentWorkingDirectory() throws -> String {
    if let buffer = getcwd(nil, 0) {
        return String(cString: buffer)
    }
    throw SystemError(posixErrorCode: errno)
}

// TODO: missing docstring.
public func setCurrentWorkingDirectory(to path: String) throws {
    if chdir(path) != 0 {
        throw SystemError(posixErrorCode: errno)
    }
}

extension PathRepresentable {
    // TODO: missing docstring.
    public static var currentWorkingDirectory: Self {
        get {
            return Self(string: (try? getCurrentWorkingDirectory()) ?? "")
        }

        set {
            try? setCurrentWorkingDirectory(to:)(newValue.pathString)
        }
    }

    // TODO: missing docstring.
    public var currentWorkingDirectory: Self {
        get {
            return Self(string: (try? getCurrentWorkingDirectory()) ?? "")
        }

        set {
            try? setCurrentWorkingDirectory(to:)(newValue.pathString)
        }
    }
}

