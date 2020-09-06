func relativeSegments(from path: [String], to other: [String]) -> [String] {
    let commonCount = path.commonPrefix(with: other).count
    let parents = Array(repeating: "..", count: max(other.count - commonCount, 0))
    let remainingSegments = path[commonCount...]
    return parents + remainingSegments
}
