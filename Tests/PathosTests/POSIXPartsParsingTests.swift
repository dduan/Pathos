import Pathos
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
            Array<Bytes>([
                .init("a".utf8CString.dropLast()),
                .init("b".utf8CString.dropLast()),
                .init("c.swift".utf8CString.dropLast()),
            ])
        )
    }

    func testIntermediateCurrentDirectoryIsRemoved() {
        let p = PurePOSIXPath("/a/b/./c.swift")
        XCTAssertEqual(
            p.segments,
            Array<Bytes>([
                .init("a".utf8CString.dropLast()),
                .init("b".utf8CString.dropLast()),
                .init("c.swift".utf8CString.dropLast()),
            ])
        )
    }
}
