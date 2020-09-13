#if canImport(Darwin)
import Darwin
#elseif canImport(WinSDK)
import WinSDK
#else
import Glibc
#endif

import Pathos

var args = Array(CommandLine.arguments.dropFirst())

func help() {
    print(
        """
        Make stuff in the file system.

        SUBCOMMANDS:
          dir       makes a directory
          link      makes a symlink from a path to a path
        """)
    exit(0)
}

func mklink(_ args: [String]) {
    do {
        try Path(args[0]).makeSymlink(at: Path(args[1]))
    } catch {
        print(error)
    }
}

func mkdir(_ args: [String]) {
    var args = Set(args)
    let makeParents: Bool
    if args.contains("-p") {
        makeParents = true
        args.remove("-p")
    } else {
        makeParents = false
    }

    do {
        try Path(args.first!).makeDirectory(withParents: makeParents)
    } catch {
        print(error)
    }
}

if args.isEmpty {
    help()
}

switch args.first {
case .some("dir") where args.count > 1:
    mkdir(Array(args.dropFirst()))
case .some("link") where args.count > 2:
    mklink(Array(args.dropFirst()))
default:
    help()
}
