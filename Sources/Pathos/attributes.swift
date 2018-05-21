import Darwin

func isPipe(atPath path: String) throws -> Bool {
    return try _ifmt(_stat(at: path)) == S_IFIFO
}

func isCharacterDevice(atPath path: String) throws -> Bool {
    return try _ifmt(_stat(at: path)) == S_IFCHR
}

func isDirectory(atPath path: String) throws -> Bool {
    return try _ifmt(_stat(at: path)) == S_IFDIR
}

func isBlockDevice(atPath path: String) throws -> Bool {
    return try _ifmt(_stat(at: path)) == S_IFBLK
}

func isFile(atPath path: String) throws -> Bool {
    return try _ifmt(_stat(at: path)) == S_IFREG
}

func isSymbolicLink(atPath path: String) throws -> Bool {
    return try _ifmt(_lstat(at: path)) == S_IFLNK
}

func isSocket(atPath path: String) throws -> Bool {
    return try _ifmt(_stat(at: path)) == S_IFSOCK
}

func exists(atPath path: String) -> Bool {
    var status = stat()
    return stat(path, &status) == 0
}

func existsSymbolically(atPath path: String) -> Bool {
    var status = stat()
    return lstat(path, &status) == 0
}

func size(atPath path: String) throws -> Int64 {
    return try _stat(at: path).st_size
}

func modificationTime(atPath path: String) throws -> FileTime {
    return unsafeBitCast(try _stat(at: path).st_mtimespec, to: FileTime.self)
}

func accessTime(atPath path: String) throws -> FileTime {
    return unsafeBitCast(try _stat(at: path).st_atimespec, to: FileTime.self)
}

func metadataChangeTime(atPath path: String) throws -> FileTime {
    return unsafeBitCast(try _stat(at: path).st_ctimespec, to: FileTime.self)
}

func sameFile(atPath path: String, otherPath: String) throws -> Bool {
    return try _sameStat(_stat(at: path), _stat(at: otherPath))
}

extension PathRepresentable {
    var isPipe: Bool {
        return (try? isPipe(atPath:)(self.pathString)) ?? false
    }

    var isCharacterDevice: Bool {
        return (try? isCharacterDevice(atPath:)(self.pathString)) ?? false
    }

    var isDirectory: Bool {
        return (try? isDirectory(atPath:)(self.pathString)) ?? false
    }

    var isBlockDevice: Bool {
        return (try? isBlockDevice(atPath:)(self.pathString)) ?? false
    }

    var isFile: Bool {
        return (try? isFile(atPath:)(self.pathString)) ?? false
    }

    var isSymbolicLink: Bool {
        return (try? isSymbolicLink(atPath:)(self.pathString)) ?? false
    }

    var isSocket: Bool {
        return (try? isSocket(atPath:)(self.pathString)) ?? false
    }

    var exists: Bool {
        return exists(atPath:)(self.pathString)
    }

    var existsSymbolically: Bool {
        return existsSymbolically(atPath:)(self.pathString)
    }

    var size: Int64 {
        return (try? size(atPath:)(self.pathString)) ?? 0
    }

    var modificationTime: FileTime? {
        return try? modificationTime(atPath:)(self.pathString)
    }

    var accessTime: FileTime? {
        return try? accessTime(atPath:)(self.pathString)
    }

    var metadataChangeTime: FileTime? {
        return try? metadataChangeTime(atPath:)(self.pathString)
    }

    func isSame(as other: Self) -> Bool {
        return (try? sameFile(atPath:andOtherPath:)(self.pathString, other.pathString)) ?? false
    }
}

