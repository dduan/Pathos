import Pathos

extension String {
    var asBool: Bool {
        !["f", "no", "false", "0"].contains(lowercased())
    }
}

let readOnly = CommandLine.arguments[1].asBool
let pathString = CommandLine.arguments[2]

let path = Path(pathString)
var meta = try path.metadata()
var perms = meta.permissions

print("\(path) was read-only: \(perms.isReadOnly)")

perms.isReadOnly = readOnly

try path.set(perms)

meta = try path.metadata()

print("\(path) is now read-only: \(meta.permissions.isReadOnly)")
