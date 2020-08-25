extension Box where Content == Optional<PathParts<POSIXEncodingUnit>> {
    func getOrCreateParts(_ binary: POSIXBinaryString) -> PathParts<POSIXEncodingUnit> {
        let parts: PathParts<POSIXEncodingUnit>

        if let cachedParts = content {
            parts = cachedParts
        } else {
            parts = PathParts(forPOSIXWithBinary: binary)
            content = parts
        }

        return parts
    }
}
