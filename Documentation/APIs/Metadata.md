# Pathos API Documentation for `Metadata`

```swift
public struct Metadata
```

OS agnostic information about a file, besides the file itself.

### Initializers

```swift
public init(
    mode: UInt16,
    size: UInt64, 
    atime: timespec, 
    mtime: timespec,
    btime: timespec
)
```

Creates a `Metadata` from each individual values. This is only available on Linux.

***

```swift
public init(_ stat: stat)
```

Creates a `Metadata` from `stat`. This is only available on Darwin.

***

```swift
public init(_ data: WIN32_FIND_DATAW)
```

Creates a `Metadata` from `WIN32_FIND_DATAW`. This is only available on Windows.

### Properties

```swift
let fileType: FileType
```

What does a path leads to.

***

```swift
let permissions: Permissions
```

What permission does current process has regarding the file.

***

```swift
let size: Int64
```
Length of the file's content in bytes.

***

```swift
let accessed: FileTime
```

Last time the file was accessed.

***

```swift
let modified: FileTime
```
Last time the file was modified.

***

```swift
let created: FileTime
```

Time of creation for the file.
