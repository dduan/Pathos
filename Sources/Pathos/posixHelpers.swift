import Darwin

@inlinable
func _stat(at path: String) throws -> stat {
    var status = stat()
    if stat(path, &status) != 0 {
        throw SystemError(posixErrorCode: errno)
    }

    return status
}

@inlinable
func _lstat(at path: String) throws -> stat {
    var status = stat()
    if lstat(path, &status) != 0 {
        throw SystemError(posixErrorCode: errno)
    }

    return status
}

@inlinable
func _ifmt(_ status: stat) -> mode_t {
    return status.st_mode & S_IFMT
}

@inlinable
func _sameStat(_ a: stat, _ b: stat) -> Bool {
    return a.st_ino == b.st_ino && a.st_dev == b.st_dev
}
