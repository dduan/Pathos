import Pathos
import XCTest

final class PathTests: XCTestCase {
    func testPathValueDoesNotChange() {
        let pathString = "abc"
        let path = Path(string: pathString)
        XCTAssertEqual(path.pathString, pathString)
    }
}
