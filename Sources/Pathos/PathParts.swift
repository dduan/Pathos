struct PathParts {
    let drive: Bytes
    let root: Bytes
    let segments: Array<Bytes>

    init(bytes: Bytes) {
        // TODO: implement drive spliting logic
        drive = []

        let rest: Bytes.SubSequence
        if !bytes.isEmpty && bytes[0] == Constants.separatorByte {
            let stop = bytes.firstIndex(where: { $0 != Constants.separatorByte }) ?? 0
            if stop == 2 {
                root = [Constants.separatorByte, Constants.separatorByte]
            } else {
                root = [Constants.separatorByte]
            }
            rest = bytes[stop...]
        } else {
            root = []
            rest = bytes[...]
        }

        segments = rest
            .split(separator: Constants.separatorByte)
            .map(ContiguousArray.init)
            .filter { $0.count != 1 || $0.first != Constants.currentDirectoryByte }
    }
}
