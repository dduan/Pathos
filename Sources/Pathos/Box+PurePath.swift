extension Box where Content == Optional<PathParts> {
    func getOrCreateParts(from bytes: Bytes, isWindows: Bool) -> PathParts {
        let parts: PathParts

        if let cachedParts = content {
            parts = cachedParts
        } else {
            parts = PathParts(bytes: bytes, isWindows: isWindows)
            content = parts
        }

        return parts
    }
}
