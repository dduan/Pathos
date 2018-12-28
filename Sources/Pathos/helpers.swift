func _stripFromRight(_ path: String, _ c: Character) -> String {
    let reversed = path.reversed()
    return reversed
        .firstIndex { $0 != c }
        .map { reversed.suffix(from: $0) }
        .map { $0.reversed() }
        .map(String.init)
        ?? ""
}

extension BidirectionalCollection where SubSequence: Equatable, Element: Equatable {
    func firstIndex(of other: Self) -> Index? {
        guard let start = other.first.flatMap(self.firstIndex(of:)),
            self[start...].count >= other.count else
        {
            return nil
        }

        let end = self.index(start, offsetBy: other.count)
        if self[start ..< end] == other[...] {
            return start
        }

        return nil
    }
}
