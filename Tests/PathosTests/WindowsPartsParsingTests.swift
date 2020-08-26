@testable import Pathos
import XCTest

final class WindowsPartsParsingTests: XCTestCase {
    func testRootIsParsed() {
        let p = PureWindowsPath(#"\"#)
        XCTAssertEqual(p.root, [WindowsConstants.separatorByte])
    }

    func test2SlashRoot() {
        let p = PureWindowsPath(#"\\a\b"#)
        XCTAssertEqual(p.drive, WindowsBinaryString(#"\\a\b"#))
        XCTAssert(p.root.isEmpty)
    }

    func test3SlashRoot() {
        let p = PureWindowsPath(#"\\\a\b"#)
        XCTAssertEqual(p.root, [WindowsConstants.separatorByte])
    }

    func testNoRootIsParsedCorrectly() {
        let p = PureWindowsPath(#"a\b\c"#)
        XCTAssert(p.root.isEmpty)
    }

    func testParsingDriveOnWindows() {
        let p = PureWindowsPath(#"C:\a\b"#)
        XCTAssertEqual(p.drive, WindowsBinaryString("C:"))
    }

    func testParsingDriveOnWindows2() {
        let p = PureWindowsPath(#"C:"#)
        XCTAssertEqual(p.drive, WindowsBinaryString("C:"))
    }

    func testParsingUNCDriveOnWindows() {
        let p = PureWindowsPath(#"\\drive\name\a\b"#)
        XCTAssertEqual(p.drive, WindowsBinaryString(#"\\drive\name"#))
    }

    func testParsingParts() {
        let p = PureWindowsPath(#"\a\b\c.swift"#)
        XCTAssertEqual(
            p.segments,
            Array<WindowsBinaryString>([
                .init("a"),
                .init("b"),
                .init("c.swift"),
            ])
        )
    }

    func testIntermediateCurrentDirectoryIsRemoved() {
        let p = PureWindowsPath(#"\a\b\.\c.swift"#)
        XCTAssertEqual(
            p.segments,
            Array<WindowsBinaryString>([
                .init("a"),
                .init("b"),
                .init("c.swift"),
            ])
        )
    }
}
