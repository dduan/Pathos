#if os(Linux)
import Glibc
#elseif os(macOS)
import Darwin
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
let kMaxPathNameLength = 256
#else
let kMaxPathNameLength = 1024
#endif
