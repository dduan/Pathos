#if os(Windows)
import WinSDK
extension Path {
    public static func workingDirectory() throws -> Path {
        let binary = try ContiguousArray<WindowsEncodingUnit>(unsafeUninitializedCapacity: Int(MAX_PATH))
        { buffer, count in
            let length = GetCurrentDirectoryW(DWORD(MAX_PATH), buffer.baseAddress)
            if length == 0 {
                throw SystemError(code: GetLastError())
            } else {
                count = Int(length)
            }
        }

        return Path(binary)
    }

    public static func setWorkingDirectory(_ path: Path) throws {
        if !SetCurrentDirectoryW(path.binaryString.cString) {
            throw SystemError(code: GetLastError())
        }
    }

    public func metadata(followSymlink: Bool = false) throws -> Metadata {
        let binary = try followSymlink ? realPath().binaryString : binaryString
        var data = WIN32_FIND_DATAW()
        let handle = FindFirstFileW(binary.cString, &data)
        if handle == INVALID_HANDLE_VALUE {
            throw SystemError(code: GetLastError())
        }

        defer {
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
        let handle = FindFirstFileW((self + "*").binaryString.cString, &data)
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

        return AnySequence(result)
    }

    /// Set new permissions for a file path.
    ///
    /// - Parameter permissions: The new file permission.
    public func set(_ permissions: Permissions) throws {
        guard let windowsAttributes = permissions as? WindowsAttributes else {
            fatalError("Attempting to set incompatable permissions")
        }

        if !SetFileAttributesW(binaryString.cString, windowsAttributes.rawValue) {
            throw SystemError(code: GetLastError())
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
            if !CreateDirectoryW(binaryString.cString, nil) {
                let error = SystemError(code: GetLastError())
                if !exists() || error == .fileExists && !withParents {
                    throw error
                }
            }
        }

        if !withParents {
            try _makeDirectory()
        } else if !pure.segments.isEmpty {
            let parents = self.parents.makeIterator()
            try parents.next()?.makeDirectory(withParents: true)
        }

        try _makeDirectory()
    }

    public func delete(recursive: Bool = true) throws {
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

                let temp = try tempPath().binaryString.cString
                if !MoveFileW(binaryString.cString, temp) {
                    throw SystemError(code: GetLastError())
                }

                if !RemoveDirectoryW(temp) {
                    throw SystemError(code: GetLastError())
                }
            } else {
                if !RemoveDirectoryW(binaryString.cString) {
                    throw SystemError(code: GetLastError())
                }
            }

        } else {
            let temp = try tempPath().binaryString.cString
            if !MoveFileW(binaryString.cString, temp) {
                throw SystemError(code: GetLastError())
            }
            if !DeleteFileW(temp) {
                throw SystemError(code: GetLastError())
            }
        }
    }

    private func tempPath() throws -> Path {
        try defaultTemp() + "\(UInt64.random(in: 0 ... .max))"
    }

    // TODO: this is wrong because `GetTempPathW` does not ganrantee write/delete access to its result.
    private func defaultTemp() throws -> Path {
        try Path(ContiguousArray(unsafeUninitializedCapacity: Int(MAX_PATH)) { buffer, count in
            let length = GetTempPathW(
                DWORD(MAX_PATH),
                buffer.baseAddress
            )

            if length == 0 {
                throw SystemError(code: GetLastError())
            }

            count = Int(length)
        })
    }

    private func realPath() throws -> Path {
        let handle = CreateFileW(
            binaryString.cString,
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

        let binary = try ContiguousArray<WindowsEncodingUnit>(unsafeUninitializedCapacity: Int(MAX_PATH))
        { buffer, count in
            let length = GetFinalPathNameByHandleW(handle, buffer.baseAddress, DWORD(MAX_PATH), DWORD(FILE_NAME_OPENED))

            if length == 0 {
                throw SystemError(code: GetLastError())
            }

            count = Int(length)
        }

        return Path(binary)
    }
}
#endif // os(Windows)
