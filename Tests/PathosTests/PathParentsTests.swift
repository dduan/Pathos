import Pathos
import XCTest

final class PathParentsTests: XCTestCase {
    func testRelativePathIteratingOverParents() {
        var results = [Path]()
        let seq = Path("a").joined(with: "b", "c").parents
        for path in seq {
            results.append(path)
        }

        XCTAssertEqual(
            results,
            [
                Path("a").joined(with: "b"),
                Path("a"),
                Path("."),
            ]
        )
    }

    func testRelativePathArrayParents() {
        XCTAssertEqual(
            Array(Path("a").joined(with: "b", "c").parents),
            [
                Path("a").joined(with: "b"),
                Path("a"),
                Path("."),
            ]
        )
    }

    func testAbsolutePathArrayParents() {
        let root = Path("\(Constants.pathSeparator)")
        XCTAssertEqual(
            Array((root + "a" + "b" + "c").parents),
            [
                root + "a" + "b",
                root + "a",
                root,
            ]
        )
    }
}
