import Pathos
import XCTest

final class PathDirectoryTests: XCTestCase {
    func testPathDirectory() {
        XCTAssertEqual(directory(ofPath: "/foo/bar"), "/foo")
        XCTAssertEqual(directory(ofPath: "/"), "/")
        XCTAssertEqual(directory(ofPath: "foo"), "")
        XCTAssertEqual(directory(ofPath: "////foo"), "////")
        XCTAssertEqual(directory(ofPath: "//foo//bar"), "//foo")
    }

    func testPathRepresentableDirectory() {
        XCTAssertEqual(Path("/foo/bar").directory, "/foo")
        XCTAssertEqual(Path("/").directory, "/")
        XCTAssertEqual(Path("foo").directory, "")
        XCTAssertEqual(Path("////foo").directory, "////")
        XCTAssertEqual(Path("//foo//bar").directory, "//foo")
    }
}
