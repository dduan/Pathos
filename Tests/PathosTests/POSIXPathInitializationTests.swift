import Pathos
import XCTest

final class POSIXPathInitializationTests: XCTestCase {
    func testInitializingFromCString() {
        let expectedPath = "/a/b/c"
        XCTAssertEqual(
            PurePOSIXPath(cString: expectedPath).bytes[...],
            expectedPath.utf8CString.dropLast()
        )
    }

    func testInitializationFromString() {
        let expectedPath = "/a/b/c"
        XCTAssertEqual(
            PurePOSIXPath(expectedPath).bytes[...],
            expectedPath.utf8CString.dropLast()
        )
    }
}
