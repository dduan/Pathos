public typealias WindowsEncodingUnit = UInt16
public typealias WindowsBinaryString = ContiguousArray<UInt16>
public typealias POSIXEncodingUnit = CChar
public typealias POSIXBinaryString = ContiguousArray<CChar>

#if os(Windows)
public typealias BinaryString = WindowsBinaryString
public typealias NativeEncodingUnit = WindowsEncodingUnit
#else
public typealias BinaryString = POSIXBinaryString
public typealias NativeEncodingUnit = POSIXEncodingUnit
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

    public var string: String {
        String(cString: Array(self) + [0])
    }
}

extension WindowsBinaryString {
    public init(_ string: String) {
        self = ContiguousArray(string.utf16)
    }

    public var string: String {
        String(decodingCString: Array(self) + [0], as: UTF16.self)
    }
}
