import Pathos

let recursive = CommandLine.arguments.count > 2 && CommandLine.arguments[2] == "-r"

extension String {
    func withLeftPad(_ n: Int) -> String {
        String(repeating: " ", count: max(0, n - count)) + self
    }
}

do {
    for (child, type) in try Path(CommandLine.arguments[1]).children(recursive: recursive) {
        let meta = try child.metadata()
        let permission = (meta.permissions.isReadOnly ? "ReadOnly" : "ReadWrite").withLeftPad("ReadWrite".count)
        let size = "\(meta.size)".withLeftPad(10)
        let modified = "\(meta.modified.seconds).\(meta.modified.nanoseconds)".withLeftPad(24)
        let fileType: String
        let fileTypeLength = "directory".count
        if type.isDirectory {
            fileType = "directory"
        } else if type.isSymlink {
            fileType = "symlink".withLeftPad(fileTypeLength)
        } else {
            fileType = "file".withLeftPad(fileTypeLength)
        }
        print("\(fileType) \(permission) \(size) \(modified) \(child)")
    }
} catch {
    print(error)
}
