extension Box where Content == Optional<PathParts<WindowsEncodingUnit>> {
    func getOrCreateParts(forWindowsFrom bytes: WindowsBinaryString) -> PathParts<WindowsEncodingUnit> {
        let parts: PathParts<WindowsEncodingUnit>

        if let cachedParts = content {
            parts = cachedParts
        } else {
            parts = PathParts(forWindowsWithBytes: bytes)
            content = parts
        }

        return parts
    }
}

extension Box where Content == Optional<PathParts<POSIXEncodingUnit>> {
    func getOrCreateParts(forPOSIXFrom bytes: POSIXBinaryString) -> PathParts<POSIXEncodingUnit> {
        let parts: PathParts<POSIXEncodingUnit>

        if let cachedParts = content {
            parts = cachedParts
        } else {
            parts = PathParts(forPOSIXWithBytes: bytes)
            content = parts
        }

        return parts
    }
}
