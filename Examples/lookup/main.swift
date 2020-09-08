/// A file with a certain name may exist at any ancestor of the give path. For example, for the path
/// `./Sources/Target/Nested/Awesome.swift`, a `.swiftlint.yml` may exist in `./Sources/Target`, or
/// `./`. This utility finds the matching file closest to the input.

#if canImport(Darwin)
import Darwin
#elseif canImport(WinSDK)
import WinSDK
#else
import Glibc
#endif

import Pathos

let fileToFind = CommandLine.arguments[1]

let path = Path(CommandLine.arguments[2])

for parent in path.parents {
    let target = parent.joined(with: fileToFind)
    if target.exists() {
        print(target)
        exit(0)
    }
}

exit(1)
