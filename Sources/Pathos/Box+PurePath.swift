extension Box where Content == Optional<PathParts> {
    func getOrCreateParts(from bytes: Bytes) -> PathParts {
        let parts: PathParts

        if let cachedParts = content {
            parts = cachedParts
        } else {
            parts = PathParts(bytes: bytes)
            content = parts
        }

        return parts
    }
}
