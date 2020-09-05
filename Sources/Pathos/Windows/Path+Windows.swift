#if os(Windows)
import WinSDK
extension Path {
    public static func workingDirectory() throws -> Path {
        let binary = try ContiguousArray<WindowsEncodingUnit>(unsafeUninitializedCapacity: Int(MAX_PATH))
        { buffer, count in
            let length = GetCurrentDirectoryW(DWORD(MAX_PATH), buffer.baseAddress)
            if length == 0 {
                throw SystemError(code: GetLastError())
            } else {
                count = Int(length)
            }
        }

        return Path(binary)
    }

    public static func setWorkingDirectory(_ path: Path) throws {
        if !SetCurrentDirectoryW(path.binaryString.cString) {
            throw SystemError(code: GetLastError())
        }
    }

    public func metadata(followSymlink: Bool = false) throws -> Metadata {
        let binary = try followSymlink ? realPath().binaryString : binaryString
        var data = WIN32_FIND_DATAW()
        let handle = FindFirstFileW(binary.cString, &data)
        if handle == INVALID_HANDLE_VALUE {
            throw SystemError(code: GetLastError())
        }

        defer {
            CloseHandle(handle)
        }

        return Metadata(data)
    }

    public func children(recursive: Bool = false) throws -> [(Path, FileType)] {
        var result = [(Path, FileType)]()
        var data = WIN32_FIND_DATAW()
        let handle = FindFirstFileW((self + "*").binaryString.cString, &data)
        if handle == INVALID_HANDLE_VALUE {
            throw SystemError(code: GetLastError())
        }

        defer {
            CloseHandle(handle)
        }

        func addResultIfNecessary(_ data: inout WIN32_FIND_DATAW) throws {
            if data.cFileName.0 == WindowsConstants.binaryCurrentContext {
                if data.cFileName.1 == 0
                    || data.cFileName.1 == WindowsConstants.binaryCurrentContext && data.cFileName.2 == 0
                {
                    return
                }
            }

            let binary = withUnsafePointer(
                to: data.cFileName,
                { $0.withMemoryRebound(
                    to: WindowsEncodingUnit.self,
                    capacity: Int(MAX_PATH)
                ) { WindowsBinaryString(cString: $0) }
                }
            )

            let path = joined(with: binary)
            let meta = Metadata(data)

            if recursive && meta.fileType.isDirectory {
                result += try path.children(recursive: true)
            }

            result.append((path, meta.fileType))
        }

        try addResultIfNecessary(&data)

        while FindNextFileW(handle, &data) {
            try addResultIfNecessary(&data)
        }

        return result
    }

    /// Set new permissions for a file path.
    ///
    /// - Parameter permissions: The new file permission.
    public func set(_ permissions: Permissions) throws {
        guard let windowsAttributes = permissions as? WindowsAttributes else {
            fatalError("Attempting to set incompatable permissions")
        }

        if !SetFileAttributesW(binaryString.cString, windowsAttributes.rawValue) {
            throw SystemError(code: GetLastError())
        }
    }

    private func realPath() throws -> Path {
        let handle = CreateFileW(
            binaryString.cString,
            0,
            0,
            nil,
            DWORD(OPEN_EXISTING),
            DWORD(FILE_FLAG_BACKUP_SEMANTICS),
            nil
        )

        if handle == INVALID_HANDLE_VALUE {
            throw SystemError(code: GetLastError())
        }

        defer {
            CloseHandle(handle)
        }

        let binary = try ContiguousArray<WindowsEncodingUnit>(unsafeUninitializedCapacity: Int(MAX_PATH))
        { buffer, count in
            let length = GetFinalPathNameByHandleW(handle, buffer.baseAddress, DWORD(MAX_PATH), DWORD(FILE_NAME_OPENED))

            if length == 0 {
                throw SystemError(code: GetLastError())
            }

            count = Int(length)
        }

        return Path(binary)
    }
}
#endif // os(Windows)
