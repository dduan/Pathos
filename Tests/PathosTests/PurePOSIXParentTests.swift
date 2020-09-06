import Pathos
import XCTest

final class PurePOSIXParentTests: XCTestCase {
    func testNormalRelativeParent() {
        XCTAssertEqual(PurePOSIXPath("a/b/c").parent, PurePOSIXPath("a/b"))
    }

    func testNormalAbsoluteParent() {
        XCTAssertEqual(PurePOSIXPath("/a/b/c").parent, PurePOSIXPath("/a/b"))
    }

    func testParentBeingRoot() {
        XCTAssertEqual(PurePOSIXPath("/a").parent, PurePOSIXPath("/"))
    }

    func testRoot() {
        XCTAssertEqual(PurePOSIXPath("/").parent, PurePOSIXPath("/"))
    }

    func testNoMoreParent() {
        XCTAssertEqual(PurePOSIXPath("a").parent, PurePOSIXPath("."))
    }

    func testCurrentContextParent() {
        XCTAssertEqual(PurePOSIXPath(".").parent, PurePOSIXPath("."))
    }
}
