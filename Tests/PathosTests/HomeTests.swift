import Pathos
import XCTest

final class HomeTests: XCTestCase {
    func testGettingHome() {
        XCTAssert(!Path.home().isEmpty)
    }
}
