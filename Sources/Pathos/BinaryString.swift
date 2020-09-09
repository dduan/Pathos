typealias WindowsEncodingUnit = UInt16
typealias WindowsBinaryString = CString<UInt16>
typealias POSIXEncodingUnit = CChar
typealias POSIXBinaryString = CString<CChar>

#if os(Windows)
typealias BinaryString = WindowsBinaryString
public typealias NativeEncodingUnit = UInt16
#else
typealias BinaryString = POSIXBinaryString
public typealias NativeEncodingUnit = CChar
#endif

struct CString<Unit: BinaryInteger>: Equatable, Hashable {
    var storage: ContiguousArray<Unit>
    var content: ContiguousArray<Unit>.SubSequence {
        storage[0 ..< storage.count - 1]
    }

    public func c<T>(action: (UnsafePointer<Unit>) throws -> T) throws -> T {
        try content.withUnsafeBufferPointer {
            try action($0.baseAddress!)
        }
    }

    init(cString: UnsafePointer<Unit>) {
        var length = 0
        while cString.advanced(by: length).pointee != 0 {
            length += 1
        }

        storage = ContiguousArray(unsafeUninitializedCapacity: length + 1) { buffer, count in
            for offset in 0 ..< length {
                buffer[offset] = cString.advanced(by: offset).pointee
            }

            buffer[length] = 0
            count = length + 1
        }
    }

    init(nulTerminatedStorage: ContiguousArray<Unit>) {
        storage = nulTerminatedStorage
    }
}

extension CString where Unit == WindowsEncodingUnit {
    init(_ string: String) {
        storage = ContiguousArray(string.utf16) + [0]
    }

    var description: String {
        String(decoding: content, as: UTF16.self)
    }
}

extension CString where Unit == POSIXEncodingUnit {
    init(_ string: String) {
        storage = ContiguousArray(string.utf8CString)
    }

    var description: String {
        (try? c { String(cString: $0) }) ?? "<UTF8 Decoding Error>"
    }
}
