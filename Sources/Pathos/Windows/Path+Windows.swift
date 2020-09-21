#if os(Windows)
import WindowsHelpers
import WinSDK
extension Path {
    public static func workingDirectory() throws -> Path {
        let binary = try ContiguousArray<WindowsEncodingUnit>(unsafeUninitializedCapacity: Int(MAX_PATH))
        { buffer, count in
            let length = Int(GetCurrentDirectoryW(DWORD(MAX_PATH), buffer.baseAddress))
            if length == 0 {
                throw SystemError(code: GetLastError())
            } else {
                count = length + 1
            }

            buffer[length] = 0
        }

        return Path(WindowsBinaryString(nulTerminatedStorage: binary))
    }

    public static func setWorkingDirectory(_ path: Path) throws {
        try path.binaryPath.c { cString in
            if !SetCurrentDirectoryW(cString) {
                throw SystemError(code: GetLastError())
            }
        }
    }

    public func metadata(followSymlink: Bool = false) throws -> Metadata {
        let binary = try followSymlink ? realPath().binaryPath : binaryPath
        var data = WIN32_FIND_DATAW()
        try binary.c { cString in
            let handle = FindFirstFileW(cString, &data)
            if handle == INVALID_HANDLE_VALUE {
                throw SystemError(code: GetLastError())
            }

            CloseHandle(handle)
        }
        return Metadata(data)
    }

    /// List the content of the directory, recursively if required.
    ///
    /// - Parameter recursive: Require content of the directories inside the directory to be included in the
    ///                        result, recursively.
    ///
    /// - Returns: A sequence containing pair of path and the file type from the content of the directory.
    public func children(recursive: Bool = false) throws -> AnySequence<Path> {
        var result = [Path]()
        var data = WIN32_FIND_DATAW()
        try (self + "*").binaryPath.c { pathCString in
            let handle = FindFirstFileW(pathCString, &data)
            if handle == INVALID_HANDLE_VALUE {
                throw SystemError(code: GetLastError())
            }

            defer {
                CloseHandle(handle)
            }

            func addResultIfNecessary(_ data: inout WIN32_FIND_DATAW) throws {
                if data.cFileName.0 == WindowsConstants.binaryCurrentContext {
                    if data.cFileName.1 == 0
                        || data.cFileName.1 == WindowsConstants.binaryCurrentContext && data.cFileName.2 == 0
                    {
                        return
                    }
                }

                let binary = withUnsafePointer(
                    to: data.cFileName,
                    { $0.withMemoryRebound(
                        to: WindowsEncodingUnit.self,
                        capacity: Int(MAX_PATH)
                    ) { WindowsBinaryString(cString: $0) }
                    }
                )

                let path = joined(with: binary)
                let meta = Metadata(data)

                if recursive && meta.fileType.isDirectory {
                    result += try path.children(recursive: true)
                }

                result.append(path)
            }

            try addResultIfNecessary(&data)

            while FindNextFileW(handle, &data) {
                try addResultIfNecessary(&data)
            }
        }
        return AnySequence(result)
    }

    /// Set new permissions for a file path.
    ///
    /// - Parameter permissions: The new file permission.
    public func set(_ permissions: Permissions) throws {
        guard let windowsAttributes = permissions as? WindowsAttributes else {
            fatalError("Attempting to set incompatable permissions")
        }

        try binaryPath.c { cString in
            if !SetFileAttributesW(cString, windowsAttributes.rawValue) {
                throw SystemError(code: GetLastError())
            }
        }
    }

    /// Create a directory, and, optionally, any intermediate directories that leads to it, if they don't
    /// exist yet.
    ///
    /// - Parameter withParents: Create intermediate directories as required. If this option is not specified,
    ///                          the full path prefix of each operand must already exist.
    ///                          On the other hand, with this option specified, no error will be reported if a
    ///                          directory given as an operand already exists.
    public func makeDirectory(withParents: Bool = false) throws {
        func _makeDirectory() throws {
            try binaryPath.c { cString in
                if !CreateDirectoryW(cString, nil) {
                    let error = SystemError(code: GetLastError())
                    if !exists() || error == .fileExists && !withParents {
                        throw error
                    }
                }
            }
        }

        if withParents && !pure.segments.isEmpty {
            let parents = self.parents.makeIterator()
            try parents.next()?.makeDirectory(withParents: true)
        }

        try _makeDirectory()
    }

    public func delete(recursive: Bool = true) throws {
        func temporaryName() -> Path {
            Path.defaultTemporaryDirectory.joined(with: "\(UInt64.random(in: 0 ... .max))")
        }

        let meta = try metadata()
        if meta.permissions.isReadOnly {
            var newPermission = meta.permissions
            newPermission.isReadOnly = false
            try set(newPermission)
        }

        if meta.fileType.isDirectory {
            if recursive {
                for child in try children(recursive: false) {
                    try child.delete(recursive: true)
                }

                try temporaryName().binaryPath.c { tempCString in
                    try binaryPath.c { fromCString in
                        if !MoveFileW(fromCString, tempCString) {
                            throw SystemError(code: GetLastError())
                        }

                        if !RemoveDirectoryW(tempCString) {
                            throw SystemError(code: GetLastError())
                        }
                    }
                }
            } else {
                try binaryPath.c { fromCString in
                    if !RemoveDirectoryW(fromCString) {
                        throw SystemError(code: GetLastError())
                    }
                }
            }

        } else {
            try temporaryName().binaryPath.c { tempCString in
                try binaryPath.c { fromCString in
                    if !MoveFileW(fromCString, tempCString) {
                        throw SystemError(code: GetLastError())
                    }
                    if !DeleteFileW(tempCString) {
                        throw SystemError(code: GetLastError())
                    }
                }
            }
        }
    }

    public func move(to newPath: Path) throws {
        try binaryPath.c { fromCString in
            try newPath.binaryPath.c { toCString in
                if !MoveFileW(fromCString, toCString) {
                    throw SystemError(code: GetLastError())
                }
            }
        }
    }

    public func readSymlink() throws -> Path {
        // Warning: intense Windows/C wacky-ness ahead.
        //
        // DeviceIoControl returns multiple type of structs, depending on which one you ask for via one of
        // its parameters. Here, we ask for a FSCTL_GET_REPARSE_POINT. This returns an REPARSE_DATA_BUFFER:
        // https://docs.microsoft.com/en-us/windows-hardware/drivers/ddi/ntifs/ns-ntifs-_reparse_data_buffer
        //
        // Because this guy is from a exotic place (NT kernel), we include a copy* of it as part of this
        // porject.
        //
        // REPARSE_DATA_BUFFER is a C struct that uses a few C features that Swift does not directly support.
        //
        // First of all, it has a union member with each option being structs with different content. We
        // include a copy of a struct with the union member flattened as direct members for each.
        //
        // Two of these options each has a "flexible array member". The last member of these structs is a
        // storage for the first element in an array.
        //
        // `DeviceIoControl` tells us the size of REPARSE_DATA_BUFFER, including the flexible array member.
        // To read data from this flexible array, we first skip the fixed potion of `REPARSE_DATA_BUFFER` from
        // the raw buffer returned by `DeviceIoControl`. Then, we cast the raw buffer to array whos element is
        // the same as the flexible array member's element (wchar_t). Since we know the first element is in
        // the fixed potion of `REPARSE_DATA_BUFFER`, we substract 1 step from the newly casted buffer, and
        // read its content from there.
        //
        // Each of the union member in `REPARSE_DATA_BUFFER` also contains content size of the flexible array.
        // We use that information as well when reading from it.
        try binaryPath.c { cString -> Path in
            let handle = CreateFileW(
                cString,
                0,
                0,
                nil,
                DWORD(OPEN_EXISTING),
                DWORD(FILE_FLAG_OPEN_REPARSE_POINT | FILE_FLAG_BACKUP_SEMANTICS),
                nil
            )

            if handle == INVALID_HANDLE_VALUE {
                throw SystemError(code: GetLastError())
            }

            defer {
                CloseHandle(handle)
            }

            let data = try ContiguousArray<CChar>(unsafeUninitializedCapacity: 16 * 1024) { buffer, count in
                var size: DWORD = 0
                if !DeviceIoControl(
                    handle,
                    FSCTL_GET_REPARSE_POINT,
                    nil,
                    0,
                    buffer.baseAddress,
                    DWORD(buffer.count),
                    &size,
                    nil
                ) {
                    throw SystemError(code: GetLastError())
                }
                count = Int(size)
            }

            return try withUnsafePointer(to: data) {
                try $0.withMemoryRebound(to: [ReparseDataBuffer].self, capacity: 1) { reparseDataBuffer -> Path in
                    guard let reparseData = reparseDataBuffer.pointee.first else {
                        throw SystemError(code: 0x0000_00DE)
                    }

                    let nameStartingPoint: Int
                    let nameLength = Int(reparseData.substituteNameLength) / MemoryLayout<WindowsEncodingUnit>.stride
                    if reparseData.reparseTag == IO_REPARSE_TAG_SYMLINK {
                        nameStartingPoint = (MemoryLayout<SymbolicLinkReparseBuffer>.stride - 4) / 2
                    } else if reparseData.reparseTag == IO_REPARSE_TAG_MOUNT_POINT {
                        nameStartingPoint = (MemoryLayout<MountPointReparseBuffer>.stride - 4) / 2
                    } else {
                        throw SystemError(code: 0x0000_00DE)
                    }

                    return withUnsafePointer(to: data) {
                        $0.withMemoryRebound(to: [UInt16].self, capacity: data.count / 2) { wideData in
                            Path(cString: Array(wideData.pointee[nameStartingPoint ..< (nameStartingPoint + nameLength)]) + [0])
                        }
                    }
                }
            }
        }
    }

    /// Create a symbolic link to this path.
    ///
    /// - Parameter path: The path at which to create the symlink.
    public func makeSymlink(at path: Path) throws {
        let flag: DWORD = try metadata().fileType.isDirectory
            ? DWORD(SYMBOLIC_LINK_FLAG_DIRECTORY)
            : 0
        try binaryPath.c { thisPath in
            try path.binaryPath.c { link in
                if CreateSymbolicLinkW(link, thisPath, flag) == 0 {
                    throw SystemError(code: GetLastError())
                }
            }
        }
    }

    func _write(bytes: UnsafeRawPointer, byteCount: Int, createIfNecessary: Bool = true, truncate: Bool = true) throws {
        let deposition: DWORD

        switch (createIfNecessary, truncate) {
        case (false, false):
            deposition = DWORD(OPEN_EXISTING)
        case (true, false):
            deposition = DWORD(OPEN_ALWAYS)
        case (false, true):
            deposition = DWORD(TRUNCATE_EXISTING)
        case (true, true):
            deposition = DWORD(CREATE_ALWAYS)
        }

        try binaryPath.c { cString in
            let handle = CreateFileW(
                cString,
                DWORD(GENERIC_WRITE),
                0,
                nil,
                deposition,
                DWORD(FILE_ATTRIBUTE_NORMAL),
                nil
            )

            if handle == INVALID_HANDLE_VALUE {
                throw SystemError(code: GetLastError())
            }

            defer {
                CloseHandle(handle)
            }

            var bytesWritten: DWORD = 0

            if !WriteFile(
                handle,
                bytes,
                DWORD(byteCount),
                &bytesWritten,
                nil
            ) {
                throw SystemError(code: GetLastError())
            }
        }
    }

    public func readBytes(atPath path: String) throws -> [CChar] {
        try binaryPath.c { cString in
            let handle = CreateFileW(
                cString,
                DWORD(FILE_SHARE_READ),
                0,
                nil,
                DWORD(OPEN_EXISTING),
                DWORD(FILE_FLAG_BACKUP_SEMANTICS),
                nil
            )

            if handle == INVALID_HANDLE_VALUE {
                throw SystemError(code: GetLastError())
            }

            defer {
                CloseHandle(handle)
            }

            let meta = try metadata()
            if meta.fileType.isDirectory {
                return []
            }

            return try Array(unsafeUninitializedCapacity: meta.size) { buffer, count in
                var read: DWORD = 0
                if !ReadFile(
                    handle,
                    buffer.baseAddress,
                    DWORD(meta.size),
                    &read,
                    nil
                ) {
                    throw SystemError(code: GetLastError())
                }

                count = read
            }
        }
    }

    private func realPath() throws -> Path {
        try binaryPath.c { cString in
            let handle = CreateFileW(
                cString,
                0,
                0,
                nil,
                DWORD(OPEN_EXISTING),
                DWORD(FILE_FLAG_BACKUP_SEMANTICS),
                nil
            )

            if handle == INVALID_HANDLE_VALUE {
                throw SystemError(code: GetLastError())
            }

            defer {
                CloseHandle(handle)
            }

            let binary = try ContiguousArray<WindowsEncodingUnit>(
                unsafeUninitializedCapacity: Int(MAX_PATH)
            ) { buffer, count in
                let length = Int(
                    GetFinalPathNameByHandleW(
                        handle,
                        buffer.baseAddress,
                        DWORD(MAX_PATH),
                        DWORD(FILE_NAME_OPENED)
                    )
                )

                if length == 0 {
                    throw SystemError(code: GetLastError())
                }

                buffer[length] = 0
                count = length + 1
            }

            return Path(WindowsBinaryString(nulTerminatedStorage: binary))
        }
    }
}
#endif // os(Windows)
