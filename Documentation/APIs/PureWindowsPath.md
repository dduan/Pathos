# Pathos API Documentation for `PureWindowsPath`

```swift
public struct PureWindowsPath
```

### Conforms to

* [WindowsPathConvertible][]
* CustomStringConvertible
* Equatable
* ExpressibleByStringLiteral
* Hashable

### Initializers

```swift
public init(cString: UnsafePointer<CChar>)
```
Create a `PureWindowsPath` from an unsafe buffer of `CChar`.

***
```swift
public init(_ string: String)
```

Create a `PureWindowsPath` from a `String`.

### Properties

```swift
var drive: String?
```

The drive for the path. For POSIX, this is always empty.

***

```swift
var root: String?
```

Root component of the path. For example, on POSIX this is typically "/".

***

```swift
var segments: [String]
```

The segments in the path separated by `Constants.binaryPathSeparator`.
Root is not included.

Example: `Path(#"\usr\bin\env"#).segments` is `["usr", "bin", "env"]`.

***

```swift
var name: String?
```

The final path component, if any.

Example: `Path(#"src\Pathos\README.md"#).name` is `"README.md"`.

***

```swift
var extension: String?
```

Final suffix that begins with a `.` in the `name` the path. Leading `.`
in the name does not count.

Example: `Path(#"archive\Pathos.tar.gz"#).extension` is `"gz"`.

***

```swift
var extensions: [String]
```

Final suffix that begins with a `.` in the `name` the path. Leading `.`
in the name does not count.

Example: `Path(#"archive\Pathos.tar.gz"#).extension` is `["tar", "gz"]`.

***

```swift
var base: PureWindowsPath
```

Path value without the `extension`. 
`path.base + path.extension` should be equal to `path`.

***

```swift
var parent: PureWindowsPath
```

The logical parent of the path. The parent of an anchor is the anchor itself.
The parent of `.` is `.`. The parent of `\a\b\c` is `\a\b`.

***

```swift
var parents: AnySequence<PureWindowsPath>
```

A sequence composed of the `self.parent`, `self.parent.parent`, etc. The
final value is either the current context (`Path(".")`) or the root.

Example: `Array(Path(#"a\b\c"#)` is `[Path(#"a\b"#), Path("a"), Path(".")]`.

***

```swift
var isEmpty: Bool
```

The path does not have a drive nor a root, and its `segments` is empty.

***

```swift
var isAbsolute: Bool
```

Indicates whether this path is absolute.

An absolute path is one that has a root and, if applicable, a drive.

***

```swift
public var normal: Path
```

Normalize a path by removing redundant separators and up-level
references (`..`). This is a pure computation. It does not access the
file system. Therefore, it may change the meaning of a path that
contains symbolic links.

### Methods

```swift
public func joined(with paths: WindowsPathConvertible) -> Self
public func joined(with paths: [WindowsPathConvertible]) -> Self
```

Joining one or more [WindowsPathConvertible][]s after this one.

**Parameters**

|       |                          |                                      |
|-------|--------------------------|--------------------------------------|
| paths | `[WindowsPathConvertible]` | Other values that represents a path. |

**Returns**
|        |                          |
| ------ | ------------------------ |
| `Path` | Result of joining paths. |

***

```swift
public static func +(lhs: PureWindowsPath, rhs: PureWindowsPath) -> PureWindowsPath
public static func +(lhs: PureWindowsPath, rhs: WindowsPathConvertible) -> PureWindowsPath
public static func +(lhs: WindowsPathConvertible, rhs: PureWindowsPath) -> PureWindowsPath
```

`+` operators that enable path creation with code like `#"\"# + myPath + "file.md"`.

_¹ an important reason these need to be addressed separately is we want to avoid overloading `+`
when value on both sides are `String`s._

***

```swift
public func relative(to other: WindowsPathConvertible) -> PureWindowsPath
```

Return a relative path to `self` from `other`. This is a pure computatian.
File system is not accessed to confirm the existence or nature of `self`
or `other`.

For example, `Path(#"a\b\c"#).relative(to: Path(#"a\b"#))` evaluates to
`Path("c")`. That is to say, to get to "a/b/c" from "a/b", one go through
"c".

**Parameters**

|       |                          |                         |
| ----- | ------------------------ | ----------------------- |
| other | `WindowsPathConvertible` | the path to start from. |

**Returns**
|        |                                             |
| ------ | ------------------------------------------- |
| `Path` | the path that leads from `other` to `self`. |

[WindowsPathConvertible]: WindowsPathConvertible.md
