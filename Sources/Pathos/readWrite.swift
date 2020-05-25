#if os(Linux)
import Glibc
#elseif os(macOS)
import Darwin
#elseif os(Windows)
import WinSDK
#endif

func _writeAtPath(_ path: String, bytes: UnsafeRawPointer, byteCount: Int, createIfNecessary: Bool, truncate: Bool, permission: FilePermission?) throws {
#if os(Windows)
    let behavior: Int32
    /// https://stackoverflow.com/a/14469641
    switch (createIfNecessary, truncate) {
        case (true, true):
            behavior = CREATE_ALWAYS
        case (true, false):
            behavior = OPEN_ALWAYS
        case (false, true):
            behavior = TRUNCATE_EXISTING
        case (false, false):
            behavior = OPEN_EXISTING
    }

    let handle = CreateFileA(
        path,
        DWORD(GENERIC_WRITE),
        0,
        nil,
        DWORD(behavior),
        permission?.rawValue ?? DWORD(FILE_ATTRIBUTE_NORMAL),
        nil
    )

    if handle == INVALID_HANDLE_VALUE {
        throw SystemError.unknown(errorNumber: GetLastError())
    }

    defer { CloseHandle(handle) }

    var bytesWritten: DWORD = 0
    let writeIsSuccess = WriteFile(handle, bytes, DWORD(byteCount), &bytesWritten, nil)
    if !writeIsSuccess {
        throw SystemError.unknown(errorNumber: GetLastError())
    }
#else // POSIX
    let oflag = O_WRONLY | (createIfNecessary ? O_CREAT : 0) | (truncate ? O_TRUNC : 0)
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
#endif
}

/// Read content of a file at `path` as bytes. If the path is a directory, no bytes will be read.
///
/// - Parameter path: the path to the file that will be read. If the path is a directory, no bytes will be read.
/// - Throws: System error encountered while opening the file.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.readBytes()`.
public func readBytes(atPath path: String) throws -> [UInt8] {
#if os(Windows)
    let handle = CreateFileA(
        path,
        GENERIC_READ,
        DWORD(FILE_SHARE_READ),
        nil,
        DWORD(OPEN_EXISTING),
        DWORD(FILE_ATTRIBUTE_NORMAL | FILE_FLAG_OVERLAPPED),
        nil)

    if handle == INVALID_HANDLE_VALUE {
        throw SystemError.unknown(errorNumber: GetLastError())
    }

    defer { CloseHandle(handle) }

    let fileSize = GetFileSize(handle, nil)
    if fileSize == INVALID_FILE_SIZE {
        throw SystemError.unknown(errorNumber: GetLastError())
    }

    var buffer = UnsafeMutableBufferPointer<UInt8>.allocate(capacity: Int(fileSize))
    defer { buffer.deallocate() }

    var bytesRead: DWORD = 0
    if(!ReadFile(handle, buffer.baseAddress!, fileSize, &bytesRead, nil)) {
        throw SystemError.unknown(errorNumber: GetLastError())
    }
    return [UInt8](buffer)
#else // POSIX
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
    read(fd, buffer.baseAddress!, fileSize)
    return [UInt8](buffer)
#endif
}

/// Read the content of file at `path` as an UTF-8 string. If the path points to a directory, empty string will be returned. If other encoding is desired, use `readBytes` and encode separetely.
///
/// - Parameter path: path at which the content will be read.
/// - Returns: content of the file as an UTF-8 string.
/// - Throws: System error encountered while opening the file.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.readString()`.
public func readString(atPath path: String) throws -> String {
    let content = try readBytes(atPath: path)
    return String(decodingCString: content + [0], as: UTF8.self)
}

// TODO: missing docstring.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.write(_:createIfNecessary:permission:)`.
public func write<Bytes>(_ bytes: Bytes, atPath path: String, createIfNecessary: Bool = true, truncate: Bool = true, permission: FilePermission? = nil) throws where Bytes: Collection, Bytes.Element: BinaryInteger {
    let buffer = bytes.map(UInt8.init(truncatingIfNeeded:))
    try _writeAtPath(path, bytes: buffer, byteCount: buffer.count, createIfNecessary: createIfNecessary, truncate: truncate, permission: permission)
}

// TODO: missing docstring.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.write(_:createIfNecessary:permission:)`.
public func write(_ string: String, atPath path: String, createIfNecessary: Bool = true, truncate: Bool = true, permission: FilePermission? = nil) throws {
    try string.utf8CString.withUnsafeBytes { bytes in
        try _writeAtPath(path, bytes: bytes.baseAddress!, byteCount: bytes.count - 1, createIfNecessary: createIfNecessary, truncate: truncate, permission: permission)
    }
}

extension PathRepresentable {
    /// Read content of a file as bytes.  If the path is a directory, no bytes
    /// will be read.
    ///
    /// If an error is encounterd while opening or reading the file, no bytes
    /// will be returned.
    /// - SeeAlso: `readBytes(atPath:)`.
    public func readBytes() -> [UInt8] {
        return (try? readBytes(atPath:)(self.pathString)) ?? []
    }

    /// Read the content of file at this path as an UTF-8 string. If the path points to a directory, empty string will be returned. If other encoding is desired, use `readBytes` and encode separetely. If an error is encountered opening the file, an empty string will be returned.
    ///
    /// - Returns: content of the file as an UTF-8 string.
    /// - SeeAlso: `readString(atPath:)`.
    public func readString() -> String {
        return (try? readString(atPath:)(self.pathString)) ?? ""
    }

    // TODO: missing docstring. Remember to note the byte truncating!
    /// - SeeAlso: `write(_:atPath:createIfNecessary:permission:)`.
    @discardableResult
    public func write<Bytes>(_ bytes: Bytes, createIfNecessary: Bool = true, truncate: Bool = true, permission: FilePermission? = nil) -> Bool where Bytes: Collection, Bytes.Element: BinaryInteger {
        do {
            try write(_:atPath:createIfNecessary:truncate:permission:)(bytes, self.pathString, createIfNecessary, truncate, permission)
        } catch {
            return false
        }
        return true
    }

    // TODO: missing docstring.
    /// - SeeAlso: `write(_:atPath:createIfNecessary:permission:)`.
    @discardableResult
    public func write(_ string: String, createIfNecessary: Bool = true, truncate: Bool = true, permission: FilePermission? = nil) -> Bool {
        do {
            try write(_:atPath:createIfNecessary:truncate:permission:)(string, self.pathString, createIfNecessary, truncate, permission)
        } catch {
            return false
        }
        return true
    }
}
