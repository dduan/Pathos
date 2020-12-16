#if canImport(Darwin)
import Darwin

extension Path {
    /// Return the metadata for the content pointed at by `self`.
    ///
    /// - Parameter followSymlink: Follow and resolve symlink and retrive metadata for its target.
    ///                            `false` means metadata for the symlink itself will be returned.
    ///
    /// - Returns: metadata for the path.
    public func metadata(followSymlink: Bool = false) throws -> Metadata {
        var status = stat()
        let correctStat = followSymlink ? stat : lstat
        return try binaryPath.c { cString in
            if correctStat(cString, &status) != 0 {
                throw SystemError(code: errno)
            }

            return Metadata(status)
        }
    }
}
#endif // canImport(Darwin)
