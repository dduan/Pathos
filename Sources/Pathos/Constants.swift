#if os(Windows)
public typealias Constants = WindowsConstants
#else
public typealias Constants = POSIXConstants
#endif

#if os(Windows)
import WinSDK
extension Constants {
    static let maxPathLength = Int(MAX_PATH)
}
#else
#if canImport(Darwin)
import Darwin
#else
import Glibc
#endif // canImport(Darwin)
extension Constants {
    static let maxPathLength = Int(PATH_MAX)
}
#endif // os(Windows)
