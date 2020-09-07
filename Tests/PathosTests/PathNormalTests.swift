import Pathos
import XCTest

final class PathNormalTests: XCTestCase {
    func testEmptyPathBecomesCurrent() {
        XCTAssertEqual(Path("").normal, Path("."))
    }
}
