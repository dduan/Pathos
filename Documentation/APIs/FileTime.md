# Pathos API Documentation for `FileTime`

```swift
public struct FileTime
```

A time interval broken down into seconds and nanoseconds. This is used to represent a point in time
since 1970-01-01 00:00:00 UTC

### Initializers

```swift
public init(_ time: timespec)
```

```swift
public init(_ time: FILETIME)
```

### Properties

```swift
var seconds: Int
```

Number of seconds since 1970-01-01 00:00:00 UTC.

***

```swift
var nanoseconds: Int
```

Number of nanoseconds since `seconds`.
