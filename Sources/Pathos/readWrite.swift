#if os(Linux)
import Glibc
#else
import Darwin
#endif

func _writeAtPath(_ path: String, bytes: UnsafeRawPointer, byteCount: Int, createIfNecessary: Bool, permission: FilePermission?) throws {
    let oflag = createIfNecessary ? O_WRONLY | O_CREAT : O_WRONLY
    let fd: Int32
    if let permission = permission {
        fd = open(path, oflag, permission.rawValue)
    } else {
        fd = open(path, oflag)
    }
    defer { close(fd) }
    if fd == -1 {
        throw SystemError(posixErrorCode: errno)
    }
    if pwrite(fd, bytes, byteCount, 0) == -1 {
        throw SystemError(posixErrorCode: errno)
    }
}

// TODO: missing docstring.
public func readBytes(atPath path: String) throws -> [UInt8] {
    guard case let fd = open(path, O_RDONLY), fd != -1 else {
        throw SystemError(posixErrorCode: errno)
    }

    defer { close(fd) }
    var status = stat()
    fstat(fd, &status)
    if _ifmt(status) == S_IFDIR {
        return []
    }

    let fileSize = Int(status.st_size)
    var buffer = UnsafeMutableBufferPointer<UInt8>.allocate(capacity: fileSize)
    defer { buffer.deallocate() }
    pread(fd, buffer.baseAddress!, fileSize, 0)
    return [UInt8](buffer)
}

// TODO: missing docstring.
public func readString(atPath path: String) throws -> String {
    var content = try readBytes(atPath: path)
    content.append(0)
    return String(cString: &content)
}

// TODO: missing unit tests.
// TODO: missing docstring.
public func writeBytes<Bytes>(atPath path: String, _ bytes: Bytes, createIfNecessary: Bool = true, permission: FilePermission? = nil) throws where Bytes: Collection, Bytes.Element == UInt8 {
    let buffer = [UInt8](bytes)
    try _writeAtPath(path, bytes: buffer, byteCount: buffer.count, createIfNecessary: createIfNecessary, permission: permission)
}

// TODO: missing unit tests.
// TODO: missing docstring.
public func writeString(atPath path: String, _ string: String, createIfNecessary: Bool = true, mode: FilePermission? = nil) throws {
    try string.utf8CString.withUnsafeBytes { bytes in
        try _writeAtPath(path, bytes: bytes.baseAddress!, byteCount: bytes.count, createIfNecessary: createIfNecessary, permission: permission)
    }
}

extension PathRepresentable {
    // TODO: missing docstring.
    public func readBytes() -> [UInt8] {
        return (try? readBytes(atPath:)(self.pathString)) ?? []
    }

    // TODO: missing docstring.
    public func readString() -> String {
        return (try? readString(atPath:)(self.pathString)) ?? ""
    }

    // TODO: missing unit tests.
    // TODO: missing docstring.
    public func writeBytes<Bytes>(bytes: Bytes, createIfNecessary: Bool = true, permission: FilePermission? = nil) -> Bool where Bytes: Collection, Bytes.Element == UInt8 {
        do {
            try writeBytes(atPath:_:createIfNecessary:permission:)(self.pathString, bytes, createIfNecessary, permission)
        } catch {
            return false
        }
        return true
    }

    // TODO: missing unit tests.
    // TODO: missing docstring.
    public func writeString(string: String, createIfNecessary: Bool = true, mode: FilePermission? = nil) -> Bool {
        do {
            try writeString(atPath:_:createIfNecessary:mode:)(self.pathString, string, createIfNecessary, mode)
        } catch {
            return false
        }
        return true
    }
}
