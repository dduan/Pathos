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

***

```swift
public init(_ stat: stat)
```

***

```swift
public init(_ data: WIN32_FIND_DATAW)
```

### Properties

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
