import Pathos
import XCTest

final class PurePOSIXPathParentsTests: XCTestCase {
    func testAbsolutePathIteratingOverParents() {
        var results = [PurePOSIXPath]()
        for path in PurePOSIXPath("/a/b/c").parents {
            results.append(path)
        }

        XCTAssertEqual(
            results,
            [
                PurePOSIXPath("/a/b"),
                PurePOSIXPath("/a"),
                PurePOSIXPath("/"),
            ]
        )
    }

    func testAbsolutePathArrayParents() {
        XCTAssertEqual(
            Array(PurePOSIXPath("/a/b/c").parents),
            [
                PurePOSIXPath("/a/b"),
                PurePOSIXPath("/a"),
                PurePOSIXPath("/"),
            ]
        )
    }

    func testRelativePathIteratingOverParents() {
        var results = [PurePOSIXPath]()
        for path in PurePOSIXPath("a/b/c").parents {
            results.append(path)
        }

        XCTAssertEqual(
            results,
            [
                PurePOSIXPath("a/b"),
                PurePOSIXPath("a"),
                PurePOSIXPath("."),
            ]
        )
    }

    func testRelativePathArrayParents() {
        XCTAssertEqual(
            Array(PurePOSIXPath("a/b/c").parents),
            [
                PurePOSIXPath("a/b"),
                PurePOSIXPath("a"),
                PurePOSIXPath("."),
            ]
        )
    }
}
