func relativeSegments(from path: [String], to other: [String]) -> [String] {
    let commonCount = path.commonPrefix(with: other).count
    let parents = Array(repeating: "..", count: max(other.count - commonCount, 0))
    let remainingSegments = path[commonCount...]
    return parents + remainingSegments
}

extension BidirectionalCollection where Element: Equatable {
    func firstIndex(of other: Self) -> Index? {
        guard
            let start = other.first.flatMap(firstIndex(of:)),
            self[start...].count >= other.count,
            case let end = index(start, offsetBy: other.count),
            zip(self[start ..< end], other).allSatisfy(==)
        else {
            return nil
        }

        return start
    }
}
