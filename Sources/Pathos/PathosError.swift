/// Errors Pathos reports in addition to `SystemError`.
public enum PathosError: Error {
    /// Attempt to copy a path to a named pipe.
    ///
    /// - Parameter path: the string value of the path.
    case attemptToCopyToNamedPipe(path: String)
    // Attempt to copy files but the path is neither a file nor a symbolic link to a file.
    ///
    /// - Parameter path: the string value of the path.
    case copyingNeitherFileNorSymblink(path: String)
}
