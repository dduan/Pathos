struct PathParts {
    let drive: Bytes
    let root: Bytes
    let segments: Array<Bytes>

    init(bytes: Bytes, isWindows: Bool) {
        var bytes = bytes
        var drive: Bytes = []

        if isWindows {
            bytes = Bytes(bytes.map { $0 == alternativeSeparatorByte ? windowsSeparatorByte : $0 })
            (drive, bytes) = Self.splitDrive(path: bytes)
        }

        let separator = isWindows ? WindowsConstants.separatorByte : POSIXConstants.separatorByte

        self.drive = drive

        let rest: Bytes.SubSequence
        if !bytes.isEmpty && bytes[0] == separator {
            let stop = bytes.firstIndex(where: { $0 != separator }) ?? 0
            if stop == 2 {
                root = [separator, separator]
            } else {
                root = [separator]
            }
            rest = bytes[stop...]
        } else {
            root = []
            rest = bytes[...]
        }

        segments = rest
            .split(separator: separator)
            .map(ContiguousArray.init)
            .filter { $0.count != 1 || $0.first != Constants.currentDirectoryByte }
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
    static func splitDrive(path: Bytes) -> (Bytes, Bytes) {
        if path.count > 2 && path.starts(with: [windowsSeparatorByte, windowsSeparatorByte])
            && path[2] != windowsSeparatorByte
        {
            // UNC path
            guard let nextSlashIndex = path[2...].firstIndex(of: windowsSeparatorByte) else {
                return ([], Bytes(path))
            }

            guard path.count > nextSlashIndex + 1,
                let nextNextSlashIndex = path[(nextSlashIndex + 1)...].firstIndex(of: windowsSeparatorByte)
                else
            {
                return (Bytes(path), [])
            }

            if nextNextSlashIndex == nextSlashIndex + 1 {
                return ([], Bytes(path))
            }

            return (
                Bytes(path.prefix(nextNextSlashIndex)),
                Bytes(path.dropFirst(nextNextSlashIndex))
            )
        }

        let colonIndex = path.index(after: path.startIndex)

        if path.count > 1 && path[colonIndex] == colonByte {
            return (
                Bytes(path[...colonIndex]),
                Bytes(path.dropFirst(2))
            )
        }

        return ([], Bytes(path))
    }
}

private let windowsSeparatorByte = "\\".utf8CString[0]
private let alternativeSeparatorByte = "/".utf8CString[0]
private let colonByte = ":".utf8CString[0]
