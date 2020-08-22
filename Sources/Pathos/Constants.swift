extension Constants {
    static let currentDirectoryByte: CChar = ".".utf8CString[0]
}

#if os(Windows)
public typealias Constants = WindowsConstants
#else
public typealias Constants = POSIXConstants
#endif
