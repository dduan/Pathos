public typealias Bytes = ContiguousArray<CChar>

extension Bytes {
    init(cString: UnsafePointer<CChar>) {
        var length = 0
        while cString.advanced(by: length).pointee != 0 {
            length += 1
        }

        self = ContiguousArray(unsafeUninitializedCapacity: length) { buffer, count in
            for offset in 0..<length {
                buffer[offset] = cString.advanced(by: offset).pointee
            }

            count = length
        }
    }

    init(_ string: String) {
        self = ContiguousArray(string.utf8CString.dropLast())
    }
}
