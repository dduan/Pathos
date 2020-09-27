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
        let binary = try followSymlink ? finalName().binaryPath : binaryPath
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

    public func children(recursive: Bool = false, followSymlink: Bool = false) throws
        -> AnySequence<(Path, FileType)>
    {
        try childrenImpl(logicalParent: nil, recursive: recursive, followSymlink: followSymlink)
    }

    func childrenImpl(logicalParent: Path?, recursive: Bool = false, followSymlink: Bool = false) throws
        -> AnySequence<(Path, FileType)>
    {
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
            let logicalPath = (logicalParent ?? self).joined(with: binary)

            if recursive {
                if meta.fileType.isDirectory {
                    result += try path.childrenImpl(logicalParent: nil, recursive: true, followSymlink: followSymlink)
                } else if meta.fileType.isSymlink,
                    followSymlink,
                    let linkTarget = try? path.readSymlink(),
                    case let real = joined(with: linkTarget),
                    try real.metadata().fileType.isDirectory
                {
                    result += try real.childrenImpl(logicalParent: joined(with: logicalPath), recursive: recursive, followSymlink: true)
                }
            }

            result.append((logicalPath, meta.fileType))
        }

        var result = [(Path, FileType)]()
        var data = WIN32_FIND_DATAW()
        try (self + "*").binaryPath.c { pathCString in
            let handle = FindFirstFileW(pathCString, &data)
            if handle == INVALID_HANDLE_VALUE {
                throw SystemError(code: GetLastError())
            }

            defer {
                CloseHandle(handle)
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

        func error() throws {
            let errorCode = GetLastError()
            if errorCode != ERROR_PATH_NOT_FOUND {
                throw SystemError(code: GetLastError())
            }
        }

        let meta = try metadata()
        if meta.permissions.isReadOnly {
            var newPermission = meta.permissions
            newPermission.isReadOnly = false
            try set(newPermission)
        }
        if meta.fileType.isDirectory {
            if recursive {
                if !meta.fileType.isSymlink {
                    for child in try children(recursive: false) {
                        try child.0.delete(recursive: true)
                    }
                }

                try temporaryName().binaryPath.c { tempCString in
                    try binaryPath.c { fromCString in
                        if !MoveFileW(fromCString, tempCString) {
                            try error()
                        }

                        if !RemoveDirectoryW(tempCString) {
                            try error()
                        }
                    }
                }
            } else {
                try binaryPath.c { fromCString in
                    if !RemoveDirectoryW(fromCString) {
                        try error()
                    }
                }
            }
        } else {
            try temporaryName().binaryPath.c { tempCString in
                try binaryPath.c { fromCString in
                    if !MoveFileW(fromCString, tempCString) {
                        try error()
                    }
                    if !DeleteFileW(tempCString) {
                        try error()
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
        try withHandle(
            access: 0,
            diposition: OPEN_EXISTING,
            attributes: FILE_FLAG_OPEN_REPARSE_POINT | FILE_FLAG_BACKUP_SEMANTICS
        ) { handle in
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

    public func real() throws -> Path {
        func readLink(_ path: Path) throws -> Path {
            var path = path
            // These error codes indicate that we should stop reading links and
            // return the path we currently have.
            // 1: ERROR_INVALID_FUNCTION
            // 2: ERROR_FILE_NOT_FOUND
            // 3: ERROR_DIRECTORY_NOT_FOUND
            // 5: ERROR_ACCESS_DENIED
            // 21: ERROR_NOT_READY (implies drive with no media)
            // 32: ERROR_SHARING_VIOLATION (probably an NTFS paging file)
            // 50: ERROR_NOT_SUPPORTED (implies no support for reparse points)
            // 67: ERROR_BAD_NET_NAME (implies remote server unavailable)
            // 87: ERROR_INVALID_PARAMETER
            // 4390: ERROR_NOT_A_REPARSE_POINT
            // 4392: ERROR_INVALID_REPARSE_DATA
            // 4393: ERROR_REPARSE_TAG_INVALID
            let allowedErrors: Set<SystemError.Code> = [1, 2, 3, 5, 21, 32, 50, 67, 87, 4390, 4392, 4393]

            var seen = Set<Path>()

            while !seen.contains(path) {
                seen.insert(path)
                let oldPath = path
                do {
                    path = try path.readSymlink()
                    if !path.isAbsolute {
                        if (try? oldPath.metadata().fileType.isSymlink) != true {
                            path = oldPath
                            break
                        }

                        path = oldPath.parent + path
                    }
                } catch let error as SystemError {
                    if allowedErrors.contains(error.rawValue) {
                        break
                    } else {
                        throw error
                    }
                } catch {
                    throw error
                }
            }

            return path
        }

        func getFinalPathName(_ path: Path) throws -> Path {
            var path = path
            // These error codes indicate that we should stop resolving the path
            // and return the value we currently have.
            // 1: ERROR_INVALID_FUNCTION
            // 2: ERROR_FILE_NOT_FOUND
            // 3: ERROR_DIRECTORY_NOT_FOUND
            // 5: ERROR_ACCESS_DENIED
            // 21: ERROR_NOT_READY (implies drive with no media)
            // 32: ERROR_SHARING_VIOLATION (probably an NTFS paging file)
            // 50: ERROR_NOT_SUPPORTED
            // 67: ERROR_BAD_NET_NAME (implies remote server unavailable)
            // 87: ERROR_INVALID_PARAMETER
            // 123: ERROR_INVALID_NAME
            // 1920: ERROR_CANT_ACCESS_FILE
            // 1921: ERROR_CANT_RESOLVE_FILENAME (implies unfollowable symlink)
            let allowedErrors: Set<SystemError.Code> = [1, 2, 3, 5, 21, 32, 50, 67, 87, 123, 1920, 1921]
            var tail = Path(PureWindowsPath(parts: Path.Parts(drive: nil, root: nil, segments: [])))

            while !path.isEmpty {
                do {
                    path = try finalName()
                    return tail.isEmpty ? path : path + tail
                } catch let error as SystemError {
                    if allowedErrors.contains(error.rawValue) {
                        if let newPath = try? readLink(path) {
                            if newPath != path {
                                return tail.isEmpty ? newPath : newPath + tail
                            }
                        }
                    } else {
                        throw error
                    }
                    let name = path.name ?? ""
                    path = path.parent

                    if !path.isEmpty && name.isEmpty {
                        return path + tail
                    }

                    tail = tail.isEmpty ? Path(name) : name + tail
                } catch {
                    throw error
                }
            }

            return path
        }

        var path = self
        let prefix = #"\\?\"#
        let uncPrefix = #"\\?\UNC\"#
        let newUNCPrefix = #"\\"#
        let hadPrefix = hasPrefix(prefix)
        if !hadPrefix && !path.isAbsolute {
            path = try path.absolute()
        }

        var initialError: SystemError?
        do {
            path = try finalName()
        } catch let error as SystemError {
            initialError = error
            path = try getFinalPathName(path)
        } catch {
            throw error
        }

        if !hadPrefix && path.hasPrefix(prefix) {
            let sPath: Path
            if path.hasPrefix(uncPrefix) {
                sPath = path.replacing(prefix: uncPrefix, with: newUNCPrefix)
            } else {
                sPath = path.replacing(prefix: prefix, with: "")
            }

            do {
                if try sPath.finalName() == path {
                    path = sPath
                }
            } catch let error as SystemError {
                if error.rawValue == initialError?.rawValue {
                    path = sPath
                }
            } catch {
                throw error
            }
        }

        return path
    }

    func write(bytes: UnsafeRawPointer, byteCount: Int, createIfNecessary: Bool = true, truncate: Bool = true) throws {
        let diposition: Int32

        switch (createIfNecessary, truncate) {
        case (false, false):
            diposition = OPEN_EXISTING
        case (true, false):
            diposition = OPEN_ALWAYS
        case (false, true):
            diposition = TRUNCATE_EXISTING
        case (true, true):
            diposition = CREATE_ALWAYS
        }

        try withHandle(
            access: GENERIC_WRITE,
            diposition: diposition,
            attributes: FILE_ATTRIBUTE_NORMAL
        ) { handle in
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

    private func finalName() throws -> Path {
        try withHandle(
            access: 0,
            diposition: OPEN_EXISTING,
            attributes: FILE_FLAG_BACKUP_SEMANTICS
        ) { handle in
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

    func withHandle<Output>(access: Int32, diposition: Int32, attributes: Int32, run action: (HANDLE?) throws -> Output) throws -> Output {
        try binaryPath.c { cString in
            let handle = CreateFileW(
                cString,
                DWORD(access),
                0,
                nil,
                DWORD(diposition),
                DWORD(attributes),
                nil
            )

            if handle == INVALID_HANDLE_VALUE {
                throw SystemError(code: GetLastError())
            }

            defer {
                CloseHandle(handle)
            }

            return try action(handle)
        }
    }

    private func hasPrefix(_ prefix: String) -> Bool {
        drive?.hasPrefix(prefix) == true || root?.hasPrefix(prefix) == true
    }

    private func replacing(prefix: String, with newPrefix: String) -> Path {
        if let drive = drive, drive.hasPrefix(prefix) {
            let newDrive = newPrefix + drive.suffix(drive.count - prefix.count)
            return Path(PureWindowsPath(parts: .init(drive: newDrive, root: root, segments: segments)))
        } else if let root = root, root.hasPrefix(prefix) {
            let newRoot = newPrefix + root.suffix(root.count - prefix.count)
            return Path(PureWindowsPath(parts: .init(drive: drive, root: newRoot, segments: segments)))
        } else {
            return self
        }
    }
}
#endif // os(Windows)
