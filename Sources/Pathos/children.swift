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
///   - followSymlink: include content of a directroy, if it's pointed at by a symlink in the result.
///
/// - Returns: path to directories and files of all types in `path`, and their types, in pairs.
/// - Throws: A `SystemError` if path cannot be opened as a directory or there's not enough memory to hold all
///           data for the results.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.children(recursive:)`.
public func children(inPath path: String, recursive: Bool = false, followSymlink: Bool = false) throws
    -> [(String, FileType)]
{
    var result = [(String, FileType)]()
    guard let streamPtr = opendir(path) else {
        throw SystemError(posixErrorCode: errno)
    }

    defer {
        closedir(streamPtr)
    }

    while let entryPtr = readdir(streamPtr) {
        let entry = entryPtr.pointee
        guard let name = withUnsafeBytes(of: entry.d_name, {
            $0.bindMemory(to: Int8.self).baseAddress.map(String.init(cString:))
        }),
            name != ".." && name != "."
            else
        {
            continue
        }

        let pathType = FileType(posixFileType: Int32(entry.d_type))
        let fullName = join(paths: path, name)
        result.append((fullName, pathType))

        if pathType == .symlink,
           followSymlink,
           let realName = try? realPath(ofPath: fullName),
           (try? isA(.directory, atPath: realName)) == true
        {
            result += try children(inPath: fullName, recursive: true)
        } else if recursive && pathType == .directory {
            result += try children(inPath: fullName, recursive: true)
        }
    }

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
    /// - Parameters:
    ///   - recursive: set to `true` to include results from child directories in addition to that
    ///                in this path. Defaults to `false`.
    ///   - followSymlink: include content of a directroy, if it's pointed at by a symlink in the result.
    ///
    /// - Returns: paths to directories and files of all types in `path`, and their types, in pairs.
    /// - SeeAlso: `children(inPath:recursive:)`.
    public func children(recursive: Bool = false, followSymlink: Bool = false) -> [(Self, FileType)] {
        return ((try? children(inPath:recursive:followSymlink:)(self.pathString, recursive, followSymlink)) ?? [])
            .map { (.init($0), $1) }
    }

    /// Find paths to child directories or files of a type.
    ///
    /// Result will be empty if this path cannot be opened or there's not enough memory to hold all data for
    /// the results.
    ///
    /// - Parameters:
    ///   - type: The file type in question.
    ///   - recursive: set to `true` to include results from child directories in addition to that
    ///                in this path. Defaults to `false`.
    ///   - followSymlink: include content of a directroy, if it's pointed at by a symlink in the result.
    ///
    /// - Returns: paths to directories and files of all types in `path`, and their types, in pairs.
    /// - SeeAlso: `children(inPath:recursive:)`.
    public func children(ofType type: FileType, recursive: Bool = false, followSymlink: Bool = false)
        -> [Self]
    {
        return ((try? children(inPath:recursive:followSymlink:)(self.pathString, recursive, followSymlink)) ?? [])
            .filter { $1 == type }
            .map { .init($0.0) }
    }
}
