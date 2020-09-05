#if os(Windows)

import WinSDK

public struct WindowsAttributes {
    var rawAttributes: DWORD

    public var isReadOnly: Bool {
        rawAttributes & UInt32(bitPattern: FILE_ATTRIBUTE_READONLY) != 0
    }
}

extension WindowsAttributes: Permissions {}
#endif // os(Windows)
