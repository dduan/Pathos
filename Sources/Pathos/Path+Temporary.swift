#if os(Windows)
import WinSDK
#elseif canImport(Darwin)
import Darwin
#else
import Glibc
#endif

private func getEnvVar(_ name: String) -> Path? {
    #if os(Windows)
    return name.withCString(encodedAs: UTF16.self) { namePtr -> ContiguousArray<WindowsEncodingUnit>? in
        let storage = ContiguousArray<WindowsEncodingUnit>(
            unsafeUninitializedCapacity: Int(MAX_PATH)
        ) { buffer, count in
            let length = Int(GetEnvironmentVariableW(namePtr, buffer.baseAddress, DWORD(MAX_PATH)))
            if length == 0 {
                count = 0
            } else {
                buffer[length] = 0
                count = length + 1
            }
        }

        return storage.isEmpty ? nil : storage
    }
    .map { Path(WindowsBinaryString(nulTerminatedStorage: $0)) }
    #else
    return getenv(name)
        .map { Path(BinaryString(cString: $0)) }
    #endif
}

extension Path {
    /// Search for a temporary directory suitable as the default temprorary directory.
    ///
    /// A suitable location is in one of the candidate list and allows write permission for this process.
    ///
    /// The list of candidate locations to consider are the following:
    /// * Location defined as the TMPDIR environment variable.
    /// * Location defined as the TMP environment variable.
    /// * Location defined as the TMPDIR environment variable.
    /// * /tmp
    /// * /var/tmp
    /// * /usr/tmp
    /// Location defined as the HOME or USERPROFILE environment variable.
    /// * Current working directory.
    ///
    /// - Returns: A suitable default temprary directory.
    public static func searchForDefaultTemporaryDirectory() -> Path {
        for envName in ["TMPDIR", "TMP", "TEMP"] {
            if let envvar = getEnvVar(envName), (try? envvar.metadata())?.permissions.isReadOnly == false {
                return envvar
            }
        }

        for tmpPath in ["/tmp", "/var/tmp", "/usr/tmp"] {
            let path = Path(tmpPath)
            if (try? path.metadata())?.permissions.isReadOnly == false {
                return path
            }
        }

        for envName in ["HOME", "USERPROFILE"] {
            if let envvar = getEnvVar(envName), (try? envvar.metadata())?.permissions.isReadOnly == false {
                return envvar
            }
        }

        return (try? .workingDirectory()) ?? Path(".")
    }

    /// The default temporary used Pathos uses. Its default value is computed by
    /// `.searchForDefaultTemporaryDirectory`. If this value is set to `/x/y/z`, then functions such as
    /// `Pathos.makeTemporaryDirectory()` will create its result in `/x/y/z`.
    public static var defaultTemporaryDirectory: Path = .searchForDefaultTemporaryDirectory()

    private static func constructTemporaryPath(prefix: String = "", suffix: String = "") -> Path {
        defaultTemporaryDirectory.joined(with: "\(prefix)\(UInt64.random(in: 0 ... .max))\(suffix)")
    }

    /// Make a temporary directory with write access.
    ///
    /// The parent of the return value is the current value of `Path.defaultTemporaryDirectory`. It will have
    /// a randomized name. A prefix and a suffix can be optionally specified as options.
    ///
    /// - Parameters:
    ///     - prefix: A prefix for the temporary directories's name.
    ///     - suffix: A suffix for the temporary directories's name.
    ///
    /// - Returns: A temporary directory.
    public static func makeTemporaryDirectory(prefix: String = "", suffix: String = "") throws -> Path {
        let path = constructTemporaryPath(prefix: prefix, suffix: suffix)
        try path.makeDirectory()
        return path
    }

    /// Execute some code with a temporarily created directory as the current working directory.
    ///
    /// This method does the following:
    ///
    /// 1. make a temporary directory with write access (`Path.makeTemporaryDirectory`)
    /// 2. set the directory from previous step as the current working directory.
    /// 3. execute a closure as supplied as argument.
    /// 4. reset the current working directory.
    /// 5. delete the temprary directory along with its content.
    ///
    /// - Parameter action: The closure to execute in the temporary environment. The temporary directory is
    ///                     sent as a parameter for the action closure.
    public static func withTemporaryDirectory(
        performAction action: @escaping (Path) throws -> Void
    ) throws {
        let temporaryDirectory = try makeTemporaryDirectory()
        try temporaryDirectory.asWorkingDirectory {
            try action(temporaryDirectory)
        }

        try temporaryDirectory.delete(recursive: true)
    }
}
