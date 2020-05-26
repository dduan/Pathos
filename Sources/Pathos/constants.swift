#if os(Linux)
import Glibc
#elseif os(macOS)
import Darwin
#elseif os(Windows)
import WinSDK
#endif

let kCurrentDirectory = "."
let kParentDirectory = ".."
#if os(Windows)
public let pathSeparatorCharacter: Character = "\\"
#else
public let pathSeparatorCharacter: Character = "/"
let kDefaultPermission: FilePermission = [.ownerRead, .ownerWrite, .groupRead, .otherRead]
#endif
public let pathSeparator = String(pathSeparatorCharacter)
#if PATH_MAX
let kMaxPathNameLength = Int(PATH_MAX)
#elseif os(Windows)
let kMaxPathNameLength = Int(MAX_PATH)
#else
let kMaxPathNameLength = 1024
#endif
