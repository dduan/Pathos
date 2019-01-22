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
public func searchForDefaultTemporaryDirectory() -> String {
    for path in candidateTemporaryDirectories() where path != kCurrentDirectory {
        do {
            let p = try permissions(forPath: path)
            if p.contains([.ownerRead, .ownerWrite]) {
                return path
            }
        } catch {
        }
    }

    return (try? makeAbsolute(path: kCurrentDirectory)) ?? kCurrentDirectory
}

private var _defaultTemporaryDirectory: String? = nil

/// The name of the directory used for temporary files. This defines the default value for the `directory`
/// argument to all functions involving a temporary path.
///
/// Pathos calls `searchForDefaultTemporaryDirectory` to calculate this value. The result of this search is
/// cached. You can use the same method to reset this value if needed.
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

func _makeTemporaryPath(suffix: String = "", prefix: String = "", inDirectory directory: String? = nil) throws -> String
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
public func makeTemporaryFile(suffix: String = "", prefix: String = "", inDirectory directory: String? = nil) throws -> String {
    let fileLocation = try _makeTemporaryPath()
    try writeString(atPath: fileLocation, "")
    return fileLocation
}

// TODO: Missing docstring.
public func makeTemporaryDirectory(suffix: String? = nil, prefix: String? = nil, inDirectory directory: String? = nil) throws -> String {
    let fileLocation = try _makeTemporaryPath(suffix: suffix ?? "", prefix: prefix ?? "", inDirectory: directory)
    try makeDirectory(atPath: fileLocation)
    return fileLocation
}

public func withTemporaryDirectory(suffix: String = "", prefix: String = "", inDirectory directory: String? = nil, performAction closure: @escaping (String) throws -> Void) throws {
    let temporaryDirectory = try makeTemporaryDirectory(suffix: suffix, prefix: prefix, inDirectory: directory)
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
    public static var defaultTemporaryDirectory: String {
        get {
            return Pathos.defaultTemporaryDirectory
        }

        set {
            Pathos.defaultTemporaryDirectory = newValue
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
    public static func searchForDefaultTemporaryDirectory() -> String {
        return Pathos.searchForDefaultTemporaryDirectory()
    }

    // TODO: Missing docstring.
    public static func makeTemporaryFile(suffix: String = "", prefix: String = "", inDirectory directory: String? = nil) -> Self? {
        do {
            return Self(string: try Pathos.makeTemporaryFile(suffix:prefix:inDirectory:)(suffix, prefix, directory))
        } catch {
            return nil
        }
    }

    // TODO: Missing docstring.
    public static func makeTemporaryDirectory(suffix: String = "", prefix: String = "", inDirectory directory: Self? = nil) -> Self? {
        do {
            return Self(string: try Pathos.makeTemporaryDirectory(suffix:prefix:inDirectory:)(suffix, prefix, directory?.pathString))
        } catch {
            return nil
        }
    }

    public static func withTemporaryDirectory(suffix: String = "", prefix: String = "", inDirectory directory: Self? = nil, performAction closure: @escaping (Self) throws -> Void) {
        guard let temporaryDirectory = self.makeTemporaryDirectory(suffix: suffix, prefix: prefix, inDirectory: directory) else
        {
            return
        }

        let originalDirectory = self.currentWorkingDirectory
        self.currentWorkingDirectory = temporaryDirectory
        try? closure(temporaryDirectory)
        self.currentWorkingDirectory = originalDirectory
        _ = temporaryDirectory.delete(recursive: true)
    }
}
