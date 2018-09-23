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
    var newPath = newComponents.joined(separator: kSeparator)
    if initialSlashes != 0 {
        newPath = String(Array(repeating: kSeparatorCharacter, count: initialSlashes)) + newPath
    }
    return newPath.isEmpty ? "." : newPath
}

// TODO: missing docstring.
public func isAbsolute(path: String) -> Bool {
    return path.hasPrefix(kSeparator)
}

// TODO: missing docstring.
public func join(path: String, withPaths otherPaths: [String]) -> String {
    var result = path
    for other in otherPaths {
        if other.hasPrefix(kSeparator) {
            result = other
        } else if result.isEmpty || result.hasSuffix(kSeparator) {
            result += other
        } else {
            result += kSeparator + other
        }
    }

    return result
}

// TODO: missing docstring.
public func join(path: String, withPath otherPath: String) -> String {
    return join(path: path, withPaths: [otherPath])
}

// TODO: missing docstring.
public func join(path: String, withPaths otherPaths: String...) -> String {
    return join(path: path, withPaths: otherPaths)
}

// TODO: missing docstring.
public func join(paths path: String, _ otherPaths: String...) -> String {
    return join(path: path, withPaths: otherPaths)
}

// TODO: missing docstring.
public func split(path: String) -> (String, String) {
    guard let index = path.lastIndex(of: kSeparatorCharacter) else {
        return ("", path)
    }

    let next = path.index(after: index)
    var head = String(path.prefix(upTo: next))
    let tail = String(path.suffix(from: next))

    if !head.isEmpty && head != String(Array(repeating: kSeparatorCharacter, count: head.count)) {
        while head.last == kSeparatorCharacter {
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

    var nameIndex = path.lastIndex(of: kSeparatorCharacter)
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
    if let separatorIndex = path.lastIndex(of: kSeparatorCharacter) {
        return String(path.suffix(from: path.index(after: separatorIndex)))
    } else {
        return path
    }
}

// TODO: missing docstring.
public func directory(ofPath path: String) -> String {
    let head = path
        .lastIndex(of: kSeparatorCharacter)
        .map { path.prefix(upTo: path.index(after: $0)) }
        .map(String.init)
        ?? ""
    if !head.isEmpty && head != String(Array(repeating: kSeparatorCharacter, count: head.count)) {
        return _stripFromRight(head, kSeparatorCharacter)
    }

    return head
}

// TODO: Missing implementation.
func _commonPath(amongPaths paths: [String]) -> String {
    fatalError("unimplemented")
}

// TODO: Missing tests.
// TODO: Missing docstring.
public func commonPath(amongPaths paths: String...) -> String {
    return _commonPath(amongPaths: paths)
}

// TODO: Missing tests.
// TODO: Missing docstring.
public func commonPath(betweenPath path: String, andPath otherPath: String) -> String {
    return _commonPath(amongPaths: [path, otherPath])
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
    public func join(with otherPaths: [PathRepresentable]) -> Self {
        let newPathString = join(path:withPaths:)(self.pathString, otherPaths.map { $0.pathString })
        return Self(string: newPathString)
    }

    // TODO: missing docstring.
    public func join(with otherPaths: PathRepresentable...) -> Self {
        return self.join(with: otherPaths)
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

    // TODO: Missing tests.
    // TODO: Missing docstring.
    public func commonPath(with paths: [PathRepresentable]) -> Self {
        let pathStrings = [self.pathString] + paths.map { $0.pathString }
        return Self.init(string: _commonPath(amongPaths:)(pathStrings))
    }
}

