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
public var drive: String?
```

The drive for the path. For POSIX, this is always empty.

***

```swift
public var root: String?
```

Root component of the path. For example, on POSIX this is typically "/".

***

```swift
public var segments: [String]
```

The segments in the path separated by `Constants.binaryPathSeparator`.
Root is not included.

Example: `Path("/usr/bin/env").segments` is `["usr", "bin", "env"]`.

***

```swift
public var name: String?
```

The final path component, if any.

Example: `Path("src/Pathos/README.md").name` is `"README.md"`.

***

```swift
public var extension: String?
```

Final suffix that begins with a `.` in the `name` the path. Leading `.`
in the name does not count.

Example: `Path("archive/Pathos.tar.gz").extension` is `"gz"`.

***

```swift
public var extensions: [String]
```

Suffixes that begin with a `.` in the `name` the path, in the order they appear.
Leading `.` in the name does not count.

Example: `Path("archive/Pathos.tar.gz").extension` is `["tar", "gz"]`.

***

```swift
public var base: Path
```

Path value without the `extension`. 
`path.base + path.extension` should be equal to `path`.

***

```swift
public var parent: Path
```

The logical parent of the path. The parent of an anchor is the anchor itself.
The parent of `.` is `.`. The parent of `/a/b/c` is `/a/b`.

***

```swift
public var parents: AnySequence<Path>
```

A sequence composed of the `self.parent`, `self.parent.parent`, etc. The
final value is either the current context (`Path(".")`) or the root.

Example: `Array(Path("a/b/c")` is `[Path("a/b"), Path("a"), Path(".")]`.

***

```swift
public var isEmpty: Bool
```

The path does not have a drive nor a root, and its `segments` is empty.

***

```swift
public var isAbsolute: Bool
```

Indicates whether this path is absolute.

An absolute path is one that has a root and, if applicable, a drive.

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

**Parameters**

|       |                     |                                      |
|-------|---------------------|--------------------------------------|
| paths | `[PathConvertible]` | Other values that represents a path. |

**Returns**
|        |                          |
| ------ | ------------------------ |
| `Path` | Result of joining paths. |

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

## Working with temporary directories <a id="working-with-temporary-directories"></a>

It is often desirable to work with a unique, temporary directory where the process has write access.
Pathos includes a few APIs to support this use case.

```swift
public static func searchForDefaultTemporaryDirectory() -> Path
```

Search for a temporary directory suitable as the default temprorary directory.

A suitable location is in one of the candidate list and allows write permission for this process.

The list of candidate locations to consider are the following:

* Location defined as the TMPDIR environment variable.
* Location defined as the TMP environment variable.
* Location defined as the TMPDIR environment variable.
* /tmp
* /var/tmp
* /usr/tmp
* Location defined as the `HOME` or `USERPROFILE` environment variable.
* Current working directory.

**Returns** `Path` A suitable default temprary directory.

***

```swift
public static func makeTemporaryDirectory(
    prefix: String = "",
    suffix: String = ""
) throws -> Path
```

Make a temporary directory with write access.

The parent of the return value is the current value of `Path.defaultTemporaryDirectory`. It will
have a randomized name. A prefix and a suffix can be optionally specified as options.


**Parameters**

|        |          |                                                |
| ------ | -------- | ---------------------------------------------- |
| prefix | `String` | A prefix for the temporary directories's name. |
| suffix | `String` | A suffix for the temporary directories's name. |

**Returns**
|        |                        |
| ------ | ---------------------- |
| `Path` | A temporary directory. |


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

Returns the current working directory.

**Returns**
|        |                                                      |
| ------ | ---------------------------------------------------- |
| `Path` | the path representing the current working directory. |

***


```swift
public static func setWorkingDirectory(_ path: Path) throws
```

Set the current working directory.


**Parameters**

|      |        |                            |
| ---- | ------ | -------------------------- |
| path | `Path` | the new working directory. |

***

```swift
public func asWorkingDirectory(run action: @escaping () throws -> Void) throws
```

Set `self` as the current working directory (cwd), run `action`, and
restore the original current working directory after `action` finishes.

**Parameters**

|        |                               |                                                                      |
| ------ | ----------------------------- | -------------------------------------------------------------------- |
| action | `@escaping () throws -> Void` | A closure that runs with `self` being the current working directory. |

## Discover related paths <a id="discover-related-paths"></a>

A path value have other representations in the file system (e.g. absolute path). It could also lead
to other paths (directory with contents). This section describes APIs related to those.

***

```swift
public func relative(to other: PathConvertible) -> Path
```

Return a relative path to `self` from `other`. This is a pure computatian.
File system is not accessed to confirm the existence or nature of `self`
or `other`.

For example, `Path("a/b/c").relative(to: Path("a/b"))` evaluates to
`Path("c")`. That is to say, to get to "a/b/c" from "a/b", one go through
"c".

**Parameters**

|       |                   |                             |
| ----- | ----------------- | --------------------------- |
| other | `PathConvertible` | the path to start from.<br> |

**Returns**
|        |                                             |
| ------ | ------------------------------------------- |
| `Path` | the path that leads from `other` to `self`. |


***

```swift
public func absolute() throws -> Path
```

Return the absolute path for this path.

**Returns**
|        |                    |
| ------ | ------------------ |
| `Path` | the absolute path. |

***

```swift
public var normal: Path
```

Normalize a path by removing redundant separators and up-level
references (`..`). This is a pure computation. It does not access the
file system. Therefore, it may change the meaning of a path that
contains symbolic links.

***

```swift
public static func home() -> Path
```

Returns current user's home directory. Pathos will attempt to retrieve this information via
environment variables first. If that's not sufficient, it'll try to infer from other
methods.

**Returns**
|        |                                         |
| ------ | --------------------------------------- |
| `Path` | The home directory of the current user. |

***

```swift
public func glob() throws -> [Path]
```

Find all the path names matching a specified pattern according to the rules used by the native OS shells.
On POSIX, home directory (tilde, `~`) gets expanded. "Globstar" (`**`) can be included as part of the pattern
to represent all intermediary directories, making the search recursive, similar¹ to pattern expansion on Zsh,
Fish and Bash 4+.

¹ globstar expansion has many quirks and differences among different implementations. Pathos use the
following algorithm:
- find the leftmost occurance of `**` (ignore the rest of occurances).
- split the pattern by middle of the globstar. So `a/**/c/*.swift`, for example, would become `a/*` and
`*/c/*.swift`.
- perform a non-recursive, system glob with the first half (`a/*` from previous example).
- for each result from previous glob that is a directory, recursively find all of its children.
- perform an `fnmatch` or `PathMatchSpecW` with the *full* pattern with each child, return the ones that
match.

² due to libc implementation, there are subtle behaviral differences among platforms. Specifically, broken
symbolic links will not be found on Linux, but it will be included on Darwin.

**Returns**
|          |                                                              |
| -------- | ------------------------------------------------------------ |
| `[Path]` | paths in current working directory that matches the pattern. |

***


```swift
public func children(
    recursive: Bool = false,
    followSymlink: Bool = false
) throws -> AnySequence<(Path, FileType)>
```

List the content of the directory, recursively if required.


**Parameters**

|               |        |                                                                                                                                             |
| ------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------- |
| recursive     | `Bool` | Require content of the directories inside the directory to be included in the<br>result, recursively.                                       |
| followSymlink | `Bool` | If a child is a symlink to a directory, include it, and the directory's<br>children. This option has no effect when `recursive` is `false`. |

**Returns**
|                                 |                                                                                         |
| ------------------------------- | --------------------------------------------------------------------------------------- |
| `AnySequence<(Path, FileType)>` | A sequence containing pair of path and the file type from the content of the
directory. |

## Symbolic link (symlink) <a id="symlink"></a>

```swift
public func readSymlink() throws -> Path
```

Return a path to which a symbolic link points to.

**Returns**
|        |                                 |
| ------ | ------------------------------- |
| `Path` | The target path of the symlink. |

***

```swift
public func makeSymlink(at path: Path) throws
```

Create a symbolic link to `self`.

**Parameters**

|      |        |                                          |
| ---- | ------ | ---------------------------------------- |
| path | `Path` | The path at which to create the symlink. |

***

```swift
public func real() throws -> Path
```

Return the canonical path of `self`, eliminating any symbolic links encountered in the path.

When symbolic link cycles occur, the returned path will be one member of the cycle, but no
guarantee is made about which member that will be.

**Returns**
|        |                                                            |
| ------ | ---------------------------------------------------------- |
| `Path` | The canonical path of `self` with all symlinks eliminated. |

## Working with metadata <a id="working-with-metadata"></a>

```swift
public func metadata(followSymlink: Bool = false) throws -> Metadata
```

Return the metadata for the content pointed at by `self`.

**Parameters**

|               |        |                                                                                                                                    |
| ------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------- |
| followSymlink | `Bool` | Follow and resolve symlink and retrive metadata for its target.<br>`false` means metadata for the symlink itself will be returned. |

**Returns**
|            |                        |
| ---------- | ---------------------- |
| `Metadata` | metadata for the path. |

***

```swift
public func exists(followSymlink: Bool = false) -> Bool
```

Return `true` if path refers to an existing path.
On some platforms, this function may return `false` if permission is not
granted to retrieve metadata on the requested file, even if the path physically exists.


**Parameters**

|               |        |                                                                                           |
| ------------- | ------ | ----------------------------------------------------------------------------------------- |
| followSymlink | `Bool` | whether to follow symbolic links. If `true`, return `false` for<br>broken symbolic links. |

**Returns**
|        |                                                                     |
| ------ | ------------------------------------------------------------------- |
| `Bool` | whether path refers to an existing path or an open file descriptor. |

***

```swift
public func set(_ permissions: Permissions) throws
```

## Editing the file system <a id="editing-the-file-system"></a>
General "CRUD" operation on the file system.

```swift
public func makeDirectory(withParents: Bool = false) throws
```

Create a directory, and, optionally, any intermediate directories that leads to it, if they don't
exist yet.

**Parameters**

|             |        |                                                                                                                                                                                                                                                                             |
| ----------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| withParents | `Bool` | Create intermediate directories as required. If this option is not specified,<br>the full path prefix of each operand must already exist.<br>On the other hand, with this option specified, no error will be reported if a<br>directory given as an operand already exists. |

***

```swift
public func delete(recursive: Bool = true) throws
```

Delete content at `self`.
Content of directory is deleted alongside the directory itself, unless specified otherwise.

**Parameters**

|           |        |                                                                                                                              |
| --------- | ------ | ---------------------------------------------------------------------------------------------------------------------------- |
| recursive | `Bool` | `true` means content of non-empty direcotry will be deleted along<br>with the directory itself. `true` is the default value. |

***

```swift
public func copy(
    to destination: Path,
    followSymlink: Bool = true
) throws
```

Copy content of `self` to `destination`.

**Parameters**

|               |        |                                                                                                                                    |
| ------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------- |
| destination   | `Path` | The target location for the copied content.                                                                                        |
| followSymlink | `Bool` | If the content is a symlink, `true` means the target of the symlink will<br>get copied. Otherwise, the symlink itself gets copied. |


***

```swift
public func move(to newPath: Path) throws
```

Move a file or direcotry to a new path. If the destination already exist, write over it.

**Parameters**

|         |        |                                               |
| ------- | ------ | --------------------------------------------- |
| newPath | `Path` | New path for the content at the current path. |

## Reading/Writing normal files <a id="reading-writing-normal-files"></a>

```swift
public func readBytes() throws -> [CChar]
```

Read from a normal file.

**Returns**
|           |                                    |
| --------- | ---------------------------------- |
| `[UInt8]` | binary content of the normal file. |

***


```swift
public func readString<Encoding>(
    as encoding: Encoding.Type
) throws -> String
    where Encoding: _UnicodeEncoding
```

Read string from a normal file.

**Parameters**

|          |                 |                                                   |
| -------- | --------------- | ------------------------------------------------- |
| encoding | `Encoding.Type` | The encoding to use to decode the file's content. |

**Returns**
|          |                                              |
| -------- | -------------------------------------------- |
| `String` | The file's content decoded using `encoding`. |

***

```swift
public func readUTF8String() throws -> String
```

Read string from a normal file decoded using UTF-8.

**Returns**
|          |                                              |
| -------- | -------------------------------------------- |
| `String` | The file's content decoded using `encoding`. |

***

```swift
public func write<Bytes>(
    bytes: Bytes,
    createIfNecessary: Bool = true,
    truncate: Bool = true
) throws where Bytes: Collection, Bytes.Element == UInt8
```


Write bytes (`UInt8`s) to a normal file.

**Parameters**

|                   |         |                                                                                                             |
| ----------------- | ------- | ----------------------------------------------------------------------------------------------------------- |
| bytes             | `Bytes` | A collection of bytes.                                                                                      |
| createIfNecessary | `Bool ` | `true` means when `self` is not a normal file,<br>attempt to create it, as opposed to throwing an<br>error. |
| truncate          | `Bool ` | delete existing content of the file and write from the<br>start.                                            |

***

```swift
public func write<Bytes>(
    bytes: Bytes, 
    createIfNecessary: Bool = true,
    truncate: Bool = true
) throws where Bytes: Collection, Bytes.Element == Int8
```

Write bytes (`Int8`s) to a normal file.

**Parameters**

|                   |         |                                                                                                             |
| ----------------- | ------- | ----------------------------------------------------------------------------------------------------------- |
| bytes             | `Bytes` | A collection of bytes.                                                                                      |
| createIfNecessary | `Bool ` | `true` means when `self` is not a normal file,<br>attempt to create it, as opposed to throwing an<br>error. |
| truncate          | `Bool ` | delete existing content of the file and write from the<br>start.                                            |
***

```swift
public func write<Encoding>(
    _ string: String,
    encoding: Encoding.Type,
    createIfNecessary: Bool = true,
    truncate: Bool = true
) throws where Encoding: _UnicodeEncoding
```

Write content of `string` encoded using `encoding`.

**Parameters**

|                   |                 |                                                                                                             |
| ----------------- | --------------- | ----------------------------------------------------------------------------------------------------------- |
| string            | `String       ` | The string to write.                                                                                        |
| encoding          | `Encoding.Type` | The encoding to use for the string.                                                                         |
| createIfNecessary | `Bool         ` | `true` means when `self` is not a normal file,<br>attempt to create it, as opposed to throwing an<br>error. |
| truncate          | `Bool         ` | delete existing content of the file and write from the<br>start.                                            |

***

```swift
public func write(utf8 string: String, createIfNecessary: Bool = true, truncate: Bool = true) throws
```

Write content of `string` encoded using UTF-8 encoding.

**Parameters**

|                   |          |                                                                                                             |
| ----------------- | -------- | ----------------------------------------------------------------------------------------------------------- |
| string            | `String` | The string to write.                                                                                        |
| createIfNecessary | `Bool  ` | `true` means when `self` is not a normal file,<br>attempt to create it, as opposed to throwing an<br>error. |
| truncate          | `Bool  ` | delete existing content of the file and write from the<br>start.                                            |

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
