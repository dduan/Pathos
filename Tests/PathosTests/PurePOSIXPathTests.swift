import Pathos
import XCTest

final class POSIXPurePathTests: XCTestCase {
    func testNameWithASuffix() {
        XCTAssertEqual(
            PurePOSIXPath("/a/b/c.swift").name,
            "c.swift"
        )
    }

    func testNameWithMultipleSuffixes() {
        XCTAssertEqual(
            PurePOSIXPath("/a/b/c.tar.gz").name,
            "c.tar.gz"
        )
    }

    func testNameWithNoSuffix() {
        XCTAssertEqual(
            PurePOSIXPath("/a/b/c").name,
            "c"
        )
    }

    func testNameFromPath() {
        XCTAssertEqual(
            PurePOSIXPath("/a/b/c/").name,
            "c"
        )
    }

    func testNameWithOnlyRoot() {
        XCTAssertNil(PurePOSIXPath("/").name)
    }
}
