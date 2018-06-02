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
        XCTAssertEqual(Path(string: "/foo/bar").directory, "/foo")
        XCTAssertEqual(Path(string: "/").directory, "/")
        XCTAssertEqual(Path(string: "foo").directory, "")
        XCTAssertEqual(Path(string: "////foo").directory, "////")
        XCTAssertEqual(Path(string: "//foo//bar").directory, "//foo")
    }
}
