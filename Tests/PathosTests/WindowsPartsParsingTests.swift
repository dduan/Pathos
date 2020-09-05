@testable import Pathos
import XCTest

final class WindowsPartsParsingTests: XCTestCase {
    func testRootIsParsed() {
        let p = PureWindowsPath(#"\"#)
        XCTAssertEqual(p.root, #"\"#)
    }

    func test2SlashRoot() {
        let p = PureWindowsPath(#"\\a\b"#)
        XCTAssertEqual(p.drive, #"\\a\b"#)
        XCTAssertNil(p.root)
    }

    func test3SlashRoot() {
        let p = PureWindowsPath(#"\\\a\b"#)
        XCTAssertEqual(p.root, #"\"#)
    }

    func testNoRootIsParsedCorrectly() {
        let p = PureWindowsPath(#"a\b\c"#)
        XCTAssertNil(p.root)
    }

    func testParsingDriveOnWindows() {
        let p = PureWindowsPath(#"C:\a\b"#)
        XCTAssertEqual(p.drive, "C:")
    }

    func testParsingDriveOnWindows2() {
        let p = PureWindowsPath(#"C:"#)
        XCTAssertEqual(p.drive, "C:")
    }

    func testParsingUNCDriveOnWindows() {
        let p = PureWindowsPath(#"\\drive\name\a\b"#)
        XCTAssertEqual(p.drive, #"\\drive\name"#)
    }

    func testParsingParts() {
        let p = PureWindowsPath(#"\a\b\c.swift"#)
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
        let p = PureWindowsPath(#"\a\b\.\c.swift"#)
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
