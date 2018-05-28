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
    public var currentWorkingDirectory: Self? {
        get {
            return (try? getCurrentWorkingDirectory()).map(Self.init(path:))
        }

        set {
            if let newWorkingDirectory = newValue {
                try? setCurrentWorkingDirectory(to:)(newWorkingDirectory.pathString)
            }
        }
    }
}

