import Pathos
import XCTest


final class PathBaseNameTests: XCTestCase {
    func testBaseNameOfPath() {
        XCTAssertEqual(basename(ofPath: "/foo/bar"), "bar")
        XCTAssertEqual(basename(ofPath: "/"), "")
        XCTAssertEqual(basename(ofPath: "foo"), "foo")
        XCTAssertEqual(basename(ofPath: "////foo"), "foo")
        XCTAssertEqual(basename(ofPath: "//foo//bar"), "bar")
    }

    func testPathRepresentableBaseNameOfPath() {
        XCTAssertEqual(Path(string: "/foo/bar").basename, "bar")
        XCTAssertEqual(Path(string: "/").basename, "")
        XCTAssertEqual(Path(string: "foo").basename, "foo")
        XCTAssertEqual(Path(string: "////foo").basename, "foo")
        XCTAssertEqual(Path(string: "//foo//bar").basename, "bar")
    }
}
