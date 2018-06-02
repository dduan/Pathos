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
        XCTAssertFalse(Path(string: "").isAbsolute)
        XCTAssertTrue(Path(string: "/").isAbsolute)
        XCTAssertTrue(Path(string: "/foo").isAbsolute)
        XCTAssertTrue(Path(string: "/foo/bar").isAbsolute)
        XCTAssertFalse(Path(string: "foo/bar").isAbsolute)
    }
}
