extension Path.Parts {
    init(forPOSIXWithBinary binary: POSIXBinaryString) {
        drive = nil

        (root, segments) = Self.parse(
            binary.withUnsafeBytes { $0 },
            as: UTF8.self,
            separator: UTF8.CodeUnit(POSIXConstants.binaryPathSeparator),
            currentContext: UTF8.CodeUnit(POSIXConstants.binaryCurrentContext)
        )
    }
}
