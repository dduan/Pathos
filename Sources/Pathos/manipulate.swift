#if os(Linux)
import Glibc
#else
import Darwin
#endif

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
