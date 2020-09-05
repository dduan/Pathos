#if os(Windows)
import WinSDK

extension Metadata {
    public init(_ data: WIN32_FIND_DATAW) {
        accessed = FileTime(data.ftLastAccessTime)
        modified = FileTime(data.ftLastWriteTime)
        created = FileTime(data.ftCreationTime)
        size = Int64(UInt64(data.nFileSizeHigh << 32) | UInt64(data.nFileSizeLow))
        permissions = WindowsAttributes(rawValue: data.dwFileAttributes)
        if data.dwFileAttributes & UInt32(bitPattern: FILE_ATTRIBUTE_DIRECTORY) != 0 {
            fileType = WindowsFileType.directory
        } else if data.dwFileAttributes & UInt32(bitPattern: FILE_ATTRIBUTE_REPARSE_POINT) != 0 && data.dwReserved0 & 0x2000_0000 != 0 {
            fileType = WindowsFileType.symlink
        } else {
            fileType = WindowsFileType.file
        }
    }
}
#endif // os(Windows)
