struct PathParts<NativeEncodingUnit: BinaryInteger> {
    typealias BinaryString = ContiguousArray<NativeEncodingUnit>
    let drive: BinaryString
    let root: BinaryString
    let segments: Array<BinaryString>

    static func parse(
        _ bytes: BinaryString,
        separator: NativeEncodingUnit,
        currentDirectory: NativeEncodingUnit
    ) -> (BinaryString, [BinaryString]) {
        let rest: BinaryString.SubSequence
        let root: BinaryString
        if !bytes.isEmpty && bytes[0] == separator {
            let stop = bytes.firstIndex(where: { $0 != separator }) ?? 0
            if stop == 2 {
                root = [separator, separator]
            } else {
                root = [separator]
            }
            rest = bytes[stop...]
        } else {
            root = []
            rest = bytes[...]
        }

        let segments = rest
            .split(separator: separator)
            .map(ContiguousArray.init)
            .filter { $0.count != 1 || $0.first != currentDirectory }
        return (root, segments)
    }
}
