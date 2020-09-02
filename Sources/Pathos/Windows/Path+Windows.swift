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
}
#endif // os(Windows)
