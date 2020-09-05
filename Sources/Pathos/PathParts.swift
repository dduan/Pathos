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
}
