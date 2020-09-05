@testable import Pathos
import XCTest

final class PureWindowsPathJoiningOperatorTests: XCTestCase {
    func testAddingPureWindowsPath() {
        let result = PureWindowsPath(#"\"#) + PureWindowsPath("a") + PureWindowsPath("b")
        XCTAssertEqual(result, PureWindowsPath(#"\a\b"#))
    }

    func testAddingPureWindowsPathAndString() {
        let result = PureWindowsPath(#"\a"#) + "b"
        XCTAssertEqual(result, PureWindowsPath(#"\a\b"#))
    }

    func testAddingStringAndPureWindowsPath() {
        let result = #"\a"# + PureWindowsPath("b")
        XCTAssertEqual(result, PureWindowsPath(#"\a\b"#))
    }

    func testAddingPureWindowsPathAndWindowsBinaryString() {
        let result = PureWindowsPath(#"\a"#) + WindowsBinaryString("b")
        XCTAssertEqual(result, PureWindowsPath(#"\a\b"#))
    }

    func testAddingWindowsBinaryStringAndPurePath() {
        let result = WindowsBinaryString(#"\"#) + PureWindowsPath(#"a\b"#)
        XCTAssertEqual(result, PureWindowsPath(#"\a\b"#))
    }
}
