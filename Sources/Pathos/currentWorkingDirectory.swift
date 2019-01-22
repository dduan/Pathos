#if os(Linux)
import Glibc
#else
import Darwin
#endif

/// Get current working directory.
///
/// - Returns: Path for current working directory.
/// - Throws: System error that could trigger when a component of the current path no longer exists or the
///           process lacks permission to read it.
public func getCurrentWorkingDirectory() throws -> String {
    if let buffer = getcwd(nil, 0) {
        return String(cString: buffer)
    }
    throw SystemError(posixErrorCode: errno)
}

/// Set current working directory.
///
/// - Returns: Path for current working directory.
/// - Throws: System error that could trigger when, for example, search permission is denied for any component
///           of the path name; There's a symbolic link loop among some components; A component is not an
///           directory, etc.
public func setCurrentWorkingDirectory(toPath path: String) throws {
    if chdir(path) != 0 {
        throw SystemError(posixErrorCode: errno)
    }
}

extension PathRepresentable {
    /// The current working directory.
    ///
    /// If an error occures while getting the directory (see `getCurrentWorkingDirectory()`),
    /// `Path(string: ".")` will be returned instead.
    /// If an error occures while setting the directory (see `setCurrentWorkingDirectory(toPath:)`), the
    /// working directory will be unchanged.
    public static var currentWorkingDirectory: Self {
        get {
            return Self(string: (try? getCurrentWorkingDirectory()) ?? ".")
        }

        set {
            try? setCurrentWorkingDirectory(toPath:)(newValue.pathString)
        }
    }
}

