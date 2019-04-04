/// Normalize a path by collapsing redundant separators and up-level references so that `A//B`, `A/B/`,
/// `A/./B` and `A/foo/../B` all become `A/B`. This string manipulation may change the meaning of a path that
/// contains symbolic links.
/// - Parameter path: The path to be normalized.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.normalized`.
public func normalize(path: String) -> String {
    if path.isEmpty {
        return "."
    }
    var initialSlashes = path.starts(with: "/") ? 1 : 0
    if initialSlashes == 1 && path.starts(with: "//") && !path.starts(with: "///") {
        initialSlashes = 2
    }
    var components = path.split(separator: "/").map(String.init)
    var newComponents = [String]()
    for c in components {
        if c.isEmpty || c == "." {
            continue
        }
        if c != ".." || (initialSlashes == 0 && newComponents.isEmpty) || newComponents.last == ".." {
            newComponents.append(String(c))
        } else if !newComponents.isEmpty {
            _ = newComponents.popLast()
        }
    }
    components = newComponents
    var newPath = newComponents.joined(separator: pathSeparator)
    if initialSlashes != 0 {
        newPath = String(Array(repeating: pathSeparatorCharacter, count: initialSlashes)) + newPath
    }
    return newPath.isEmpty ? "." : newPath
}

/// Return `true` if `path` is an absolute path name. On Unix, that means it begins with a slash.
/// - Paramater path: the path in question.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.isAbsolute`.
public func isAbsolute(path: String) -> Bool {
    return path.hasPrefix(pathSeparator)
}

// TODO: missing docstring.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.join(with:)`.
public func join(paths: [String]) -> String {
    var result = ""
    for other in paths {
        if other.hasPrefix(pathSeparator) {
            result = other
        } else if result.isEmpty || result.hasSuffix(pathSeparator) {
            result += other
        } else {
            result += pathSeparator + other
        }
    }

    return result
}

// TODO: missing docstring.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.join(with:_:)`.
public func join(paths firstPath: String, _ secondPath: String, _ otherPaths: String...) -> String {
    return join(paths: [firstPath, secondPath] + otherPaths)
}

/// Split the pathname path into a pair, "head", "tail" where "tail" is the last path name component and
/// "head" is everything leading up to that. The "tail" part will never contain a slash; if path ends in a
/// slash, "tail" will be empty. If there is no slash in path, head will be empty. If path is empty, both
/// "head" and "tail" are empty. Trailing slashes are stripped from head unless it is the root (one or more
/// slashes only).
/// - Parameter path: the path to be split.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.split()`.
public func split(path: String) -> (String, String) {
    guard let index = path.lastIndex(of: pathSeparatorCharacter) else {
        return ("", path)
    }

    let next = path.index(after: index)
    var head = String(path.prefix(upTo: next))
    let tail = String(path.suffix(from: next))

    if !head.isEmpty && head != String(Array(repeating: pathSeparatorCharacter, count: head.count)) {
        while head.last == pathSeparatorCharacter {
            head.removeLast()
        }
    }

    return (String(head), String(tail))
}

/// Split the path name into a pair "root", "ext" such that root + ext == original path, and "ext" is
/// empty or begins with a period and contains at most one period. Leading periods on the basename are
/// ignored.
/// - Parameter path: The path to be split.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.splitExtension()`.
public func splitExtension(ofPath path: String) -> (String, String) {
    guard let dotIndex = path.lastIndex(of: ".") else {
        return (path, "")
    }

    var nameIndex = path.lastIndex(of: pathSeparatorCharacter)
        .map { path.index(after: $0) }
        ?? path.startIndex

    guard nameIndex <= dotIndex else {
        return (path, "")
    }

    while nameIndex < dotIndex {
        if path[nameIndex] != "." {
            return (
                String(path.prefix(upTo: dotIndex)),
                String(path.suffix(from: dotIndex))
            )
        }

        nameIndex = path.index(after: nameIndex)
    }

    return (path, "")
}

// TODO: missing docstring.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.extension`.
public func fileExtension(ofPath path: String) -> String {
    return splitExtension(ofPath: path).1
}

// TODO: missing docstring.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.basename`.
public func basename(ofPath path: String) -> String {
    if let separatorIndex = path.lastIndex(of: pathSeparatorCharacter) {
        return String(path.suffix(from: path.index(after: separatorIndex)))
    } else {
        return path
    }
}

// TODO: missing docstring.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.directory`.
public func directory(ofPath path: String) -> String {
    let head = path
        .lastIndex(of: pathSeparatorCharacter)
        .map { path.prefix(upTo: path.index(after: $0)) }
        .map(String.init)
        ?? ""
    if !head.isEmpty && head != String(Array(repeating: pathSeparatorCharacter, count: head.count)) {
        return _stripFromRight(head, pathSeparatorCharacter)
    }

    return head
}

func _commonPath(amongPaths paths: [String]) -> String {
    assert(paths.count > 1)
    let firstPathIsAbsolute = isAbsolute(path: paths[0])
    if !(paths[1...].allSatisfy { isAbsolute(path: $0) == firstPathIsAbsolute }) {
        return ""
    }

    let splitPaths = paths
        .map { $0.split(separator: pathSeparatorCharacter) }
        .map { $0.filter { $0 != kCurrentDirectory } }
        .sorted { $0.count < $1.count }
    let shortest = splitPaths.first!
    let longest = splitPaths.last!

    var progress: Int?
    for (i, segment) in shortest.enumerated() {
        if longest[i] == segment {
            progress = i
        } else {
            break
        }
    }

    let joint = progress.map { longest[0...$0].joined(separator: pathSeparator) }
    let prefix = paths[0].hasPrefix(pathSeparator) ? "/" : ""
    return prefix + (joint ?? "")
}

/// Return the longest common sub-path of each given argument. Segment of sub-path is the smallest unit of
/// commonality, meaning this is different from common string prefix: `/usr/lib` and `/usr/lib64`'s common
/// path is `/usr` as opposed to `/usr/lib`.
///
/// - Parameters:
///   - firstPath: First path. This parameter ensures there are at least 2 paths to compare.
///   - secondPath: Second path. This parameter ensures there are at least 2 paths to compare.
///   - otherPaths: Other, optional paths.
/// - Returns: The longest common sub-path of each given argument.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.commonPath(with:_:)`.
public func commonPath(amongPaths firstPath: String, _ secondPath: String, _ otherPaths: String...) -> String
{
    return _commonPath(amongPaths: [firstPath, secondPath] + otherPaths)
}

/// Return relative location of `path` from from an another location.
/// This is a pure computation: the filesystem is not accessed to confirm the existence or nature of `path` or
/// `startingPath`.
/// Example: starting from `/Users/dan`, the relative path of `/` would be `../..`.
///
/// - Parameters:
///   - path: the path the result is relative to.
///   - startingPath: starting path of the relativity.
/// - Returns: a relative file path to `path`.
/// - SeeAlso: To work with `Path` or `PathRepresentable`, use `PathRepresentable.relativePath(to:)`.
public func relativePath(ofPath path: String, startingFromPath startingPath: String) -> String {
    let startSegments = startingPath.split(separator: pathSeparatorCharacter)
    let pathSegements = path.split(separator: pathSeparatorCharacter)
    let sharedCount = pathSegements.commonPrefix(with: startSegments).count
    let parentSegments = Array(repeating: kParentDirectory, count: max(startSegments.count - sharedCount, 0))
    let remainingSegments = pathSegements[sharedCount...].map(String.init)
    let allSegments = parentSegments + remainingSegments
    if allSegments.isEmpty {
        return kCurrentDirectory
    } else {
        return allSegments.joined(separator: pathSeparator)
    }
}

extension PathRepresentable {
    /// Normalize a path by collapsing redundant separators and up-level references so that `A//B`, `A/B/`,
    /// `A/./B` and `A/foo/../B` all become `A/B`. This string manipulation may change the meaning of a path
    /// that contains symbolic links.
    /// - SeeAlso: `normalize(path:)`.
    public var normalized: Self {
        return Self(normalize(path:)(self.pathString))
    }

    /// Return `true` if this path is an absolute path name. On Unix, that means it begins with a slash.
    /// - SeeAlso: `isAbsolute(path:)`.
    public var isAbsolute: Bool {
        return isAbsolute(path:)(self.pathString)
    }

    // TODO: missing docstring.
    /// - SeeAlso: `join(paths:)`.
    public func join(with paths: [PathRepresentable]) -> Self {
        return Self(join(paths:)([self.pathString] + paths.map { $0.pathString }))
    }

    // TODO: missing docstring.
    /// - SeeAlso: `join(paths:_:_:)`.
    public func join(with secondPath: PathRepresentable, _ otherPaths: PathRepresentable...) -> Self {
        let pathStrings = [self.pathString, secondPath.pathString] + otherPaths.map { $0.pathString }
        return Self(join(paths:)(pathStrings))
    }

    /// Split the path into a pair, "head", "tail" where "tail" is the last path name component and "head" is
    /// everything leading up to that. The "tail" part will never contain a slash; if path ends in a slash,
    /// "tail" will be empty. If there is no slash in path, head will be empty. If path is empty, both "head"
    /// and "tail" are empty. Trailing slashes are stripped from head unless it is the root (one or more 
    /// slashes only).
    /// - SeeAlso: `split(path:)`.
    public func split() -> (Self, Self) {
        let (p0, p1) = split(path:)(self.pathString)
        return (Self(p0), Self(p1))
    }

    /// Split the path name into a pair "root", "ext" such that root + ext == original path, and "ext" is
    /// empty or begins with a period and contains at most one period. Leading periods on the basename are
    /// ignored.
    /// - SeeAlso: `splitExtension(ofPath:)`.
    public func splitExtension() -> (Self, String) {
        let splitResult = splitExtension(ofPath:)(self.pathString)
        return (Self(splitResult.0), splitResult.1)
    }

    // TODO: missing docstring.
    /// - SeeAlso: `directory(ofPath:)`.
    public var directory: String {
        return directory(ofPath:)(self.pathString)
    }

    // TODO: missing docstring.
    /// - SeeAlso: `basename(ofPath:)`.
    public var basename: String {
        return basename(ofPath:)(self.pathString)
    }

    // TODO: missing docstring.
    /// - SeeAlso: `fileExtension(ofPath:)`.
    public var `extension`: String {
        return fileExtension(ofPath:)(self.pathString)
    }

    /// Return the longest common sub-path among self and each given argument. Segment of sub-path is the
    /// smallest unit of commonality, meaning this is different from common string prefix: `/usr/lib` and
    /// `/usr/lib64`'s common path is `/usr` as opposed to `/usr/lib`.
    ///
    /// - Parameters:
    ///   - second: The second path to compare. This ensures there's at least a path to compare to.
    ///   - others: Other, optional paths.
    /// - Returns: The longest common sub-path of each given argument.
    /// - SeeAlso: `commonPath(amongPaths:_:_:)`.
    public func commonPath(with second: PathRepresentable, _ others: PathRepresentable...) -> Self? {
        let pathStrings = [self.pathString, second.pathString] + others.map { $0.pathString }
        let commonString = _commonPath(amongPaths:)(pathStrings)
        return commonString.isEmpty ? nil : Self(commonString)
    }

    /// Return a relative path to `startingPath`.
    /// This is a pure computation: the filesystem is not accessed to confirm the existence or nature of `path` or
    /// `startingPath`.
    /// Example: starting from `/Users/dan`, the relative path of `/` would be `../..`.
    ///
    /// - Parameter startingPath: starting path of the relativity.
    /// - Returns: a relative file path to `path`.
    /// - SeeAlso: `relativePath(ofPath:)`.
    public func relativePath(to startingPath: PathRepresentable) -> Self {
        return Self(relativePath(ofPath:startingFromPath:)(self.pathString, startingPath.pathString))
    }
}

/// Syntax sugar for joining two `PathRepresentable`s.
public func + <T: PathRepresentable>(lhs: T, rhs: T) -> T {
    return lhs.join(with: rhs)
}
