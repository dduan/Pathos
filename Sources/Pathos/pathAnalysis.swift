// TODO: missing docstring.
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

// TODO: missing docstring.
public func isAbsolute(path: String) -> Bool {
    return path.hasPrefix(pathSeparator)
}

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
public func join(paths firstPath: String, _ secondPath: String, _ otherPaths: String...) -> String {
    return join(paths: [firstPath, secondPath] + otherPaths)
}

// TODO: missing docstring.
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

// TODO: missing docstring.
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
public func fileExtension(ofPath path: String) -> String {
    return splitExtension(ofPath: path).1
}

// TODO: missing docstring.
public func basename(ofPath path: String) -> String {
    if let separatorIndex = path.lastIndex(of: pathSeparatorCharacter) {
        return String(path.suffix(from: path.index(after: separatorIndex)))
    } else {
        return path
    }
}

// TODO: missing docstring.
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
    // TODO: missing docstring.
    public func normalize() -> Self {
        return Self(string: normalize(path:)(self.pathString))
    }

    // TODO: missing docstring.
    public var isAbsolute: Bool {
        return isAbsolute(path:)(self.pathString)
    }

    // TODO: missing docstring.
    public func join(with paths: [PathRepresentable]) -> Self {
        return Self(string: join(paths:)([self.pathString] + paths.map { $0.pathString }))
    }

    // TODO: missing docstring.
    public func join(with secondPath: PathRepresentable, _ otherPaths: PathRepresentable...) -> Self {
        let pathStrings = [self.pathString, secondPath.pathString] + otherPaths.map { $0.pathString }
        return Self(string: join(paths:)(pathStrings))
    }

    // TODO: missing docstring.
    public func split() -> (Self, Self) {
        let (p0, p1) = split(path:)(self.pathString)
        return (Self(string: p0), Self(string: p1))
    }

    // TODO: missing docstring.
    public func splitExtension() -> (Self, String) {
        let splitResult = splitExtension(ofPath:)(self.pathString)
        return (Self(string: splitResult.0), splitResult.1)
    }

    // TODO: missing docstring.
    public var directory: String {
        return directory(ofPath:)(self.pathString)
    }

    // TODO: missing docstring.
    public var basename: String {
        return basename(ofPath:)(self.pathString)
    }

    // TODO: missing docstring.
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
    public func commonPath(with second: PathRepresentable, _ others: PathRepresentable...) -> Self? {
        let pathStrings = [self.pathString, second.pathString] + others.map { $0.pathString }
        let commonString = _commonPath(amongPaths:)(pathStrings)
        return commonString.isEmpty ? nil : Self(string: commonString)
    }

    /// Return a relative path to `startingPath`.
    /// This is a pure computation: the filesystem is not accessed to confirm the existence or nature of `path` or
    /// `startingPath`.
    /// Example: starting from `/Users/dan`, the relative path of `/` would be `../..`.
    ///
    /// - Parameter startingPath: starting path of the relativity.
    /// - Returns: a relative file path to `path`.
    public func relativePath(to startingPath: PathRepresentable) -> Self {
        return Self(string: relativePath(ofPath:startingFromPath:)(self.pathString, startingPath.pathString))
    }
}

