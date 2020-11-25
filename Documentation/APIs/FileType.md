# Pathos API Documentation for `FileType`

```swift
public protocol FileType
```

OS agnostic information regarding type of the file.

### Types Conforming to `FileType`

* [POSIXFileType][]
* [WindowsFileType][]

### Properties

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

[POSIXFileType]: POSIXFileType.md
[WindowsFileType]: WindowsFileType.md
