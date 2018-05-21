func _stripFromRight(_ path: String, _ c: Character) -> String {
    let reversed = path.reversed()
    return reversed
        .firstIndex { $0 != kSeparatorCharacter }
        .map { reversed.suffix(from: $0) }
        .map { $0.reversed() }
        .map(String.init)
        ?? ""
}
