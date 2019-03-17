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
        fd = open(path, oflag, kDefaultPermission.rawValue)
    }
    defer { close(fd) }
    if fd == -1 {
        throw SystemError(posixErrorCode: errno)
    }
    if pwrite(fd, bytes, byteCount, 0) == -1 {
        throw SystemError(posixErrorCode: errno)
    }
}

/// Read content of a file at `path` as bytes. If the path is a directory, no bytes will be read.
///
/// - Parameter path: the path to the file that will be read. If the path is a directory, no bytes will be read.
/// - Throws: System error encountered while opening the file.
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

/// Read the content of file at `path` as an UTF-8 string. If the path points to a directory, empty string will be returned. If other encoding is desired, use `readBytes` and encode separetely.
///
/// - Parameter path: path at which the content will be read.
/// - Returns: content of the file as an UTF-8 string.
/// - Throws: System error encountered while opening the file.
public func readString(atPath path: String) throws -> String {
    var content = try readBytes(atPath: path)
    content.append(0)
    return String(decodingCString: content, as: UTF8.self)
}

// TODO: missing docstring.
public func write<Bytes>(_ bytes: Bytes, atPath path: String, createIfNecessary: Bool = true, permission: FilePermission? = nil) throws where Bytes: Collection, Bytes.Element: BinaryInteger {
    let buffer = bytes.map(UInt8.init(truncatingIfNeeded:))
    try _writeAtPath(path, bytes: buffer, byteCount: buffer.count, createIfNecessary: createIfNecessary, permission: permission)
}

// TODO: missing docstring.
public func write(_ string: String, atPath path: String, createIfNecessary: Bool = true, permission: FilePermission? = nil) throws {
    try string.utf8CString.withUnsafeBytes { bytes in
        try _writeAtPath(path, bytes: bytes.baseAddress!, byteCount: bytes.count, createIfNecessary: createIfNecessary, permission: permission)
    }
}

extension PathRepresentable {
    /// Read content of a file as bytes.  If the path is a directory, no bytes
    /// will be read.
    ///
    /// If an error is encounterd while opening or reading the file, no bytes
    /// will be returned.
    public func readBytes() -> [UInt8] {
        return (try? readBytes(atPath:)(self.pathString)) ?? []
    }

    /// Read the content of file at this path as an UTF-8 string. If the path points to a directory, empty string will be returned. If other encoding is desired, use `readBytes` and encode separetely. If an error is encountered opening the file, an empty string will be returned.
    ///
    /// - Returns: content of the file as an UTF-8 string.
    public func readString() -> String {
        return (try? readString(atPath:)(self.pathString)) ?? ""
    }

    // TODO: missing docstring. Remember to note the byte truncating!
    @discardableResult
    public func write<Bytes>(_ bytes: Bytes, createIfNecessary: Bool = true, permission: FilePermission? = nil) -> Bool where Bytes: Collection, Bytes.Element: BinaryInteger {
        do {
            try write(_:atPath:createIfNecessary:permission:)(bytes, self.pathString, createIfNecessary, permission)
        } catch {
            return false
        }
        return true
    }

    // TODO: missing docstring.
    @discardableResult
    public func write(_ string: String, createIfNecessary: Bool = true, permission: FilePermission? = nil) -> Bool {
        do {
            try write(_:atPath:createIfNecessary:permission:)(string, self.pathString, createIfNecessary, permission)
        } catch {
            return false
        }
        return true
    }
}
