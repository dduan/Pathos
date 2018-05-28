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
            type == nil || pathType == type,
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
            type == nil || pathType == type,
            case let nameLength = Int(entry.d_namlen + 1),
            let nameBuffer = UnsafeBufferPointer(start: &entry.d_name.0, count: nameLength).baseAddress,
            case let name = String(cString: nameBuffer),
            name != ".." && name != "."
            else
        {
            continue
        }
#endif

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
        .map(T.init(string:))
    return result ?? []
}

public func children(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, nil, recursive: recursive)
}

public func unknownTypeFiles(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_FIFO), recursive: recursive)
}

public func pipes(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_UNKNOWN), recursive: recursive)
}

public func characterDevices(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_CHR), recursive: recursive)
}

public func directories(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_DIR), recursive: recursive)
}

public func blockDevices(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_BLK), recursive: recursive)
}

public func files(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_REG), recursive: recursive)
}

public func symbolicLinks(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_LNK), recursive: recursive)
}

public func sockets(inPath path: String, recursive: Bool = false) throws -> [String] {
    return try _typedChildrenInPath(path, Int32(DT_SOCK), recursive: recursive)
}

extension PathRepresentable {
    public func children(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: children(inPath:recursive:))
    }

    public func unkownTypeFiles(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: unknownTypeFiles(inPath:recursive:))
    }

    public func pipes(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: pipes(inPath:recursive:))
    }

    public func characterDevices(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: characterDevices(inPath:recursive:))
    }

    public func directories(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: directories(inPath:recursive:))
    }

    public func blockDevices(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: blockDevices(inPath:recursive:))
    }

    public func files(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: files(inPath:recursive:))
    }

    public func symbolicLinks(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: symbolicLinks(inPath:recursive:))
    }

    public func sockets(recursive: Bool = false) -> [Self] {
        return _children(self, recursive: recursive, block: sockets(inPath:recursive:))
    }
}
