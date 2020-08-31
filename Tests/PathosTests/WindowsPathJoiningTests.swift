import Pathos
import XCTest

final class WindowsPathJoiningTests: XCTestCase {
    func testSimpleJoining() {
        let a = PureWindowsPath("a")
        let b = PureWindowsPath("b")
        XCTAssertEqual(a.joined(with: b), PureWindowsPath(#"a\b"#))
    }

    func testSimpleJoiningWithMulilpePaths() {
        let a = PureWindowsPath("a")
        let b = PureWindowsPath("b")
        let c = PureWindowsPath("c")
        let d = PureWindowsPath("d")
        XCTAssertEqual(a.joined(with: b, c, d), PureWindowsPath(#"a\b\c\d"#))
    }

    func testJoiningWithExsitingSeparator() {
        let a = PureWindowsPath(#"a\"#)
        let b = PureWindowsPath("b")
        XCTAssertEqual(a.joined(with: b), PureWindowsPath(#"a\b"#))
    }

    func testSimpleJoiningStartingWithAbsolutePath() {
        let a = PureWindowsPath(#"\a"#)
        let b = PureWindowsPath("b")
        XCTAssertEqual(a.joined(with: b), PureWindowsPath(#"\a\b"#))
    }

    func testSimpleJoiningStartingWithDrive() {
        let a = PureWindowsPath(#"C:a"#)
        let b = PureWindowsPath("b")
        XCTAssertEqual(a.joined(with: b), PureWindowsPath(#"C:a\b"#))
    }

    func testSimpleJoiningStartingWithDriveAndRoot() {
        let a = PureWindowsPath(#"C:\a"#)
        let b = PureWindowsPath("b")
        XCTAssertEqual(a.joined(with: b), PureWindowsPath(#"C:\a\b"#))
    }

    func testSimpleJoiningEndingWithAbsolutePath() {
        let a = PureWindowsPath("a")
        let b = PureWindowsPath(#"\b"#)
        XCTAssertEqual(a.joined(with: b), PureWindowsPath(#"\b"#))
    }

    func testSimpleJoiningEndingWithDrive() {
        let a = PureWindowsPath("a")
        let b = PureWindowsPath(#"C:b"#)
        XCTAssertEqual(a.joined(with: b), PureWindowsPath(#"C:b"#))
    }

    func testSimpleJoiningEndingWithDriveAndRoot() {
        let a = PureWindowsPath("a")
        let b = PureWindowsPath(#"C:\b"#)
        XCTAssertEqual(a.joined(with: b), PureWindowsPath(#"C:\b"#))
    }

    func testSimpleJoiningStartingAndEndingWithRoot() {
        let a = PureWindowsPath(#"\a"#)
        let b = PureWindowsPath(#"\b"#)
        XCTAssertEqual(a.joined(with: b), PureWindowsPath(#"\b"#))
    }

    func testSimpleJoiningStartingAndEndingWithSameDrive() {
        let a = PureWindowsPath(#"C:a"#)
        let b = PureWindowsPath(#"C:b"#)
        XCTAssertEqual(a.joined(with: b), PureWindowsPath(#"C:b"#))
    }

    func testSimpleJoiningStartingAndEndingWithDifferentDrive() {
        let a = PureWindowsPath(#"\\unc\a\a"#)
        let b = PureWindowsPath(#"C:b"#)
        XCTAssertEqual(a.joined(with: b), PureWindowsPath(#"C:b"#))
    }

    func testJoiningStartingWithDriveAndEndingWithRoot() {
        let a = PureWindowsPath(#"C:a"#)
        let b = PureWindowsPath(#"\b"#)
        XCTAssertEqual(a.joined(with: b), PureWindowsPath(#"C:\b"#))
    }

    func testJoiningStartingWithRootAndEndingWithDrive() {
        let a = PureWindowsPath(#"\a"#)
        let b = PureWindowsPath(#"D:b"#)
        XCTAssertEqual(a.joined(with: b), PureWindowsPath(#"D:b"#))
    }

    func testJoiningDriveOnlyWithPath() {
        let a = PureWindowsPath(#"D:"#)
        let b = PureWindowsPath(#"b"#)
        XCTAssertEqual(a.joined(with: b), PureWindowsPath(#"D:b"#))
    }

    func testJoiningDriveOnlyWithRoot() {
        let a = PureWindowsPath(#"D:"#)
        let b = PureWindowsPath(#"\"#)
        XCTAssertEqual(a.joined(with: b), PureWindowsPath(#"D:\"#))
    }

    func testSimpleJoiningWithMultipleAbsolutePath() {
        let a = PureWindowsPath("a")
        let b = PureWindowsPath(#"\b\b"#)
        let c = PureWindowsPath(#"\\unc\c\c"#)
        let d = PureWindowsPath("d")
        XCTAssertEqual(a.joined(with: b, c, d), PureWindowsPath(#"\\unc\c\c\d"#))
    }

    func testJoiningMixedTypes() {
        let a = PureWindowsPath("a")
        let b = "b"
        let c = PureWindowsPath("c")
        let d = "d"
        XCTAssertEqual(a.joined(with: b, c, d), PureWindowsPath(#"a\b\c\d"#))
    }
}
