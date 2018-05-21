func normalizePath(_ path: String) -> String {
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

func isAbsolutePath(_ path: String) -> Bool {
    return path.hasPrefix(kSeparator)
}

extension PathRepresentable {
}

func join(path: String, withOtherPaths otherPaths: [String]) -> String {
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

func join(path: String, withOtherPaths otherPaths: String...) -> String {
    return join(path: path, withOtherPaths: otherPaths)
}

func split(path: String) -> (String, String) {
    guard let index = path.lastIndex(of: kSeparatorCharacter) else {
        return ("", path)
    }

    let next = path.index(after: index)
    var head = String(path.prefix(upTo: index))
    let tail = String(path.suffix(from: next))

    while head.last == kSeparatorCharacter {
        head.removeLast()
    }

    return (String(head), String(tail))
}

func splitExtension(ofPath path: String) -> (String, String) {
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

func fileExtension(ofPath path: String) -> String {
    return splitExtension(ofPath: path).1
}

func basename(ofPath path: String) -> String {
    return path
        .lastIndex(of: kSeparatorCharacter)
        .map { path.suffix(from: path.index(after: $0)) }
        .map(String.init)
        ?? ""
}

func directory(ofPath path: String) -> String {
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

extension PathRepresentable {
    func normalize() -> String {
        return normalizePath(self.pathString)
    }

    var isAbsolute: Bool {
        return isAbsolutePath(self.pathString)
    }

    func join(with otherPaths: [PathRepresentable]) -> Self {
        let newPathString = join(path:withOtherPaths:)(self.pathString, otherPaths.map { $0.pathString })
        return Self(path: newPathString)
    }

    func join(with otherPaths: PathRepresentable...) -> Self {
        return self.join(with: otherPaths)
    }

    func split() -> (Self, Self) {
        let (p0, p1) = split(path:)(self.pathString)
        return (Self(path: p0), Self(path: p1))
    }

    func splitExtension() -> (Self, String) {
        let splitResult = splitExtension(ofPath:)(self.pathString)
        return (Self(path: splitResult.0), splitResult.1)
    }

    var directory: String {
        return directory(ofPath:)(self.pathString)
    }

    var basename: String {
        return basename(ofPath:)(self.pathString)
    }

    var `extension`: String {
        return fileExtension(ofPath:)(self.pathString)
    }
}

