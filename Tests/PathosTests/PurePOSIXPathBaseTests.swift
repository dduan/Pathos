import Pathos
import XCTest

final class PurePOSIXPathBaseTests: XCTestCase {
    func testBaseDoesNotContainExtension() {
        let path = PurePOSIXPath("hello/world.md")
        let base = PurePOSIXPath("hello/world")
        XCTAssertEqual(path.base, base)
    }

    func testBaseOfPathWithoutExtensionIsItself() {
        let path = PurePOSIXPath("hello/world")
        XCTAssertEqual(path.base, path)
    }
}
