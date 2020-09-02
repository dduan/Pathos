#if os(Windows)
struct WindowsAttributes {
    let isReadOnly: Bool
}

extension WindowsAttributes: Permissions {}
#endif // os(Windows)
