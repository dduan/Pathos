import Pathos

let recursive = CommandLine.arguments.count > 2 && CommandLine.arguments[2] == "-r"

extension String {
    func withLeftPad(_ n: Int) -> String {
        String(repeating: " ", count: max(0, n - count)) + self
    }
}

do {
    for child in try Path(CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : ".").children(recursive: recursive) {
        let meta = try child.metadata()
        let permission = (meta.permissions.isReadOnly ? "ReadOnly" : "ReadWrite").withLeftPad("ReadWrite".count)
        let size = "\(meta.size)".withLeftPad(10)
        let modified = "\(meta.modified.seconds).\(meta.modified.nanoseconds)".withLeftPad(24)
        let fileType: String
        let fileTypeLength = "directory".count
        var name = "\(child)"
        if meta.fileType.isDirectory {
            fileType = "directory"
        } else if meta.fileType.isSymlink {
            fileType = "symlink".withLeftPad(fileTypeLength)
            name = "\(child) -> \(try child.readSymlink())"
        } else {
            fileType = "file".withLeftPad(fileTypeLength)
        }
        print("\(fileType) \(permission) \(size) \(modified) \(name)")
    }
} catch {
    print(error)
}
