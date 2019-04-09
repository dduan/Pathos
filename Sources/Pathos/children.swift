#if os(Linux)
import Glibc
#else
import Darwin
#endif

/// Find paths to directories and files of all types in `path`.
///
/// - Parameters:
///   - path: the path whose children will be returned.
///   - recursive: set to `true` to include results from child directories in addition to that from `path`.
///                Defaults to `false`.
///
/// - Returns: path to directories and files of all types in `path`, and their types, in pairs.
/// - Throws: A `SystemError` if path cannot be opened as a directory or there's not enough memory to hold all
///           data for the results.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.children(recursive:)`.
public func children(inPath path: String, recursive: Bool = false) throws -> [(String, FileType)] {
    var result = [(String, FileType)]()
    let bufferPointer = UnsafeMutablePointer<UnsafeMutablePointer<UnsafeMutablePointer<dirent>?>?>.allocate(capacity: 0)
    #if os(Linux)
    let sorting: @convention(c) (UnsafeMutablePointer<UnsafePointer<dirent>?>?, UnsafeMutablePointer<UnsafePointer<dirent>?>?) -> Int32 = { p0, p1 in
        return alphasort(p0!, p1!)
    }

    let count = Int(scandir(path, bufferPointer, nil, sorting))
    #else
    let count = Int(scandir(path, bufferPointer, nil, alphasort))
    #endif
    if count == -1 {
        throw SystemError(posixErrorCode: errno)
    }

    result.reserveCapacity(count)
    let buffer = UnsafeBufferPointer(start: bufferPointer.pointee, count: Int(count))
    for d in buffer {
        #if os(Linux)
        guard var entry = d?.pointee,
            case let nameLength = Int(entry.d_reclen + 1),
            let nameBuffer = UnsafeBufferPointer(start: &entry.d_name.0, count: nameLength).baseAddress,
            case let name = String(cString: nameBuffer),
            name != ".." && name != "."
            else
        {
            continue
        }
        #else
        guard var entry = d?.pointee,
            case let nameLength = Int(entry.d_namlen + 1),
            let nameBuffer = UnsafeBufferPointer(start: &entry.d_name.0, count: nameLength).baseAddress,
            case let name = String(cString: nameBuffer),
            name != ".." && name != "."
            else
        {
            continue
        }
        #endif

        let pathType = FileType(posixFileType: Int32(entry.d_type))
        let fullName = join(paths: path, name)
        result.append((fullName, pathType))

        if recursive && pathType == .directory {
            result += try children(inPath: fullName, recursive: true)
        }
    }

    free(bufferPointer)
    return result
}

/// Find paths to directories or files of a type in `path`.
///
/// - Parameters:
///   - path: the path whose children will be returned.
///   - type: the type of file to find. See `FileType`.
///   - recursive: set to `true` to include results from child directories in addition to that from `path`.
///                Defaults to `false`.
///
/// - Returns: path to files of the given type in `path`.
/// - Throws: A `SystemError` if path cannot be opened as a directory or there's not enough memory to hold all
///           data for the results.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.children(ofType:recursive:)`.
public func children(inPath path: String, ofType type: FileType, recursive: Bool = false) throws -> [String] {
    return try children(inPath: path, recursive: recursive)
        .filter { $1 == type }
        .map { $0.0 }
}

extension PathRepresentable {
    /// Find paths to child directories and files of all types.
    ///
    /// Result will be empty if this path cannot be opened or there's not enough memory to hold all data for
    /// the results.
    ///
    /// - Parameter recursive: set to `true` to include results from child directories in addition to that
    ///                        in this path. Defaults to `false`.
    ///
    /// - Returns: paths to directories and files of all types in `path`, and their types, in pairs.
    /// - SeeAlso: `children(inPath:recursive:)`.
    public func children(recursive: Bool = false) -> [(Self, FileType)] {
        return ((try? children(inPath:recursive:)(self.pathString, recursive)) ?? [])
            .map { (.init($0), $1) }
    }

    /// Find paths to child directories or files of a type.
    ///
    /// Result will be empty if this path cannot be opened or there's not enough memory to hold all data for
    /// the results.
    ///
    /// - Parameters
    ///   - type: The file type in question.
    ///   - recursive: set to `true` to include results from child directories in addition to that
    ///                in this path. Defaults to `false`.
    ///
    /// - Returns: paths to directories and files of all types in `path`, and their types, in pairs.
    /// - SeeAlso: `children(inPath:recursive:)`.
    public func children(ofType type: FileType, recursive: Bool = false) -> [Self] {
        return ((try? children(inPath:recursive:)(self.pathString, recursive)) ?? [])
            .filter { $1 == type }
            .map { .init($0.0) }
    }
}
