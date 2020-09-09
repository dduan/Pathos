@testable import Pathos
import XCTest

final class POSIXPathInitializationTests: XCTestCase {
    func testInitializingFromCString() {
        let expectedPath = "/a/b/c"
        XCTAssertEqual(
            PurePOSIXPath(cString: expectedPath).binaryString.content[...],
            expectedPath.utf8CString.dropLast()
        )
    }

    func testInitializationFromString() {
        let expectedPath = "/a/b/c"
        XCTAssertEqual(
            PurePOSIXPath(expectedPath).binaryString.content[...],
            expectedPath.utf8CString.dropLast()
        )
    }
}
