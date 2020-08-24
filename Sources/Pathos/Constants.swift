#if os(Windows)
public typealias Constants = WindowsConstants
#else
public typealias Constants = POSIXConstants
#endif
