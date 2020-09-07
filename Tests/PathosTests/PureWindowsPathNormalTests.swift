import Pathos
import XCTest

final class PureWindowsPathNormalTests: XCTestCase {
    func testEmptyPathBecomesCurrentContext() {
        XCTAssertEqual(PureWindowsPath("").normal, PureWindowsPath(#"."#))
    }

    func testRoots() {
        XCTAssertEqual(PureWindowsPath(#"\"#).normal, PureWindowsPath(#"\"#))
        XCTAssertEqual(PureWindowsPath(#"\\"#).normal, PureWindowsPath(#"\"#))
        XCTAssertEqual(PureWindowsPath(#"\\\"#).normal, PureWindowsPath(#"\"#))
    }

    func testNormalization() {
        XCTAssertEqual(PureWindowsPath(#"\\\foo\.\\bar\\"#).normal, PureWindowsPath(#"\foo\bar"#))
        XCTAssertEqual(PureWindowsPath(#"\\\foo\.\\bar\\.\\..\\.\\baz"#).normal, PureWindowsPath(#"\foo\baz"#))
        XCTAssertEqual(PureWindowsPath(#"\\\..\\.\foo\.\\bar"#).normal, PureWindowsPath(#"\foo\bar"#))
    }
}
