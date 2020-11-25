# Pathos API Documentation for `WindowsAttributes`

```swift
public struct WindowsAttributes
```

### Conforms to

* [Permissions][]
* OptionSet

### Initializers

```swift
public init(rawValue: DWORD)
```

***

### Properties

```swift
var rawValue: DWORD
```

Attributes from Windows API. E.g. `WIN32_FIND_DATAW.dwFileAttributes`.

***

```swift
public static let archive: WindowsAttributes
```

A file or directory that is an archive file or directory. Applications typically use this attribute
to mark files for backup or removal .

***

```swift
public static let compressed: WindowsAttributes
```

A file or directory that is compressed. For a file, all of the data in the file is compressed. For
a directory, compression is the default for newly created files and subdirectories.  to mark files
for backup or removal .

***

```swift
public static let device: WindowsAttributes
```

This value is reserved for system use.

***

```swift
public static let directory: WindowsAttributes
```

The handle that identifies a directory.

***

```swift
public static let encrypted: WindowsAttributes
```

A file or directory that is encrypted. For a file, all data streams in the file are encrypted. For
a directory, encryption is the default for newly created files and subdirectories.

***

```swift
public static let hidden: WindowsAttributes
```

The file or directory is hidden. It is not included in an ordinary directory listing.

***

```swift
public static let integrityStream: WindowsAttributes
```

The directory or user data stream is configured with integrity (only supported on ReFS volumes). It
is not included in an ordinary directory listing. The integrity setting persists with the file if
it's renamed. If a file is copied the destination file will have integrity set if either the source
file or destination directory have integrity set.

***

```swift
public static let normal: WindowsAttributes
```

A file that does not have other attributes set. This attribute is valid only when used alone.

***

```swift
public static let notContentIndexed: WindowsAttributes
```

The file or directory is not to be indexed by the content indexing service.

***

```swift
public static let noScrubData: WindowsAttributes
```

The user data stream not to be read by the background data integrity scanner (AKA scrubber). When
set on a directory it only provides inheritance. This flag is only supported on Storage Spaces and
ReFS volumes. It is not included in an ordinary directory listing.

***

```swift
public static let offline: WindowsAttributes
```

The data of a file is not available immediately. This attribute indicates that the file data is
physically moved to offline storage. This attribute is used by Remote Storage, which is the
hierarchical storage management software. Applications should not arbitrarily change this attribute.

***

```swift
public static let readonly: WindowsAttributes
```

A file that is read-only. Applications can read the file, but cannot write to it or delete it. This
attribute is not honored on directories. For more information, see You cannot view or change the
Read-only or the System attributes of folders in Windows Server 2003, in Windows XP, in Windows
Vista or in Windows 7.

***

```swift
public static let recallOnDataAccess: WindowsAttributes
```

When this attribute is set, it means that the file or directory is not fully present locally. For
a file that means that not all of its data is on local storage (e.g. it may be sparse with some data
still in remote storage). For a directory it means that some of the directory contents are being
virtualized from another location. Reading the file / enumerating the directory will be more
expensive than normal, e.g. it will cause at least some of the file/directory content to be fetched
from a remote store. Only kernel-mode callers can set this bit.

***
```swift
public static let recallOnOpen: WindowsAttributes
```

This attribute only appears in directory enumeration classes (FILE_DIRECTORY_INFORMATION,
FILE_BOTH_DIR_INFORMATION, etc.). When this attribute is set, it means that the file or directory
has no physical representation on the local system; the item is virtual. Opening the item will be
more expensive than normal, e.g. it will cause at least some of it to be fetched from a remote
store.

***
```swift
public static let reparsePoint: WindowsAttributes
```

A file or directory that has an associated reparse point, or a file that is a symbolic link.

***
```swift
public static let sparseFile: WindowsAttributes
```

A file that is a sparse file.

***
```swift
public static let system: WindowsAttributes
```

A file or directory that the operating system uses a part of, or uses exclusively.

***
```swift
public static let temporary: WindowsAttributes
```

A file that is being used for temporary storage. File systems avoid writing data back to mass
storage if sufficient cache memory is available, because typically, an application deletes
a temporary file after the handle is closed. In that scenario, the system can entirely avoid writing
the data. Otherwise, the data is written after the handle is closed.

***
```swift
public static let virtual: WindowsAttributes
```

This value is reserved for system use.

[Permissions]: Permissions.md
