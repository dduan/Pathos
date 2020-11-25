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
var base: PureWindowsPath
```

***

```swift
var parent: PureWindowsPath
```

***

```swift
var parents: AnySequence<PureWindowsPath>
```

***

```swift
var isEmpty: Bool
```

***

```swift
var isAbsolute: Bool
```
***

```swift
public var normal: Path
```

### Methods

```swift
public func joined(with paths: WindowsPathConvertible) -> Self
public func joined(with paths: [WindowsPathConvertible]) -> Self
```

```swift
public static func +(lhs: PureWindowsPath, rhs: PureWindowsPath) -> PureWindowsPath
public static func +(lhs: PureWindowsPath, rhs: WindowsPathConvertible) -> PureWindowsPath
public static func +(lhs: WindowsPathConvertible, rhs: PureWindowsPath) -> PureWindowsPath
```

***

```swift
public func relative(to other: WindowsPathConvertible) -> PureWindowsPath
```

[WindowsPathConvertible]: WindowsPathConvertible.md
