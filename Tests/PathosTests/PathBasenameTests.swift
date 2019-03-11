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
        XCTAssertEqual(Path("/foo/bar").basename, "bar")
        XCTAssertEqual(Path("/").basename, "")
        XCTAssertEqual(Path("foo").basename, "foo")
        XCTAssertEqual(Path("////foo").basename, "foo")
        XCTAssertEqual(Path("//foo//bar").basename, "bar")
    }
}
