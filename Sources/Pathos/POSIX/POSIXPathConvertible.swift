public protocol POSIXPathConvertible {
    var asPOSIXPath: PurePOSIXPath { get }
}

extension PurePOSIXPath: POSIXPathConvertible {
    public var asPOSIXPath: PurePOSIXPath { self }
}

extension String: POSIXPathConvertible {
    public var asPOSIXPath: PurePOSIXPath { PurePOSIXPath(self) }
}

#if !os(Windows)
extension Path: POSIXPathConvertible {
    public var asPOSIXPath: PurePOSIXPath { pure }
}

public typealias PathConvertible = POSIXPathConvertible
#endif
