@testable import Pathos
import XCTest

final class POSIXPartsParsingTests: XCTestCase {
    func testRootIsParsed() {
        let p = PurePOSIXPath(cString: "/")
        XCTAssertEqual(p.root, "/")
    }

    func test2SlashRoot() {
        let p = PurePOSIXPath("//a/b")
        XCTAssertEqual(p.root, "//")
    }

    func test3SlashRoot() {
        let p = PurePOSIXPath("///a/b")
        XCTAssertEqual(p.root, "/")
    }

    func testNoRootIsParsedCorrectly() {
        let p = PurePOSIXPath("a/b/c")
        XCTAssertNil(p.root)
    }

    func testParsingDriveOnPOSIX() {
        let p = PurePOSIXPath("C:/a/b")
        XCTAssertNil(p.drive)
    }

    func testParsingParts() {
        let p = PurePOSIXPath("/a/b/c.swift")
        XCTAssertEqual(
            p.segments,
            [
                "a",
                "b",
                "c.swift",
            ]
        )
    }

    func testIntermediateCurrentDirectoryIsRemoved() {
        let p = PurePOSIXPath("/a/b/./c.swift")
        XCTAssertEqual(
            p.segments,
            [
                "a",
                "b",
                "c.swift",
            ]
        )
    }
}
