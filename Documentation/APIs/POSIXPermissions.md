# Pathos API Documentation for `POSIXPermissions`

```swift
public struct POSIXPermissions
```

Represents the POSIX file permission bits. These bits determines read/write/execution access to
a file as well as some miscellaneous information.

### Conforms to

* [Permissions][]
* ExpressibleByIntegerLiteral
* OptionSet

### Initializer

```swift
public init(rawValue: mode_t)
```

Creates a `FilePermission` from native `mode_t`.

### Properties

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

[Permissions]: Permissions.md
[Process Persona]: https://www.gnu.org/software/libc/manual/html_node/Process-Persona.html
