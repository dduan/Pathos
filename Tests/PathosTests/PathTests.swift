import Pathos
import XCTest

final class PathTests: XCTestCase {
    func testPathValueDoesNotChange() {
        let pathString = "abc"
        let path = Path(pathString)
        XCTAssertEqual(path.pathString, pathString)
    }
}
