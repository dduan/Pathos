import Pathos

var args = Set(CommandLine.arguments.dropFirst())
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
