# Pathos API Documentation for `PurePOSIXPath`

```swift
public struct PurePOSIXPath
```

### Conforms to

* [POSIXPathConvertible][]
* CustomStringConvertible
* Equatable
* ExpressibleByStringLiteral
* Hashable

### Initializers

```swift
public init(cString: UnsafePointer<CChar>)
```
Create a `PurePOSIXPath` from an unsafe buffer of `CChar`.

***
```swift
public init(_ string: String)
```

Create a `PurePOSIXPath` from a `String`.

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
var base: PurePOSIXPath
```

***

```swift
var parent: PurePOSIXPath
```

***

```swift
var parents: AnySequence<PurePOSIXPath>
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
public func joined(with paths: POSIXPathConvertible) -> Self
public func joined(with paths: [POSIXPathConvertible]) -> Self
```

```swift
public static func +(lhs: PurePOSIXPath, rhs: PurePOSIXPath) -> PurePOSIXPath
public static func +(lhs: PurePOSIXPath, rhs: POSIXPathConvertible) -> PurePOSIXPath
public static func +(lhs: POSIXPathConvertible, rhs: PurePOSIXPath) -> PurePOSIXPath
```

***

```swift
public func relative(to other: POSIXPathConvertible) -> PurePOSIXPath
```

[POSIXPathConvertible]: POSIXPathConvertible.md
