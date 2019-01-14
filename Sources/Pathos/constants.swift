#if os(Linux)
import Glibc
#else
import Darwin
#endif

let kCurrentDirectory = "."
let kParentDirectory = ".."
let kSeparatorCharacter: Character = "/"
let kSeparator = String(kSeparatorCharacter)
let kDefaultPermission: FilePermission = [.ownerRead, .ownerWrite, .groupRead, .otherRead]
#if PATH_MAX
let kMaxPathNameLength = Int(PATH_MAX)
#else
let kMaxPathNameLength = 1024
#endif
