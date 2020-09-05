#if os(Windows)

import WinSDK

public struct WindowsAttributes: OptionSet {
    var rawValue: DWORD

    public var isReadOnly: Bool {
        rawValue & UInt32(bitPattern: FILE_ATTRIBUTE_READONLY) != 0
    }
}

extension WindowsAttributes: Permissions {}
#endif // os(Windows)
