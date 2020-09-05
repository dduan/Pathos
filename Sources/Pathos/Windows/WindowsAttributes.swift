#if os(Windows)

import WinSDK

public struct WindowsAttributes: OptionSet {
    public var rawValue: DWORD

    public init(rawValue: DWORD) {
        self.rawValue = rawValue
    }

    public var isReadOnly: Bool {
        rawValue & UInt32(bitPattern: FILE_ATTRIBUTE_READONLY) != 0
    }
}

extension WindowsAttributes: Permissions {}
#endif // os(Windows)
