import Pathos
import XCTest

final class ChildrenTests: XCTestCase {
    func testChildrenOfCurrentDirectory() {
        XCTAssertNoThrow(try Path(".").children())
    }

    func testChildrenOfCurrentDirectoryRecursive() {
        XCTAssertNoThrow(try Path(".").children(recursive: true))
    }
}
