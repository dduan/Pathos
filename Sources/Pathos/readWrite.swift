import Darwin

func _writeAtPath(_ path: String, bytes: UnsafeRawPointer, byteCount: Int, createIfNecessary: Bool, mode: FilePermission?) throws {
    let oflag = createIfNecessary ? O_WRONLY | O_CREAT : O_WRONLY
    let fd: Int32
    if let mode = mode {
        fd = open(path, oflag, mode.rawValue)
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

func readBytes(atPath path: String) throws -> [UInt8] {
    guard case let fd = open(path, O_RDONLY), fd != -1 else {
        throw SystemError(posixErrorCode: errno)
    }

    defer { close(fd) }
    var status = stat()
    fstat(fd, &status)
    let fileSize = Int(status.st_size)
    var buffer = UnsafeMutableBufferPointer<UInt8>.allocate(capacity: fileSize + 1)
    defer { buffer.deallocate() }
    pread(fd, buffer.baseAddress!, fileSize, 0)
    let end = buffer.endIndex.advanced(by: -1)
    buffer[end] = 0
    return [UInt8](buffer[..<end])
}

func readString(atPath path: String) throws -> String {
    var content = try readBytes(atPath: path)
    return String(cString: &content)
}

func writeBytes<Bytes>(atPath path: String, _ bytes: Bytes, createIfNecessary: Bool = true, mode: FilePermission? = nil) throws where Bytes: Collection, Bytes.Element == UInt8 {
    let buffer = [UInt8](bytes)
    try _writeAtPath(path, bytes: buffer, byteCount: buffer.count, createIfNecessary: createIfNecessary, mode: mode)
}

func writeString(atPath path: String, _ string: String, createIfNecessary: Bool = true, mode: FilePermission? = nil) throws {
    try string.utf8CString.withUnsafeBytes { bytes in
        try _writeAtPath(path, bytes: bytes.baseAddress!, byteCount: bytes.count, createIfNecessary: createIfNecessary, mode: mode)
    }
}

extension PathRepresentable {
    func readBytes() -> [UInt8] {
        return (try? readBytes(atPath:)(self.pathString)) ?? []
    }

    func readString() -> String {
        return (try? readString(atPath:)(self.pathString)) ?? ""
    }

    func writeBytes<Bytes>(bytes: Bytes, createIfNecessary: Bool = true, mode: FilePermission? = nil) -> Bool where Bytes: Collection, Bytes.Element == UInt8 {
        do {
            try writeBytes(atPath:_:createIfNecessary:mode:)(self.pathString, bytes, createIfNecessary, mode)
        } catch {
            return false
        }
        return true
    }

    func writeString(string: String, createIfNecessary: Bool = true, mode: FilePermission? = nil) -> Bool {
        do {
            try writeString(atPath:_:createIfNecessary:mode:)(self.pathString, string, createIfNecessary, mode)
        } catch {
            return false
        }
        return true
    }
}
