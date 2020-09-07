import Pathos
import XCTest

final class AbsoluteTests: XCTestCase {
    func testMakingPathAbsolute() throws {
        XCTAssert(try Path("a").absolute().isAbsolute)
    }
}
