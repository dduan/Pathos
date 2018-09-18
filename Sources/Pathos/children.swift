#if os(Linux)
import Glibc
#else
import Darwin
#endif

func _typedChildrenInPath(_ path: String, _ type: Int32?, recursive: Bool = false) throws -> [String] {
    var result = [String]()
    let bufferPointer = UnsafeMutablePointer<UnsafeMutablePointer<UnsafeMutablePointer<dirent>?>?>.allocate(capacity: 0)
#if os(Linux)
    let sorting: @convention(c) (UnsafeMutablePointer<UnsafePointer<dirent>?>?, UnsafeMutablePointer<UnsafePointer<dirent>?>?) -> Int32 = { p0, p1 in
        return alphasort(p0!, p1!)
    }

    let count = Int(scandir(path, bufferPointer, nil, sorting))
#else
    let count = Int(scandir(path, bufferPointer, nil, alphasort))
#endif
    if count == -1 {
        throw SystemError.unknown(errorNumber: errno)
    }

    result.reserveCapacity(count)
    let buffer = UnsafeBufferPointer(start: bufferPointer.pointee, count: Int(count))
    for d in buffer {
#if os(Linux)
        guard var entry = d?.pointee,
            case let pathType = Int32(entry.d_type),
            type == nil || pathType == type || pathType == DT_DIR,
            case let nameLength = Int(entry.d_reclen + 1),
            let nameBuffer = UnsafeBufferPointer(start: &entry.d_name.0, count: nameLength).baseAddress,
            case let name = String(cString: nameBuffer),
            name != ".." && name != "."
            else
        {
            continue
        }
#else
        guard var entry = d?.pointee,
            case let pathType = Int32(entry.d_type),
            type == nil || pathType == type || pathType == DT_DIR,
            case let nameLength = Int(entry.d_namlen + 1),
            let nameBuffer = UnsafeBufferPointer(start: &entry.d_name.0, count: nameLength).baseAddress,
            case let name = String(cString: nameBuffer),
            name != ".." && name != "."
            else
        {
            continue
        }
#endif

        let fullName = join(path: path, withPaths: name)
        if type == nil || pathType == type {
            result.append(fullName)
        }

        if recursive && pathType == DT_DIR {
            result += try _typedChildrenInPath(join(path: path, withPaths: fullName), type, recursive: true)
        }
    }

    free(bufferPointer)
    return result
}

func _children<T>(_ path: T, recursive: Bool, block: (String, Bool) throws -> [String]) -> [T] where T: PathRepresentable {
    let result = try? block(path.pathString, recursive)
        .map(T.init(string:))
    return result ?? []
}

// TODO: missing docstring.
public func children(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, nil, recursive: recursive)
}

// TODO: missing docstring.
public func unknownTypeFiles(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_FIFO), recursive: recursive)
}

// TODO: missing docstring.
public func pipes(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_UNKNOWN), recursive: recursive)
}

// TODO: missing docstring.
public func characterDevices(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_CHR), recursive: recursive)
}

// TODO: missing docstring.
public func directories(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_DIR), recursive: recursive)
}

// TODO: missing docstring.
public func blockDevices(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_BLK), recursive: recursive)
}

// TODO: missing docstring.
public func files(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_REG), recursive: recursive)
}

// TODO: missing docstring.
public func symbolicLinks(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_LNK), recursive: recursive)
}

// TODO: missing docstring.
public func sockets(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_SOCK), recursive: recursive)
}

extension PathRepresentable {
    // TODO: missing docstring.
    public func children(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: children(inPath:recursive:))
    }

    // TODO: missing docstring.
    public func unknownTypeFiles(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: unknownTypeFiles(inPath:recursive:))
    }

    // TODO: missing docstring.
    public func pipes(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: pipes(inPath:recursive:))
    }

    // TODO: missing docstring.
    public func characterDevices(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: characterDevices(inPath:recursive:))
    }

    // TODO: missing docstring.
    public func directories(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: directories(inPath:recursive:))
    }

    // TODO: missing docstring.
    public func blockDevices(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: blockDevices(inPath:recursive:))
    }

    // TODO: missing docstring.
    public func files(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: files(inPath:recursive:))
    }

    // TODO: missing docstring.
    public func symbolicLinks(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: symbolicLinks(inPath:recursive:))
    }

    // TODO: missing docstring.
    public func sockets(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: sockets(inPath:recursive:))
    }
}
