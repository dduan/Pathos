# Pathos API Documentation for `Path`

* [Components of a path][]
* [Joining/concatenating paths][]
* [Working with temporary directories][]
* [Current working directory][]
* [Discover related paths][]
* [Symbolic link (symlink)][]
* [Working with metadata][]
* [Editing the file system][]
* [Reading/Writing normal files][]

```swift
public struct Path
```

`Path` is the primary access point for Pathos APIs. It stores a path's value in binary format.
A `Path` points to a theoretical location in the virtual file system. It does not represent what
does or does not actually resides at the location.


### Conforms to

* [POSIXPathConvertible][]
* [WindowsPathConvertible][]
* Comparable
* CustomStringConvertible
* Equatable
* ExpressibleByStringLiteral
* Hashable

### Initializers

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

## Components of a path <a id="components-of-a-path"></a>

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

## Joining/concatenating paths <a id="joining-paths"></a>

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

TODO: link to PathConvertible

## Working with temporary directories <a id="working-with-temporary-directories"></a>

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
    run action: @escaping (Path) throws -> Void
) throws
```

## Current working directory <a id="current-working-directory"></a>

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
public func asWorkingDirectory(run action: @escaping () throws -> Void) throws
```


## Discover related paths <a id="discover-related-paths"></a>

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

## Symbolic link (symlink) <a id="symlink"></a>

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

## Working with metadata <a id="working-with-metadata"></a>

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

## Editing the file system <a id="editing-the-file-system"></a>
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

## Reading/Writing normal files <a id="reading-writing-normal-files"></a>

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

[Components of a path]: #components-of-a-path
[Joining/concatenating paths]: #joining-paths
[Working with temporary directories]: #working-with-temporary-directories
[Current working directory]: #current-working-directory
[Discover related paths]: #discover-related-paths
[Symbolic link (symlink)]: #symlink
[Working with metadata]: #working-with-metadata
[Editing the file system]: #editing-the-file-system
[Reading/Writing normal files]: #reading-writing-normal-files
[POSIXPathConvertible]: POSIXPathConvertible.md
[WindowsPathConvertible]: WindowsPathConvertible.md
[PurePath]: PurePath.md
[NativeEncodingUnit]: NativeEncodingUnit.md
[Path]: Path.md
[PathConvertible]: PathConvertible.md
