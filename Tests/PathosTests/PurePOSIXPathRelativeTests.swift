import Pathos
import XCTest

final class PurePOSIXPathRelativeTests: XCTestCase {
    func testBasicRelativity() {
        XCTAssertEqual(
            PurePOSIXPath("/").relative(to: "/home/dan"),
            PurePOSIXPath("../..")
        )
    }

    func testRelativeToSelf() {
        XCTAssertEqual(
            PurePOSIXPath("a").relative(to: "a"),
            PurePOSIXPath(".")
        )
    }

    func testAbsoluteSibling() {
        XCTAssertEqual(
            PurePOSIXPath("/a/b").relative(to: "/x/y"),
            PurePOSIXPath("../../a/b")
        )
    }

    func testAbsoluteChild() {
        XCTAssertEqual(
            PurePOSIXPath("/a/b/c").relative(to: "/a/b"),
            PurePOSIXPath("c")
        )

        XCTAssertEqual(
            PurePOSIXPath("/a/b/c").relative(to: "/"),
            PurePOSIXPath("a/b/c")
        )
    }

    func testAbsoluteParent() {
        XCTAssertEqual(
            PurePOSIXPath("/").relative(to: "/a/b/c"),
            PurePOSIXPath("../../..")
        )
    }

    func testAbsoluteRoot() {
        XCTAssertEqual(
            PurePOSIXPath("/").relative(to: "/"),
            PurePOSIXPath(".")
        )
    }
}
