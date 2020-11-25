# Pathos API Documentation for `PathConvertible`

```swift
public typealias PathConvertible
```

Types that conform to this protocol can be joined with [Path][] and [PurePath][].

On macOS and Linux, this is aliased to [POSIXPathConvertible][]. On Windows, it is
[WindowsPathConvertible][].

[POSIXPathConvertible]: POSIXPathConvertible.md
[WindowsPathConvertible]: WindowsPathConvertible.md
[PurePath]: PurePath.md
[Path]: Path.md
