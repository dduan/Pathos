# Pathos API Documentation for `SystemError`

```swift
public enum SystemError
```

An error returned by the OS.


### Conforms to

* Equatable
* Error

### Nested type aliases

```swift
public typealias Code
```

On macOS and Linux, it is aliased to `Int32`. On Windows, it is `UInt32`.

### Initializers

```swift
public init(code: Code)
```

### Enumeration cases

```swift
case unspecified(errorCode: Code)
```

Unspecified error returned by the OS.
