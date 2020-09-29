import Pathos
import XCTest

final class PathNormalTests: XCTestCase {
    func testEmptyPathBecomesCurrent() {
        XCTAssertEqual(Path("").normal, Path("."))
    }

    func testParentDirectoryGetsRemoved() {
        XCTAssertEqual((Path("a") + "b" + ".." + "c").normal, Path("a") + "c")
    }
}
