import Pathos
import XCTest

final class IsAbsoluteTests: XCTestCase {
    func testIsAbsolutePath() {
        XCTAssertFalse(isAbsolute(path: ""))
        XCTAssertTrue(isAbsolute(path: "/"))
        XCTAssertTrue(isAbsolute(path: "/foo"))
        XCTAssertTrue(isAbsolute(path: "/foo/bar"))
        XCTAssertFalse(isAbsolute(path: "foo/bar"))
    }

    func testPathRepresentableIsAbsolute() {
        XCTAssertFalse(Path("").isAbsolute)
        XCTAssertTrue(Path("/").isAbsolute)
        XCTAssertTrue(Path("/foo").isAbsolute)
        XCTAssertTrue(Path("/foo/bar").isAbsolute)
        XCTAssertFalse(Path("foo/bar").isAbsolute)
    }
}
