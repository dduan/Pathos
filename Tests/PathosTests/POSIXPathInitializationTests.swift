@testable import Pathos
import XCTest

final class POSIXPathInitializationTests: XCTestCase {
    func testInitializingFromCString() {
        let expectedPath = "/a/b/c"
        XCTAssertEqual(
            PurePOSIXPath(cString: expectedPath).binaryPath.content[...],
            expectedPath.utf8CString.dropLast()
        )
    }

    func testInitializationFromString() {
        let expectedPath = "/a/b/c"
        XCTAssertEqual(
            PurePOSIXPath(expectedPath).binaryPath.content[...],
            expectedPath.utf8CString.dropLast()
        )
    }
}
