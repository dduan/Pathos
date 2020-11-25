# Pathos API Documentation for `POSIXFileType`

```swift
public enum POSIXFileType
```

### Conforms to

* [FileType][]
* Codable
* Equatable

### Initializers

```swift
public init(rawFileType: Int32)
```

Creates a `POSIXFileType` from a POSIX file type such as `DT_REG`.

***

```swift
public init(rawMode: mode_t)
```

Creates a `POSIXFileType` from a POSIX inode protection mode (`stat.st_mode`) such as `S_IFREG`.

### Enumuration cases

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

[FileType]: FileType.md
