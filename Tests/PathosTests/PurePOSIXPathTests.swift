import Pathos
import XCTest

final class POSIXPurePathTests: XCTestCase {
    func testNameWithASuffix() {
        XCTAssertEqual(
            PurePOSIXPath("/a/b/c.swift").name?.description,
            "c.swift"
        )
    }

    func testNameWithMultipleSuffixes() {
        XCTAssertEqual(
            PurePOSIXPath("/a/b/c.tar.gz").name?.description,
            "c.tar.gz"
        )
    }

    func testNameWithNoSuffix() {
        XCTAssertEqual(
            PurePOSIXPath("/a/b/c").name?.description,
            "c"
        )
    }

    func testNameFromPath() {
        XCTAssertEqual(
            PurePOSIXPath("/a/b/c/").name?.description,
            "c"
        )
    }

    func testNameWithOnlyRoot() {
        XCTAssertNil(PurePOSIXPath("/").name)
    }
}
