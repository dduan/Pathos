func _stripFromRight(_ path: String, _ c: Character) -> String {
    let reversed = path.reversed()
    return reversed
        .firstIndex { $0 != c }
        .map { reversed.suffix(from: $0) }
        .map { $0.reversed() }
        .map(String.init)
        ?? ""
}

extension BidirectionalCollection where Element: Equatable {
    func firstIndex(of other: Self) -> Index? {
        guard
            let start = other.first.flatMap(self.firstIndex(of:)),
            self[start...].count >= other.count,
            case let end = self.index(start, offsetBy: other.count),
            zip(self[start ..< end], other).allSatisfy(==)
        else
        {
            return nil
        }

        return start
    }
}
