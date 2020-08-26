public protocol WindowsPathConvertible {
    var asWindowsPath: PureWindowsPath { get }
}

extension PureWindowsPath: WindowsPathConvertible {
    public var asWindowsPath: PureWindowsPath { self }
}

extension String: WindowsPathConvertible {
    public var asWindowsPath: PureWindowsPath { PureWindowsPath(self) }
}

#if os(Windows)
extension Path: WindowsPathConvertible {
    public var asWindowsPath: PureWindowsPath { pure }
}

public typealias PathConvertible = WindowsPathConvertible
#endif
