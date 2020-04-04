#if os(Linux)
import Glibc
#else
import Darwin
#endif

private func candidateTemporaryDirectories() -> [String] {
    var list = [String]()
    for envName in ["TMPDIR", "TEMP", "TMP"] {
        if let cString = getenv(envName), let variable = String(validatingUTF8: cString) {
            list.append(variable)
        }
    }

    list.append(contentsOf: ["/tmp", "/var/tmp", "/usr/tmp"])
    do {
        list.append(try getCurrentWorkingDirectory())
    } catch {
    }

    return list
}

/// Searches a standard list of directories to find one which the calling user can create files in.
/// The list is:
///
/// * The directory named by the TMPDIR environment variable.
/// * The directory named by the TEMP environment variable.
/// * The directory named by the TMP environment variable.
/// * The directories `/tmp`, `/var/tmp`, and `/usr/tmp`, in that order.
/// * As a last resort, the current working directory.
///
/// - Returns: result of the search.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.searchForDefaultTemporaryDirectory()`
public func searchForDefaultTemporaryDirectory() -> String {
    for path in candidateTemporaryDirectories() where path != kCurrentDirectory {
        do {
            let p = try metadata(atPath: path).permissions
            if p.contains([.ownerRead, .ownerWrite]) {
                return path
            }
        } catch {
        }
    }

    return (try? absolutePath(ofPath: kCurrentDirectory)) ?? kCurrentDirectory
}

private var _defaultTemporaryDirectory: String? = nil

/// The name of the directory used for temporary files. This defines the default value for the `directory`
/// argument to all functions involving a temporary path.
///
/// Pathos calls `searchForDefaultTemporaryDirectory` to calculate this value. The result of this search is
/// cached. You can use the same method to reset this value if needed.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.defaultTemporaryDirectory`
public var defaultTemporaryDirectory: String {
    get {
        if let directory = _defaultTemporaryDirectory {
            return directory
        } else {
            let directory = searchForDefaultTemporaryDirectory()
            _defaultTemporaryDirectory = directory
            return directory
        }
    }

    set {
        _defaultTemporaryDirectory = newValue
    }
}

private func _makeTemporaryPath(suffix: String = "", prefix: String = "", inDirectory directory: String? = nil) throws -> String
{
    let location = directory ?? defaultTemporaryDirectory
    func makePath() -> String {
        return join(paths: location, prefix + String(Int64.random(in: .min ... .max)) + suffix)
    }

    var fileLocation = makePath()
    for _ in 0 ..< 63 {
        if exists(atPath: fileLocation) {
            fileLocation = makePath()
        } else {
            break
        }
    }

    return fileLocation
}
// TODO: Missing docstring.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.createTemporaryDirectory(suffix:prefix:inDirectory:)`.
public func createTemporaryFile(suffix: String = "", prefix: String = "", inDirectory directory: String? = nil) throws -> String {
    let fileLocation = try _makeTemporaryPath(suffix: suffix, prefix: prefix, inDirectory: directory)
    try write("", atPath: fileLocation)
    return fileLocation
}

// TODO: Missing docstring.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.createTemporaryFile(suffix:prefix:inDirectory:)`.
public func createTemporaryDirectory(suffix: String? = nil, prefix: String? = nil, inDirectory directory: String? = nil) throws -> String {
    let fileLocation = try _makeTemporaryPath(suffix: suffix ?? "", prefix: prefix ?? "", inDirectory: directory)
    try createDirectory(atPath: fileLocation)
    return fileLocation
}

// TODO: Missing docstring.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.withTemporaryDirectory(suffix:prefix:inDirectory:performAction:)`.
public func withTemporaryDirectory(suffix: String = "", prefix: String = "", inDirectory directory: String? = nil, performAction closure: @escaping (String) throws -> Void) throws {
    let temporaryDirectory = try createTemporaryDirectory(suffix: suffix, prefix: prefix, inDirectory: directory)
    try withWorkingDirectory(beingPath: temporaryDirectory) {
        try closure(temporaryDirectory)
    }

    try deletePath(temporaryDirectory, recursive: true)
}

extension PathRepresentable {
    /// The name of the directory used for temporary files. This defines the default value for the `directory`
    /// argument to all functions involving a temporary path.
    ///
    /// Pathos calls `searchForDefaultTemporaryDirectory` to calculate this value. The result of this search is
    /// cached. You can use the same method to reset this value if needed.
    /// - SeeAlso: `Pathos.defaultTemporaryDirectory`.
    public static var defaultTemporaryDirectory: Self {
        get {
            return Self(Pathos.defaultTemporaryDirectory)
        }

        set {
            Pathos.defaultTemporaryDirectory = newValue.pathString
        }
    }

    /// Searches a standard list of directories to find one which the calling user can create files in.
    /// The list is:
    ///
    /// - The directory named by the TMPDIR environment variable.
    /// - The directory named by the TEMP environment variable.
    /// - The directory named by the TMP environment variable.
    /// - The directories `/tmp`, `/var/tmp`, and `/usr/tmp`, in that order.
    /// - As a last resort, the current working directory.
    ///
    /// - Returns: result of the search.
    /// - SeeAlso: `searchForDefaultTemporaryDirectory()`.
    public static func searchForDefaultTemporaryDirectory() -> String {
        return Pathos.searchForDefaultTemporaryDirectory()
    }

    // TODO: Missing docstring.
    /// - SeeAlso: `createTemporaryFile(suffix:prefix:inDirectory:)`.
    public static func createTemporaryFile(suffix: String = "", prefix: String = "", inDirectory directory: String? = nil) -> Self? {
        do {
            return Self(try Pathos.createTemporaryFile(suffix:prefix:inDirectory:)(suffix, prefix, directory))
        } catch {
            return nil
        }
    }

    // TODO: Missing docstring.
    /// - SeeAlso: `createTemporaryDirectory(suffix:prefix:inDirectory:)`.
    public static func createTemporaryDirectory(suffix: String = "", prefix: String = "", inDirectory directory: Self? = nil) -> Self? {
        do {
            return Self(try Pathos.createTemporaryDirectory(suffix:prefix:inDirectory:)(suffix, prefix, directory?.pathString))
        } catch {
            return nil
        }
    }

    // TODO: Missing docstring.
    /// - SeeAlso: `withTemporaryDirectory(suffix:prefix:inDirectory:performAction:)`.
    @discardableResult
    public static func withTemporaryDirectory(suffix: String = "", prefix: String = "", inDirectory directory: Self? = nil, performAction closure: @escaping (Self) throws -> Void) -> Bool {
        guard let temporaryDirectory = self.createTemporaryDirectory(suffix: suffix, prefix: prefix, inDirectory: directory) else {
            return false
        }

        let originalDirectory = self.currentWorkingDirectory
        self.currentWorkingDirectory = temporaryDirectory
        try? closure(temporaryDirectory)
        self.currentWorkingDirectory = originalDirectory
        _ = temporaryDirectory.delete(recursive: true)
        return true
    }
}
