extension Box where Content == Optional<PathParts<WindowsEncodingUnit>> {
    func getOrCreateParts(_ binary: WindowsBinaryString) -> PathParts<WindowsEncodingUnit> {
        let parts: PathParts<WindowsEncodingUnit>

        if let cachedParts = content {
            parts = cachedParts
        } else {
            parts = PathParts(forWindowsWithBinary: binary)
            content = parts
        }

        return parts
    }
}
