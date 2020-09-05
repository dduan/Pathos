#if os(Windows)

import WinSDK

public struct WindowsAttributes: OptionSet {
    // MARK: - OptionSet

    /// Attributes from Windows API. E.g. `WIN32_FIND_DATAW.dwFileAttributes'.
    public var rawValue: DWORD

    public init(rawValue: DWORD) {
        self.rawValue = rawValue
    }

    // MARK: -

    /// A file or directory that is an archive file or directory. Applications typically use this
    /// attribute to mark files for backup or removal .
    public static let archive = WindowsAttributes(rawValue: DWORD(FILE_ATTRIBUTE_ARCHIVE))
    /// A file or directory that is compressed. For a file, all of the data in the file is
    /// compressed. For a directory, compression is the default for newly created files and
    /// subdirectories.
    public static let compressed = WindowsAttributes(rawValue: DWORD(FILE_ATTRIBUTE_COMPRESSED))
    /// This value is reserved for system use.
    public static let device = WindowsAttributes(rawValue: DWORD(FILE_ATTRIBUTE_DEVICE))
    /// The handle that identifies a directory.
    public static let directory = WindowsAttributes(rawValue: DWORD(FILE_ATTRIBUTE_DIRECTORY))
    /// A file or directory that is encrypted. For a file, all data streams in the file are
    /// encrypted. For a directory, encryption is the default for newly created files and
    /// subdirectories.
    public static let encrypted = WindowsAttributes(rawValue: DWORD(FILE_ATTRIBUTE_ENCRYPTED))
    /// The file or directory is hidden. It is not included in an ordinary directory listing.
    public static let hidden = WindowsAttributes(rawValue: DWORD(FILE_ATTRIBUTE_HIDDEN))
    /// The directory or user data stream is configured with integrity (only supported on ReFS
    /// volumes). It is not included in an ordinary directory listing. The integrity setting persists
    /// with the file if it's renamed. If a file is copied the destination file will have integrity
    /// set if either the source file or destination directory have integrity set.
    public static let integrityStream = WindowsAttributes(rawValue: DWORD(FILE_ATTRIBUTE_INTEGRITY_STREAM))
    /// A file that does not have other attributes set. This attribute is valid only when used alone.
    public static let normal = WindowsAttributes(rawValue: DWORD(FILE_ATTRIBUTE_NORMAL))
    /// The file or directory is not to be indexed by the content indexing service.
    public static let notContentIndexed = WindowsAttributes(rawValue: DWORD(FILE_ATTRIBUTE_NOT_CONTENT_INDEXED))
    /// The user data stream not to be read by the background data integrity scanner (AKA scrubber).
    /// When set on a directory it only provides inheritance. This flag is only supported on Storage
    /// Spaces and ReFS volumes. It is not included in an ordinary directory listing.
    public static let noScrubData = WindowsAttributes(rawValue: DWORD(FILE_ATTRIBUTE_NO_SCRUB_DATA))
    /// The data of a file is not available immediately. This attribute indicates that the file data is physically moved to offline storage. This attribute is used by Remote Storage, which is the hierarchical storage management software. Applications should not arbitrarily change this attribute.
    public static let offline = WindowsAttributes(rawValue: DWORD(FILE_ATTRIBUTE_OFFLINE))
    /// A file that is read-only. Applications can read the file, but cannot write to it or delete
    /// it. This attribute is not honored on directories. For more information, see You cannot view
    /// or change the Read-only or the System attributes of folders in Windows Server 2003, in
    /// Windows XP, in Windows Vista or in Windows 7.
    public static let readonly = WindowsAttributes(rawValue: DWORD(FILE_ATTRIBUTE_READONLY))
    /// When this attribute is set, it means that the file or directory is not fully present
    /// locally. For a file that means that not all of its data is on local storage (e.g. it may be
    /// sparse with some data still in remote storage). For a directory it means that some of the
    /// directory contents are being virtualized from another location. Reading the file / enumerating
    /// the directory will be more expensive than normal, e.g. it will cause at least some of the
    /// file/directory content to be fetched from a remote store. Only kernel-mode callers can set
    /// this bit.
    public static let recallOnDataAccess = WindowsAttributes(rawValue: DWORD(FILE_ATTRIBUTE_RECALL_ON_DATA_ACCESS))
    /// This attribute only appears in directory enumeration classes (FILE_DIRECTORY_INFORMATION,
    /// FILE_BOTH_DIR_INFORMATION, etc.). When this attribute is set, it means that the file or
    /// directory has no physical representation on the local system; the item is virtual. Opening the
    /// item will be more expensive than normal, e.g. it will cause at least some of it to be fetched
    /// from a remote store.
    public static let recallOnOpen = WindowsAttributes(rawValue: DWORD(FILE_ATTRIBUTE_RECALL_ON_OPEN))
    /// A file or directory that has an associated reparse point, or a file that is a symbolic link.
    public static let reparsePoint = WindowsAttributes(rawValue: DWORD(FILE_ATTRIBUTE_REPARSE_POINT))
    /// A file that is a sparse file.
    public static let sparseFile = WindowsAttributes(rawValue: DWORD(FILE_ATTRIBUTE_SPARSE_FILE))
    /// A file or directory that the operating system uses a part of, or uses exclusively.
    public static let system = WindowsAttributes(rawValue: DWORD(FILE_ATTRIBUTE_SYSTEM))
    /// A file that is being used for temporary storage. File systems avoid writing data back to
    /// mass storage if sufficient cache memory is available, because typically, an application
    /// deletes a temporary file after the handle is closed. In that scenario, the system can entirely
    /// avoid writing the data. Otherwise, the data is written after the handle is closed.
    public static let temporary = WindowsAttributes(rawValue: DWORD(FILE_ATTRIBUTE_TEMPORARY))
    /// This value is reserved for system use.
    public static let virtual = WindowsAttributes(rawValue: DWORD(FILE_ATTRIBUTE_VIRTUAL))
}

extension WindowsAttributes: Permissions {
    public var isReadOnly: Bool {
        get {
            contains(.readonly)
        }

        set {
            if newValue {
                insert(.readonly)
            } else {
                remove(.readonly)
            }
        }
    }
}
#endif // os(Windows)
