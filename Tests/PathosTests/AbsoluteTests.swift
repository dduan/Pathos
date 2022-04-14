import Pathos
import XCTest

final class AbsoluteTests: XCTestCase {
    func testMakingPathAbsolute() throws {
        print(">> \(#line)")
        XCTAssert(try Path("a").absolute().isAbsolute)
        print(">> \(#line)")
    }
}
