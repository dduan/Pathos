#if os(Windows)
public typealias PurePath = PureWindowsPath
#else
public typealias PurePath = PurePOSIXPath
#endif
