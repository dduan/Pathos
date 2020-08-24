import Pathos
import XCTest

final class POSIXPathInitializationTests: XCTestCase {
    func testInitializingFromCString() {
        let expectedPath = "/a/b/c"
        XCTAssertEqual(
            PurePOSIXPath(cString: expectedPath).binaryString[...],
            expectedPath.utf8CString.dropLast()
        )
    }

    func testInitializationFromString() {
        let expectedPath = "/a/b/c"
        XCTAssertEqual(
            PurePOSIXPath(expectedPath).binaryString[...],
            expectedPath.utf8CString.dropLast()
        )
    }
}
