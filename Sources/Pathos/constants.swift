#if os(Linux)
import Glibc
#else
import Darwin
#endif

public let kCurrentDirectory = "."
let kParentDirectory = ".."
let kSeparatorCharacter: Character = "/"
let kSeparator = String(kSeparatorCharacter)

#if PATH_MAX
let kMaxPathNameLength = Int(PATH_MAX)
#else
let kMaxPathNameLength = 1024
#endif
