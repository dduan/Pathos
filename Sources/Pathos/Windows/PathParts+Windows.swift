private let windowsSeparatorByte = "\\".utf16.first!
private let alternativeSeparatorByte = "/".utf16.first!
private let colonByte = ":".utf16.first!

extension Path.Parts {
    init(forWindowsWithBinary binary: WindowsBinaryString) {
        let binary = WindowsBinaryString(binary.map { $0 == alternativeSeparatorByte ? windowsSeparatorByte : $0 })
        let (drive, rest) = Self.splitDrive(path: binary)
        self.drive = drive.isEmpty ? nil : String(decoding: drive, as: UTF16.self)
        (root, segments) = Self.parse(
            rest,
            as: UTF16.self,
            separator: WindowsConstants.binaryPathSeparator,
            currentContext: WindowsConstants.binaryCurrentContext
        )
    }

    /// Split the pathname path into a pair (drive, tail) where drive is either a
    /// mount point or the empty string. On systems which do not use drive
    /// specifications, drive will always be the empty string. In all cases, drive +
    /// tail will be the same as path.
    ///
    /// On Windows, splits a pathname into drive/UNC sharepoint and relative path.
    ///
    /// If the path contains a drive letter, drive will contain everything up to and
    /// including the colon. e.g. splitdrive("c:/dir") returns ("c:", "/dir")
    ///
    /// If the path contains a UNC path, drive will contain the host name and share,
    /// up to but not including the fourth separator. e.g.
    /// splitdrive("//host/computer/dir") returns ("//host/computer", "/dir")
    ///
    /// - Parameter path: The path to split.
    /// - Returns: A tuple with the first part being the drive or UNC host, the
    ///            second part being the rest of the path.
    static func splitDrive(path: WindowsBinaryString) -> (WindowsBinaryString, WindowsBinaryString) {
        if path.count > 2 && path.starts(with: [windowsSeparatorByte, windowsSeparatorByte])
            && path[2] != windowsSeparatorByte
        {
            // UNC path
            guard let nextSlashIndex = path[2...].firstIndex(of: windowsSeparatorByte) else {
                return ([], WindowsBinaryString(path))
            }

            guard path.count > nextSlashIndex + 1,
                let nextNextSlashIndex = path[(nextSlashIndex + 1)...].firstIndex(of: windowsSeparatorByte)
            else {
                return (WindowsBinaryString(path), [])
            }

            if nextNextSlashIndex == nextSlashIndex + 1 {
                return ([], WindowsBinaryString(path))
            }

            return (
                WindowsBinaryString(path.prefix(nextNextSlashIndex)),
                WindowsBinaryString(path.dropFirst(nextNextSlashIndex))
            )
        }

        let colonIndex = path.index(after: path.startIndex)

        if path.count > 1 && path[colonIndex] == colonByte {
            return (
                WindowsBinaryString(path[...colonIndex]),
                WindowsBinaryString(path.dropFirst(2))
            )
        }

        return ([], WindowsBinaryString(path))
    }
}
