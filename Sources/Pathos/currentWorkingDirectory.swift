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

/// Execute a closure with the current working direcotry being the specified path. Restore the current working
/// directory when the execution is finished.
///
/// The closure is guaranteed to be invoked synchronously.
///
/// - Parameters:
///   - path: The path that would be the current working directory.
///   - closure: The closure that will be called with `path` being the working directory.
/// - Throws: Errors encountered setting or reading working directories.
public func withWorkingDirectory(beingPath path: String, performAction closure: @escaping () throws -> Void) throws {
    let originalDirectory = try getCurrentWorkingDirectory()
    defer {
        try? setCurrentWorkingDirectory(toPath: originalDirectory)
    }
    try setCurrentWorkingDirectory(toPath: path)
    try closure()
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
            return Self((try? getCurrentWorkingDirectory()) ?? ".")
        }

        set {
            try? setCurrentWorkingDirectory(toPath:)(newValue.pathString)
        }
    }

    /// Execute a closure with this path being the working directory. Restore the original working direcotry
    /// afterwards.
    ///
    /// The closure is guaranteed to be invoked synchronously.
    ///
    /// - Parameter closure: The closure to be called with this path being the working directory.
    public func asCurrentWorkingDirectory(performAction closure: @escaping () throws -> Void) {
        try? withWorkingDirectory(beingPath: self.pathString, performAction: closure)
    }
}
