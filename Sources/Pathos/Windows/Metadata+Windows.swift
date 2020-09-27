#if os(Windows)
import WinSDK

extension Metadata {
    public init(_ data: WIN32_FIND_DATAW) {
        accessed = FileTime(data.ftLastAccessTime)
        modified = FileTime(data.ftLastWriteTime)
        created = FileTime(data.ftCreationTime)
        size = Int64(UInt64(data.nFileSizeHigh << 32) | UInt64(data.nFileSizeLow))
        permissions = WindowsAttributes(rawValue: data.dwFileAttributes)

        let isDirectory = data.dwFileAttributes & UInt32(bitPattern: FILE_ATTRIBUTE_DIRECTORY) != 0
        let isSymlink = data.dwFileAttributes & UInt32(bitPattern: FILE_ATTRIBUTE_REPARSE_POINT) != 0 && data.dwReserved0 & 0x2000_0000 != 0
        let isFile = !isDirectory

        fileType = WindowsFileType(
            isFile: isFile,
            isDirectory: isDirectory,
            isSymlink: isSymlink
        )
    }
}
#endif // os(Windows)
