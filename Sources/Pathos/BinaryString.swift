typealias WindowsEncodingUnit = UInt16
typealias WindowsBinaryString = ContiguousArray<UInt16>
typealias POSIXEncodingUnit = CChar
typealias POSIXBinaryString = ContiguousArray<CChar>

#if os(Windows)
typealias BinaryString = WindowsBinaryString
public typealias NativeEncodingUnit = UInt16
#else
typealias BinaryString = POSIXBinaryString
public typealias NativeEncodingUnit = CChar
#endif

extension ContiguousArray where Element: BinaryInteger {
    init(cString: UnsafePointer<Element>) {
        var length = 0
        while cString.advanced(by: length).pointee != 0 {
            length += 1
        }

        self = ContiguousArray(unsafeUninitializedCapacity: length) { buffer, count in
            for offset in 0 ..< length {
                buffer[offset] = cString.advanced(by: offset).pointee
            }

            count = length
        }
    }
}

extension POSIXBinaryString {
    public init(_ string: String) {
        self = ContiguousArray(string.utf8CString.dropLast())
    }

    public func cString<T>(action: (UnsafePointer<CChar>) throws -> T) throws -> T {
        try (self + [0]).withUnsafeBufferPointer {
            try action($0.baseAddress!)
        }
    }

    public var description: String {
        String(cString: Array(self) + [0])
    }
}

extension WindowsBinaryString {
    public init(_ string: String) {
        self = ContiguousArray(string.utf16)
    }

    public func cString<T>(action: (UnsafePointer<UInt16>) throws -> T) throws -> T {
        try (self + [0]).withUnsafeBufferPointer {
            try action($0.baseAddress!)
        }
    }

    public var description: String {
        String(decoding: self, as: UTF16.self)
    }
}
