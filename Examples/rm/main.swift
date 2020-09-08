import Pathos

var args = Set(CommandLine.arguments.dropFirst())
let recursive: Bool
if args.contains("-r") {
    recursive = true
    args.remove("-r")
} else {
    recursive = false
}

if args.isEmpty {
    print("Tell me what you want to delete")
}

do {
    try Path(args.first!).delete(recursive: recursive)
} catch {
    print(error)
}
