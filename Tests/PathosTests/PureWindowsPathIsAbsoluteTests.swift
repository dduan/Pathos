import Pathos
import XCTest

final class PureWindowsPathIsAbsoluteTests: XCTestCase {
    func testNoRootNoDriveIsNotAbsolute() {
        XCTAssertFalse(PureWindowsPath(#"a\b"#).isAbsolute)
    }

    func testNoDriveIsNotAbsolute() {
        XCTAssertFalse(PureWindowsPath(#"\a\b"#).isAbsolute)
    }

    func testNoRootIsNotAbsolute() {
        XCTAssertFalse(PureWindowsPath(#"C:a\b"#).isAbsolute)
    }

    func testIsAbsolute() {
        XCTAssert(PureWindowsPath(#"C:\a\b"#).isAbsolute)
    }
}
