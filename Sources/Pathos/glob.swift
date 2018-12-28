#if os(Linux)
import Glibc

private let systemGlob = Glibc.glob
#else
import Darwin

private let systemGlob = Darwin.glob
#endif

private func _glob(_ pattern: String) -> [String] {
    var gt = glob_t()
    defer {
        globfree(&gt)
    }

    let flags =  GLOB_TILDE | GLOB_BRACE
    guard systemGlob(pattern, flags, nil, &gt) == 0 else {
        return []
    }

    let count = Int(gt.gl_pathc)
    return (0 ..< count)
        .compactMap { gt.gl_pathv[$0] }
        .compactMap { String(validatingUTF8: $0) }
}

/// Find all the path names matching a specified pattern according to the rules used by the Unix shells.
/// Home directory (tilde, `~`) gets expanded. "Globstar" (`**`) can be included as part of the pattern to
/// represent all intermediary directories, making the search recursive, similar¹ to pattern expansion on Zsh,
/// Fish and Bash 4+. This is implemented with libc².
///
/// ¹ globstar expansion has many quirks and differences among different implementations. Pathos use the
/// following algorithm:
///   - find the leftmost occurance of `**` (ignore the rest of occurances).
///   - split the pattern by middle of the globstar. So `a/**/c/*.swift`, for example, would become `a/*` and
///     `*/c/*.swift`.
///   - perform a non-recursive, system glob with the first half (`a/*` from previous example).
///   - for each result from previous glob that is a directory, recursively find all of its children.
///   - perform an `fnmatch` (per POSIX/libc) with the *full* pattern with each child, return the ones that
///     match.
///
/// ² due to libc implementation, there are subtle behaviral differences among platforms. Specifically, broken
/// symbolic links will not be found on Linux, but it will be included on Darwin.
///
/// - Parameter pattern: a pattern according to rules of Unix shells.
/// - Returns: paths in current working directory that matches the pattern.
/// - Throws: A `SystemError` if any sub-directory cannot be opened or there's not enough memory to hold all
///           data for results from listing child paths.
public func glob(_ pattern: String) throws -> [String] {
    guard let globStarPosition = pattern.firstIndex(of: "**") else {
        return _glob(pattern)
            .map { _stripFromRight($0, kSeparatorCharacter) }
    }

    func recursiveFNMatch(_ path: String) throws -> [String] {
        return try children(inPath: path, recursive: true)
            .filter { fnmatch(pattern, $0, 0) == 0 }
    }

    return try _glob(String(pattern[pattern.startIndex ... globStarPosition]))
        .filter(isDirectory(atPath:))
        .flatMap(recursiveFNMatch)
        .map { _stripFromRight($0, kSeparatorCharacter) }
}

extension PathRepresentable {
    /// Find all the path names matching a specified pattern according to the rules used by the Unix shells.
    /// Home directory (tilde, `~`) gets expanded. "Globstar" (`**`) can be included as part of the pattern to
    /// represent all intermediary directories, making the search recursive, similar¹ to pattern expansion on Zsh,
    /// Fish and Bash 4+. This is implemented with libc².
    ///
    /// ¹ globstar expansion has many quirks and differences among different implementations. Pathos use the
    /// following algorithm:
    ///   - find the leftmost occurance of `**` (ignore the rest of occurances).
    ///   - split the pattern by middle of the globstar. So `a/**/c/*.swift`, for example, would become `a/*` and
    ///     `*/c/*.swift`.
    ///   - perform a non-recursive, system glob with the first half (`a/*` from previous example).
    ///   - for each result from previous glob that is a directory, recursively find all of its children.
    ///   - perform an `fnmatch` (per POSIX/libc) with the *full* pattern with each child, return the ones that
    ///     match.
    ///
    /// ² due to libc implementation, there are subtle behaviral differences among platforms. Specifically, broken
    /// symbolic links will not be found on Linux, but it will be included on Darwin.
    ///
    /// - Parameter pattern: a pattern according to rules of Unix shells.
    /// - Returns: paths in current working directory that matches the pattern.
    public static func glob(_ pattern: String) -> [Self] {
        return (try? Pathos.glob(_:)(pattern).map(Self.init)) ?? []
    }
}
