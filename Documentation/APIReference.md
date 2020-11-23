# Pathos API Reference

This document is a complete reference to Pathos' public API.

Conventions used in this document:

* `var`s, `func`s, `static func`s are members of a type in the enclosing documentation section.
  Types are defined in the global scope of the package regardless of where the documentation is
  listed.
* Members of a type that satisfies a protocol is documented in the section of the protocol. It is
  omitted from the conforming type itself.

##### Table of content

* [Path][]
    * [Components of a path][]
    * [Joining/concatenating paths][]
    * [Working with temporary directories][]
    * [Current working directory][]
    * [Discover related paths][]
    * [Symbolic link (symlink)][]
    * [Working with metadata][]
    * [Editing the file system][]
    * [Reading/Writing normal files][]
* [PurePath][]
    * [PurePOSIXPath][]
    * [PureWindowsPath][]
* [Metadata][]
    * [FileTime][]
    * [FileType][]
        * [POSIXFileType][]
        * [WindowsFileType][]
    * [Permissions][]
        * [POSIXPermissions][]
        * [WindowsAttributes][]
* [PathConvertible][]
    * [POSIXPathConvertible][]
    * [WindowsPathConvertible][]
* [Miscellaneous][]
    * [SystemError][]
    * [NativeEncodingUnit][]
    * [Constants][]
        * [WindowsConstants][]
        * [POSIXConstants][]

## Path <a id="path"></a>

```swift
public struct Path
```

`Path` is the primary access point for Pathos APIs. It stores a path's value in binary format.
A `Path` points to a theoretical location in the virtual file system. It does not represent what
does or does not actually resides at the location.


##### Conforms to

* [POSIXPathConvertible][]
* [WindowsPathConvertible][]
* Comparable
* CustomStringConvertible
* Equatable
* ExpressibleByStringLiteral
* Hashable

##### Initializers

```swift
public init(_ pure: PurePath)
```
Create a `Path` from a [PurePath][].

***


```swift
public init(cString: UnsafePointer<NativeEncodingUnit>)
```
Create a `Path` from an unsafe buffer of [NativeEncodingUnit][].

***
```swift
public init(_ string: String)
```

Create a `Path` from a `String`.

#### Components of a path <a id="components-of-a-path"></a>

Pathos includes a set of properties for accessing parts of a path value.

```swift
var drive: String?
```

***

```swift
var root: String?
```

***

```swift
var segments: [String]
```

***

```swift
var name: String?
```

***

```swift
var extension: String?
```

***

```swift
var extensions: [String]
```

***

```swift
var base: Path
```

***

```swift
var parent: Path
```

***

```swift
var parents: AnySequence<Path>
```

***

```swift
var isEmpty: Bool
```

***

```swift
var isAbsolute: Bool
```

#### Joining/concatenating paths <a id="joining-paths"></a>

Joining, or concatenating path segments in a cross-platform manner is a common task. Pathos includes
a series of methods and operator overloads to ensure that [Path][], [PurePath][],
[PathConvertible][], and `String` work together seamlessly as segments of a path¹. If you think
something is a reasonable thing to join with a path, it'll probably work.

```swift
public func joined(with others: PathConvertible...) -> Path
public func joined(with others: [PathConvertible]) -> Path
```

Joining one or more [PathConvertible][]s after this one.

***

```swift
public static func +(lhs: Path, rhs: Path) -> Path
public static func +(lhs: Path, rhs: PurePath) -> Path
public static func +(lhs: PurePath, rhs: Path) -> Path
public static func +(lhs: Path, rhs: String) -> Path
public static func +(lhs: String, rhs: Path) -> Path
public static func +(lhs: String, rhs: Path) -> Path
```

`+` operators that enable path creation with code like `"/" + myPath + "file.md"`.

_¹ an important reason these need to be addressed separately is we want to avoid overloading `+`
when value on both sides are `String`s._

#### PathConvertible <a id="pathconvertible"></a>

```swift
public typealias PathConvertible
```

Types that conform to this protocol can be joined with [Path][] and [PurePath][].

On macOS and Linux, this is aliased to [POSIXPathConvertible][]. On Windows, it is
[WindowsPathConvertible][].

#### POSIXPathConvertible <a id="posixpathconvertible"></a>
```swift
public protocol POSIXPathConvertible
```

Types that conform to this protocol can be joined with [PurePOSIXPath][].

##### Types conforming to `POSIXPathConvertible`

* [Path][]
* [PurePOSIXPath][]

#### WindowsPathConvertible <a id="windowspathconvertible"></a>
```swift
public protocol WindowsPathConvertible
```

Types that conform to this protocol can be joined with [PureWindowsPath][].

##### Types conforming to `WindowsPathConvertible`

* [Path][]
* [PureWindowsPath][]

### Working with temporary directories <a id="working-with-temporary-directories"></a>

It is often desirable to work with a unique, temporary directory where the process has write access.
Pathos includes a few APIs to support this use case.

```swift
public static func searchForDefaultTemporaryDirectory() -> Path
```

***

```swift
public static func makeTemporaryDirectory(
    prefix: String = "",
    suffix: String = ""
) throws -> Path
```
***

```swift
public static func withTemporaryDirectory(
    performAction action: @escaping (Path) throws -> Void
) throws
```

### Current working directory <a id="current-working-directory"></a>

Commonly known as CWD, printed by the `pwd` unix command, etc.

```swift
public static func workingDirectory() throws -> Path
```

***


```swift
public static func setWorkingDirectory(_ path: Path) throws
```

***

```swift
public func asWorkingDirectory(execute action: @escaping () throws -> Void) throws
```


### Discover related paths <a id="discover-related-paths"></a>

A path value have other representations in the file system (e.g. absolute path). It could also lead
to other paths (directory with contents). This section describes APIs related to those.

```swift
public func relative(to other: PathConvertible) -> Path
```

***

```swift
public func absolute() throws -> Path
```

***

```swift
public var normal: Path
```

***

```swift
public static func home() -> Path
```

***

```swift
public func glob() throws -> [Path]
```

***


```swift
public func children(
    recursive: Bool = false,
    followSymlink: Bool = false
) throws -> AnySequence<(Path, FileType)>
```

### Symbolic link (symlink) <a id="symlink"></a>

```swift
public func readSymlink() throws -> Path
```

***

```swift
public func makeSymlink(at path: Path) throws
```
***

```swift
public func real() throws -> Path
```

### Working with metadata <a id="working-with-metadata"></a>

```swift
public func metadata(followSymlink: Bool = false) throws -> Metadata
```

***

```swift
public func exists(followSymlink: Bool = false) -> Bool
```

***

```swift
public func set(_ permissions: Permissions) throws
```

### Editing the file system <a id="editing-the-file-system"></a>
General "CRUD" operation on the file system.

```swift
public func makeDirectory(withParents: Bool = false) throws
```

***

```swift
public func delete(recursive: Bool = true) throws
```

***

```swift
public func copy(
    to destination: Path,
    followSymlink: Bool = true
) throws
```

***

```swift
public func move(to newPath: Path) throws
```

### Reading/Writing normal files <a id="reading-writing-normal-files"></a>

```swift
public func readBytes() throws -> [CChar]
```

***


```swift
public func readString<Encoding>(
    as _: Encoding.Type
) throws -> String
    where Encoding: _UnicodeEncoding
```

***

```swift
public func readUTF8String() throws -> String
```

***

```swift
public func write<Bytes>(
    bytes: Bytes,
    createIfNecessary: Bool = true,
    truncate: Bool = true
) throws where Bytes: Collection, Bytes.Element == UInt8

public func write<Bytes>(
    bytes: Bytes, 
    createIfNecessary: Bool = true,
    truncate: Bool = true
) throws where Bytes: Collection, Bytes.Element == Int8
```

***

```swift
public func write<Encoding>(
    _ string: String,
    encoding: Encoding.Type,
    createIfNecessary: Bool = true,
    truncate: Bool = true
) throws where Encoding: _UnicodeEncoding
```

***

```swift
public func write(_ string: String, createIfNecessary: Bool = true, truncate: Bool = true) throws
```

## PurePath <a id="purepath"></a>

```swift
public typealias PurePath = …
```

`PurePath` is a typealias. It is [PurePOSIXPath][] on macOS and Linux, and [PureWindowsPath][] on
Windows.

### PurePOSIXPath <a id="pureposixpath"></a>

```swift
public struct PurePOSIXPath
```

##### Conforms to

* [POSIXPathConvertible][]
* CustomStringConvertible
* Equatable
* ExpressibleByStringLiteral
* Hashable

##### Initializers

```swift
public init(cString: UnsafePointer<CChar>)
```
Create a `PurePOSIXPath` from an unsafe buffer of `CChar`.

***
```swift
public init(_ string: String)
```

Create a `PurePOSIXPath` from a `String`.

##### Properties

```swift
var drive: String?
```

***

```swift
var root: String?
```

***

```swift
var segments: [String]
```

***

```swift
var name: String?
```

***

```swift
var extension: String?
```

***

```swift
var extensions: [String]
```

***

```swift
var base: PurePOSIXPath
```

***

```swift
var parent: PurePOSIXPath
```

***

```swift
var parents: AnySequence<PurePOSIXPath>
```

***

```swift
var isEmpty: Bool
```

***

```swift
var isAbsolute: Bool
```
***

```swift
public var normal: Path
```

##### Methods

```swift
public func joined(with paths: POSIXPathConvertible) -> Self
public func joined(with paths: [POSIXPathConvertible]) -> Self
```

```swift
public static func +(lhs: PurePOSIXPath, rhs: PurePOSIXPath) -> PurePOSIXPath
public static func +(lhs: PurePOSIXPath, rhs: POSIXPathConvertible) -> PurePOSIXPath
public static func +(lhs: POSIXPathConvertible, rhs: PurePOSIXPath) -> PurePOSIXPath
```

***

```swift
public func relative(to other: POSIXPathConvertible) -> PurePOSIXPath
```

### PureWindowsPath <a id="purewindowspath"></a>

```swift
public struct PureWindowsPath
```

##### Conforms to

* [WindowsPathConvertible][]
* CustomStringConvertible
* Equatable
* ExpressibleByStringLiteral
* Hashable

##### Initializers

```swift
public init(cString: UnsafePointer<CChar>)
```
Create a `PureWindowsPath` from an unsafe buffer of `CChar`.

***
```swift
public init(_ string: String)
```

Create a `PureWindowsPath` from a `String`.

##### Properties

```swift
var drive: String?
```

***

```swift
var root: String?
```

***

```swift
var segments: [String]
```

***

```swift
var name: String?
```

***

```swift
var extension: String?
```

***

```swift
var extensions: [String]
```

***

```swift
var base: PureWindowsPath
```

***

```swift
var parent: PureWindowsPath
```

***

```swift
var parents: AnySequence<PureWindowsPath>
```

***

```swift
var isEmpty: Bool
```

***

```swift
var isAbsolute: Bool
```
***

```swift
public var normal: Path
```

##### Methods

```swift
public func joined(with paths: WindowsPathConvertible) -> Self
public func joined(with paths: [WindowsPathConvertible]) -> Self
```

```swift
public static func +(lhs: PureWindowsPath, rhs: PureWindowsPath) -> PureWindowsPath
public static func +(lhs: PureWindowsPath, rhs: WindowsPathConvertible) -> PureWindowsPath
public static func +(lhs: WindowsPathConvertible, rhs: PureWindowsPath) -> PureWindowsPath
```

***

```swift
public func relative(to other: WindowsPathConvertible) -> PureWindowsPath
```

## Metadata <a id="metadata"></a>

```swift
public struct Metadata
```

OS agnostic information about a file, besides the file itself.

##### Initializers

```swift
public init(
    mode: UInt16,
    size: UInt64, 
    atime: timespec, 
    mtime: timespec,
    btime: timespec
)
```

***

```swift
public init(_ stat: stat)
```

***

```swift
public init(_ data: WIN32_FIND_DATAW)
```

##### Properties

```swift
let fileType: FileType
```

***

```swift
let permissions: Permissions
```
***

```swift
let size: Int64
```

***

```swift
let accessed: FileTime
```

***

```swift
let modified: FileTime
```

***

```swift
let created: FileTime
```

### FileTime <a id="filetime"></a>

```swift
public struct FileTime
```

A time interval broken down into seconds and nanoseconds. This is used to represent a point in time
since 1970-01-01 00:00:00 UTC

##### Initializers

```swift
public init(_ time: timespec)
```

```swift
public init(_ time: FILETIME)
```

##### Properties

```swift
var seconds: Int
```

Number of seconds since 1970-01-01 00:00:00 UTC.

***

```swift
var nanoseconds: Int
```

Number of nanoseconds since `seconds`.

### FileType <a id="filetype"></a>

```swift
public protocol FileType
```

OS agnostic information regarding type of the file.

##### Types Conforming to `FileType`

* [POSIXFileType][]
* [WindowsFileType][]

##### Properties

```swift
var isFile: Bool
```

Whether the path points to a file.

***

```swift
var isDirectory: Bool
```

Whether the path points to a directory.

```swift
var isSymlink: Bool
```

Whether the path points to a symlink.

#### POSIXFileType <a id="posixfiletype"></a>

```swift
public enum POSIXFileType
```

##### Conforms to

* [FileType][]
* Codable
* Equatable

##### Initializers

```swift
public init(rawFileType: Int32)
```

Creates a `POSIXFileType` from a POSIX file type such as `DT_REG`.

***

```swift
public init(rawMode: mode_t)
```

Creates a `POSIXFileType` from a POSIX inode protection mode (`stat.st_mode`) such as `S_IFREG`.

##### Enumuration cases

```swift
case unknown
```

Unknown type.
***

```swift
case pipe
```

A FIFO pipe.
***

```swift
case characterDevice
```

A character device, or character special file.

***

```swift
case directory
```
A directory.

***

```swift
case blockDevice
```

A block device/special file.

***

```swift
case file
```
A regular file.

***

```swift
case symlink
```
A symbolic link, or symlink.

***

```swift
case socket
```
A socket.

#### WindowsFileType <a id="windowsfiletype"></a>

```swift
public struct WindowsFileType
```

##### Conforms to

* [FileType][]
* Equatable

### Permissions <a id="permissions"></a>

```swift
public protocol Permissions
```

OS agnostic permissions for a file path.

##### Types Conforming to Permissions

* POSIXPermissions
* WindowsAttributes

##### Properties

```swift
var isReadOnly: Bool
```

Whether the file is read only. NOTE: setting this value does not change the permission of the path
on file system. Use Path.set(_:) with the updated value to achieve that.

#### POSIXPermissions <a id="posixpermissions"></a>

```swift
public struct POSIXPermissions
```

Represents the POSIX file permission bits. These bits determines read/write/execution access to
a file as well as some miscellaneous information.

##### Conforms to

* [Permissions][]
* ExpressibleByIntegerLiteral
* OptionSet

##### Initializer

```swift
public init(rawValue: mode_t)
```

Creates a `FilePermission` from native `mode_t`.

##### Properties

```swift
public var rawValue: mode_t

```

The file permission as the native `mode_t` type. A de-abstraction to help interact with POSIX APIs
directly.

***

```swift
public static let ownerAll: POSIXPermissions
```

This is equivalent to `[.ownerRead, .ownerWrite, .ownerExecute]` (`S_IRWXU`).

***

```swift
public static let ownerRead: POSIXPermissions
```

Read permission bit for the owner of the file (`S_IRUSR`).

***

```swift
public static let ownerWrite: POSIXPermissions
```

Write permission bit for the owner of the file (`S_IWUSR`).

***

```swift
public static let ownerExecute: POSIXPermissions
```

Execute (for ordinary files) or search (for directories) permission bit for the owner of the file
(`S_IXUSR`).

***

```swift
public static let groupAll: POSIXPermissions
```

This is equivalent to `[.groupRead, .groupWrite, .groupExecute]` (`S_IRWXG`).

***

```swift
public static let groupRead: POSIXPermissions
```

Read permission bit for the group owner of the file (`S_IRGRP`).

***

```swift
public static let groupWrite: POSIXPermissions
```

Write permission bit for the group owner of the file (`S_IWGRP`).

***

```swift
public static let groupExecute: POSIXPermissions
```

Execute or search permission bit for the group owner of the file (`S_IXGRP`).

***

```swift
public static let otherAll: POSIXPermissions
```

This is equivalent to `[.otherRead, .otherWrite, .otherExecute]` (`S_IRWXO`).

***

```swift
public static let otherRead: POSIXPermissions
```

Read permission bit for other users (`S_IROTH`).

***

```swift
public static let otherWrite: POSIXPermissions
```

Read permission bit for other users (`S_IWOTH`).

***

```swift
public static let otherExecute: POSIXPermissions
```

Read permission bit for other users (`S_IXOTH`).

***

```swift
public static let setUserIDOnExecution: POSIXPermissions
```

This is the set-user-ID on execute bit. See [Process Persona][] to learm more.

***

```swift

public static let setGroupIDOnExecution: POSIXPermissions
```

This is the set-group-ID on execute bit See [Process Persona][] to learm more.

***

```swift

public static let saveSwappedTextAfterUser: POSIXPermissions
```

This is the sticky bit.

For a directory it gives permission to delete a file in that directory only if you own that file.
Ordinarily, a user can either delete all the files in a directory or cannot delete any of them
(based on whether the user has write permission for the directory). The same restriction applies—you
must have both write permission for the directory and own the file you want to delete. The one
exception is that the owner of the directory can delete any file in the directory, no matter who
owns it (provided the owner has given himself write permission for the directory). This is commonly
used for the /tmp directory, where anyone may create files but not delete files created by other
users.

#### WindowsAttributes <a id="windowsattributes"></a>

```swift
public struct WindowsAttributes
```

##### Conforms to

* [Permissions][]
* OptionSet

##### Initializers

```swift
public init(rawValue: DWORD)
```

***

##### Properties

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


## Miscellaneous <a id="miscellaneous"></a>

### NativeEncodingUnit <a id="nativeencodingunit"></a>
```swift
public typealias NativeEncodingUnit
```

This is the String encoding unit on each OS. On macOS and Linux, it is aliased to `CChar`. On
Windows, it is `UInt16`.

### SystemError <a id="systemerror"></a>

```swift
public enum SystemError
```

An error returned by the OS.


##### Conforms to

* Equatable
* Error

##### Nested type aliases

```swift
public typealias Code
```

On macOS and Linux, it is aliased to `Int32`. On Windows, it is `UInt32`.

##### Initializers

```swift
public init(code: Code)
```

##### Enumeration cases

```swift
case unspecified(errorCode: Code)
```

Unspecified error returned by the OS.

### Constants <a id="constants"></a>

```swift
public typealias Constants
```

This is some constants that users can use to extend Pathos in a consistent manner. On macOS and
Linux, it is aliased to [POSIXConstants][]. On Windows, it is [WindowsConstants][].

#### POSIXConstants <a id="posixconstants"></a>

```swift
public enum POSIXConstants
```

#### Properties

```swift
public static let binaryPathSeparator: CChar
```

Appropriate path separator native to the current operating system.

***

```swift
let pathSeparator: Character
```

Appropriate path separator character.

#### WindowsConstants <a id="windowsconstants"></a>

```swift
public enum WindowsConstants
```

#### Properties

```swift
public static let binaryPathSeparator: CChar
```

Appropriate path separator native to Windows.

***

```swift
let pathSeparator: Character
```

Appropriate path separator character.

[Path]: #path
[Components of a path]: #components-of-a-path
[Joining/concatenating paths]: #joining-paths
[Working with temporary directories]: #working-with-temporary-directories
[Current working directory]: #current-working-directory
[Discover related paths]: #discover-related-paths
[Symbolic link (symlink)]: #symlink
[Working with metadata]: #working-with-metadata
[Editing the file system]: #editing-the-file-system
[Reading/Writing normal files]: #reading-writing-normal-files
[PathConvertible]: #pathconvertible
[POSIXPathConvertible]: #posixpathconvertible
[WindowsPathConvertible]: #windowspathconvertible
[SystemError]: #systemerror
[PurePath]: #purepath
[PurePOSIXPath]: #pureposixpath
[PureWindowsPath]: #purewindowspath
[Metadata]: #metadata
[FileTime]: #filetime
[FileType]: #filetype
[POSIXFileType]: #posixfiletype
[WindowsFileType]: #windowsfiletype
[Permissions]: #permissions
[POSIXPermissions]: #posixpermissions
[WindowsAttributes]: #windowsattributes
[Miscellaneous]: #miscellaneous
[NativeEncodingUnit]: #nativeencodingunit
[Constants]: #constants
[POSIXConstants]: #posixconstants
[WindowsConstants]: #windowsconstants
