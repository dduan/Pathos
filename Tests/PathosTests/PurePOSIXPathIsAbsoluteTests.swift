import Pathos
import XCTest

final class PurePOSIXPathIsAbsoluteTests: XCTestCase {
    func testNoRootNoDriveIsNotAbsolute() {
        XCTAssertFalse(PurePOSIXPath(#"a/b"#).isAbsolute)
    }

    func testNoDriveIsAbsolute() {
        XCTAssert(PurePOSIXPath("/a/b").isAbsolute)
    }
}
