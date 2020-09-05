@testable import Pathos
import XCTest

final class PurePOSIXPathJoiningOperatorTests: XCTestCase {
    func testAddingPurePOSIXPaths() {
        let result = PurePOSIXPath("/") + PurePOSIXPath("a") + PurePOSIXPath("b")
        XCTAssertEqual(result, PurePOSIXPath("/a/b"))
    }

    func testAddingPurePOSIXPathAndString() {
        let result = PurePOSIXPath("/a") + "b"
        XCTAssertEqual(result, PurePOSIXPath("/a/b"))
    }

    func testAddingStringAndPurePOSIXPath() {
        let result = "/a" + PurePOSIXPath("b")
        XCTAssertEqual(result, PurePOSIXPath("/a/b"))
    }

    func testAddingPurePOSIXPathAndPOSIXBinaryString() {
        let result = PurePOSIXPath("/a") + POSIXBinaryString("b")
        XCTAssertEqual(result, PurePOSIXPath("/a/b"))
    }

    func testAddingPOSIXBinaryStringAndPurePath() {
        let result = POSIXBinaryString("/") + PurePOSIXPath("a/b")
        XCTAssertEqual(result, PurePOSIXPath("/a/b"))
    }
}
