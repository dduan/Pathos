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

    public func metadata(followSymlink: Bool = false) throws -> Metadata {
        let binary = try followSymlink ? realPath().binaryString : binaryString
        var data = WIN32_FIND_DATAW()
        let handle = FindFirstFileW(binary.cString, &data)
        if handle == INVALID_HANDLE_VALUE {
            throw SystemError(code: GetLastError())
        }

        return Metadata(data)
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
