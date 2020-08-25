import Pathos
import XCTest

final class POSIXPurePathTests: XCTestCase {
    func testNameWithASuffix() {
        XCTAssertEqual(
            PurePOSIXPath("/a/b/c.swift").name?.string,
            "c.swift"
        )
    }

    func testNameWithMultipleSuffixes() {
        XCTAssertEqual(
            PurePOSIXPath("/a/b/c.tar.gz").name?.string,
            "c.tar.gz"
        )
    }

    func testNameWithNoSuffix() {
        XCTAssertEqual(
            PurePOSIXPath("/a/b/c").name?.string,
            "c"
        )
    }

    func testNameFromPath() {
        XCTAssertEqual(
            PurePOSIXPath("/a/b/c/").name?.string,
            "c"
        )
    }

    func testNameWithOnlyRoot() {
        XCTAssertNil(PurePOSIXPath("/").name)
    }
}
