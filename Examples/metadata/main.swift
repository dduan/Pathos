import Pathos

do {
    let metadata = try Path(CommandLine.arguments[1]).metadata()
    print("is file      | \(metadata.fileType.isFile)")
    print("is directory | \(metadata.fileType.isDirectory)")
    print("is symlink   | \(metadata.fileType.isSymlink)")
    print("is read only | \(metadata.permissions.isReadOnly)")
    print("size         | \(metadata.size)")
    print("accessed     | \(metadata.accessed.seconds).\(metadata.accessed.nanoseconds)")
    print("modified     | \(metadata.modified.seconds).\(metadata.modified.nanoseconds)")
    print("created      | \(metadata.created.seconds).\(metadata.created.nanoseconds)")
} catch {
    print(error)
}
