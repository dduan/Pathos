extension Path.Parts {
    static func parse<C, Encoding>(
        _ binary: C,
        as _: Encoding.Type,
        separator: Encoding.CodeUnit,
        currentContext: Encoding.CodeUnit
    ) -> (String?, [String])
        where
        C: RandomAccessCollection,
        C.Index == Int,
        Encoding: _UnicodeEncoding,
        C.Element == Encoding.CodeUnit
    {
        let rest: C.SubSequence
        let root: String?
        if !binary.isEmpty && binary[0] == separator {
            let stop = binary.firstIndex(where: { $0 != separator }) ?? 0
            if stop == 2 {
                root = String(decoding: [separator, separator], as: Encoding.self)
            } else {
                root = String(decoding: [separator], as: Encoding.self)
            }
            rest = binary[stop...]
        } else {
            root = nil
            rest = binary[...]
        }

        let segments = rest
            .split(separator: separator)
            .filter { $0.count != 1 || $0.first != currentContext }
            .map { String(decoding: $0, as: Encoding.self) }

        return (root, segments)
    }

    var `extension`: String? {
        segments.last.flatMap { Self.findExtension(s: $0[...])?.0 }
    }

    var extensions: [String] {
        guard let name = segments.last else {
            return []
        }

        var result = [String]()
        var rest = name[...]
        while let (suffix, dotIndex) = Self.findExtension(s: rest) {
            rest = name[..<dotIndex]
            result.insert(suffix, at: 0)
        }

        return result
    }

    private static func findExtension(s: String.SubSequence) -> (String, String.Index)? {
        guard let dotIndex = s.lastIndex(of: Constants.currentContextCharacter),
            dotIndex != s.startIndex
        else {
            return nil
        }

        return (String(s[dotIndex...]), dotIndex)
    }

    func parentParts(terminated: Bool) -> Self? {
        if drive == nil && root == nil && (segments.count == 1 && segments.first == Constants.currentContext || segments.count <= 1) {
            if terminated {
                return nil
            }

            return Self(drive: nil, root: nil, segments: [Constants.currentContext])
        }

        if terminated && segments.isEmpty {
            return nil
        }

        return Self(drive: drive, root: root, segments: segments.dropLast())
    }
}
