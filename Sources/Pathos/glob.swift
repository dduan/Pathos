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

    return (0 ..< Int(gt.gl_pathc)).compactMap { String(validatingUTF8: gt.gl_pathv[$0]!) }
}

// TODO: Missing docstring.
public func glob(_ pattern: String) throws -> [String] {
    guard let globStarPosition = pattern.firstIndex(of: "**") else {
        return _glob(pattern)
            .map { _stripFromRight($0, kSeparatorCharacter) }
    }

    func recursiveFNMatch(_ path: String) throws -> [String] {
        return try children(inPath: path, recursive: true)
            .filter { fnmatch(pattern, $0, 0) == 0 }
    }

    return try _glob(String(pattern[pattern.startIndex ..< globStarPosition]))
        .filter(isDirectory(atPath:))
        .flatMap(recursiveFNMatch)
        .map { _stripFromRight($0, kSeparatorCharacter) }
}

extension PathRepresentable {
    // TODO: Missing docstring.
    public static func glob(_ pattern: String) -> [Self] {
        return (try? Pathos.glob(_:)(pattern).map(Self.init)) ?? []
    }
}
