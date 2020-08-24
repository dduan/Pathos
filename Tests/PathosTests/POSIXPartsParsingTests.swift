@testable import Pathos
import XCTest

final class POSIXPartsParsingTests: XCTestCase {
    func testRootIsParsed() {
        let p = PurePOSIXPath(cString: "/")
        XCTAssertEqual(p.root, [POSIXConstants.separatorByte])
    }

    func test2SlashRoot() {
        let p = PurePOSIXPath("//a/b")
        XCTAssertEqual(p.root, [POSIXConstants.separatorByte, POSIXConstants.separatorByte])
    }

    func test3SlashRoot() {
        let p = PurePOSIXPath("///a/b")
        XCTAssertEqual(p.root, [POSIXConstants.separatorByte])
    }

    func testNoRootIsParsedCorrectly() {
        let p = PurePOSIXPath("a/b/c")
        XCTAssert(p.root.isEmpty)
    }

    func testParsingDriveOnPOSIX() {
        let p = PurePOSIXPath("C:/a/b")
        XCTAssert(p.drive.isEmpty)
    }

    func testParsingParts() {
        let p = PurePOSIXPath("/a/b/c.swift")
        XCTAssertEqual(
            p.segments,
            Array<POSIXBinaryString>([
                .init("a"),
                .init("b"),
                .init("c.swift"),
            ])
        )
    }

    func testIntermediateCurrentDirectoryIsRemoved() {
        let p = PurePOSIXPath("/a/b/./c.swift")
        XCTAssertEqual(
            p.segments,
            Array<POSIXBinaryString>([
                .init("a"),
                .init("b"),
                .init("c.swift"),
            ])
        )
    }
}
