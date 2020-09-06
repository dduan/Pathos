import Pathos
import XCTest

final class PathExistsTests: XCTestCase {
    func testPathExists() {
        XCTAssert(Path(".").exists())
    }

    func testPathDoesNotExists() {
        XCTAssertFalse(Path("/Path/Does/not/exist/ha/unless/question/mark").exists())
    }
}
