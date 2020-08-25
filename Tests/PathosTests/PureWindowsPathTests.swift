import Pathos
import XCTest

final class WindowsPurePathTests: XCTestCase {
    func testNameWithASuffix() {
        XCTAssertEqual(
            PureWindowsPath(#"C:\a\b\c.swift"#).name?.string,
            "c.swift"
        )

        XCTAssertEqual(
            PureWindowsPath(#"\a\b\c.swift"#).name?.string,
            "c.swift"
        )
    }

    func testNameWithMultipleSuffixes() {
        XCTAssertEqual(
            PureWindowsPath(#"C:\a\b\c.tar.gz"#).name?.string,
            "c.tar.gz"
        )

        XCTAssertEqual(
            PureWindowsPath(#"\a\b\c.tar.gz"#).name?.string,
            "c.tar.gz"
        )
    }

    func testNameWithNoSuffix() {
        XCTAssertEqual(
            PureWindowsPath(#"C:\a\b\c"#).name?.string,
            "c"
        )

        XCTAssertEqual(
            PureWindowsPath(#"\a\b\c"#).name?.string,
            "c"
        )
    }

    func testNameFromPath() {
        XCTAssertEqual(
            PureWindowsPath(#"C:\a\b\c\"#).name?.string,
            "c"
        )

        XCTAssertEqual(
            PureWindowsPath(#"\a\b\c\"#).name?.string,
            "c"
        )
    }

    func testNameWithOnlyDriveAndRoot() {
        XCTAssertNil(PureWindowsPath(#"C:\"#).name)
    }

    func testNameWithOnlyRoot() {
        XCTAssertNil(PureWindowsPath(#"\"#).name)
    }
}
