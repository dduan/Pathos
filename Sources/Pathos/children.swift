import Darwin

func _typedChildrenInPath(_ path: String, _ type: Int32?, recursive: Bool = false) throws -> [String] {
    var result = [String]()
    let bufferPointer = UnsafeMutablePointer<UnsafeMutablePointer<UnsafeMutablePointer<dirent>?>?>.allocate(capacity: 0)
    let count = Int(scandir(path, bufferPointer, nil, alphasort))
    if count == -1 {
        throw SystemError.unknown(errorNumber: errno)
    }

    result.reserveCapacity(count)
    let buffer = UnsafeBufferPointer(start: bufferPointer.pointee, count: Int(count))
    for d in buffer {
        guard var entry = d?.pointee,
            case let pathType = Int32(entry.d_type),
            type == nil || pathType == type,
            case let nameLength = Int(entry.d_namlen + 1),
            let nameBuffer = UnsafeBufferPointer(start: &entry.d_name.0, count: nameLength).baseAddress,
            case let name = String(cString: nameBuffer),
            name != ".." && name != "."
            else
        {
            continue
        }

        let fullName = join(path: path, withOtherPaths: name)
        result.append(fullName)
        if recursive && pathType == DT_DIR {
            result += try _typedChildrenInPath(join(path: path, withOtherPaths: fullName), type, recursive: true)
        }
    }

    free(bufferPointer)
    return result
}

func _children<T>(_ path: T, recursive: Bool, block: (String, Bool) throws -> [String]) -> [T] where T: PathRepresentable {
    let result = try? block(path.pathString, recursive)
        .map(T.init(path:))
    return result ?? []
}

func children(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, nil, recursive: recursive)
}

func unknownTypeFiles(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, DT_FIFO, recursive: recursive)
}

func pipes(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, DT_UNKNOWN, recursive: recursive)
}

func characterDevices(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, DT_CHR, recursive: recursive)
}

func directories(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, DT_DIR, recursive: recursive)
}

func blockDevices(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, DT_BLK, recursive: recursive)
}

func files(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, DT_REG, recursive: recursive)
}

func symbolicLinks(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, DT_LNK, recursive: recursive)
}

func sockets(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, DT_SOCK   , recursive: recursive)
}

extension PathRepresentable {
    func children(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: children(inPath:recursive:))
    }

    func unkownTypeFiles(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: unknownTypeFiles(inPath:recursive:))
    }

    func pipes(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: pipes(inPath:recursive:))
    }

    func characterDevices(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: characterDevices(inPath:recursive:))
    }

    func directories(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: directories(inPath:recursive:))
    }

    func blockDevices(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: blockDevices(inPath:recursive:))
    }

    func files(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: files(inPath:recursive:))
    }

    func symbolicLinks(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: symbolicLinks(inPath:recursive:))
    }

    func sockets(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: sockets(inPath:recursive:))
    }
}
