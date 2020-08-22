import Pathos
import XCTest

final class WindowsPartsParsingTests: XCTestCase {
    func testRootIsParsed() {
        let p = PureWindowsPath(cString: #"\"#)
        XCTAssertEqual(p.root, [WindowsConstants.separatorByte])
    }

    func test2SlashRoot() {
        let p = PureWindowsPath(#"\\a\b"#)
        XCTAssertEqual(p.drive, Bytes(#"\\a\b"#.utf8CString.dropLast()))
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
        XCTAssertEqual(p.drive, Bytes("C:".utf8CString.dropLast()))
    }

    func testParsingDriveOnWindows2() {
        let p = PureWindowsPath(#"C:"#)
        XCTAssertEqual(p.drive, Bytes("C:".utf8CString.dropLast()))
    }

    func testParsingParts() {
        let p = PureWindowsPath(#"\a\b\c.swift"#)
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
        let p = PureWindowsPath(#"\a\b\.\c.swift"#)
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
