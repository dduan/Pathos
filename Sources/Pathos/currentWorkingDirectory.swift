#if os(Linux)
import Glibc
#else
import Darwin
#endif

public func getCurrentWorkingDirectory() throws -> String {
    if let buffer = getcwd(nil, 0) {
        return String(cString: buffer)
    }
    throw SystemError(posixErrorCode: errno)
}

public func setCurrentWorkingDirectory(to path: String) throws {
    if chdir(path) != 0 {
        throw SystemError(posixErrorCode: errno)
    }
}

extension PathRepresentable {
    public static var currentWorkingDirectory: Self {
        get {
            return Self(string: (try? getCurrentWorkingDirectory()) ?? "")
        }

        set {
            try? setCurrentWorkingDirectory(to:)(newValue.pathString)
        }
    }

    public var currentWorkingDirectory: Self {
        get {
            return Self(string: (try? getCurrentWorkingDirectory()) ?? "")
        }

        set {
            try? setCurrentWorkingDirectory(to:)(newValue.pathString)
        }
    }
}

