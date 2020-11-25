# Pathos API Documentation for `Permissions`

```swift
public protocol Permissions
```

OS agnostic permissions for a file path.

### Types Conforming to Permissions

* [POSIXPermissions][]
* [WindowsAttributes][]

### Properties

```swift
var isReadOnly: Bool
```

Whether the file is read only. NOTE: setting this value does not change the permission of the path
on file system. Use Path.set(_:) with the updated value to achieve that.

[POSIXPermissions]: POSIXPermissions.md
[WindowsAttributes]: WindowsAttributes.md
