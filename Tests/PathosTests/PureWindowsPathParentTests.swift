import Pathos
import XCTest

final class PureWindowsParentTests: XCTestCase {
    func testNormalRelativeParent() {
        XCTAssertEqual(PureWindowsPath(#"a\b\c"#).parent, PureWindowsPath(#"a\b"#))
    }

    func testNormalAbsoluteParent() {
        XCTAssertEqual(PureWindowsPath(#"C:\a\b\c"#).parent, PureWindowsPath(#"C:\a\b"#))
    }

    func testNormalParentWithRoot() {
        XCTAssertEqual(PureWindowsPath(#"\a\b\c"#).parent, PureWindowsPath(#"\a\b"#))
    }

    func testParentBeingRoot() {
        XCTAssertEqual(PureWindowsPath(#"\a"#).parent, PureWindowsPath(#"\"#))
    }

    func testParentBeingDrive() {
        XCTAssertEqual(PureWindowsPath(#"C:a"#).parent, PureWindowsPath(#"C:"#))
    }

    func testParentBeingAnchor() {
        XCTAssertEqual(PureWindowsPath(#"C:\a"#).parent, PureWindowsPath(#"C:\"#))
    }

    func testRoot() {
        XCTAssertEqual(PureWindowsPath(#"\"#).parent, PureWindowsPath(#"\"#))
    }

    func testDrive() {
        XCTAssertEqual(PureWindowsPath(#"C:"#).parent, PureWindowsPath(#"C:"#))
    }

    func testAnchor() {
        XCTAssertEqual(PureWindowsPath(#"C:\"#).parent, PureWindowsPath(#"C:\"#))
    }

    func testNoMoreParent() {
        XCTAssertEqual(PureWindowsPath(#"a"#).parent, PureWindowsPath(#"."#))
    }

    func testCurrentContextParent() {
        XCTAssertEqual(PureWindowsPath(#"."#).parent, PureWindowsPath(#"."#))
    }
}
