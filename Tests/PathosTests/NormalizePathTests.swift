import Pathos
import XCTest

final class NormalizePathTests: XCTestCase {
    func testAssertEmptyPathBecomesCurrent() {
        XCTAssertEqual(normalize(path: ""), ".")
    }

    func testSlashPrefixes() {
        XCTAssertEqual(normalize(path: "/"), "/")
        XCTAssertEqual(normalize(path: "//"), "//")
        XCTAssertEqual(normalize(path: "///"), "/")
    }

    func testCanonicalizePath() {
        XCTAssertEqual(normalize(path: "///foo/.//bar//"), "/foo/bar")
        XCTAssertEqual(normalize(path: "///foo/.//bar//.//..//.//baz"), "/foo/baz")
        XCTAssertEqual(normalize(path: "///..//./foo/.//bar"), "/foo/bar")
    }

    func testPathRepresentableEmptyPathBecomesCurrent() {
        XCTAssertEqual(Path("").normalize().pathString, ".")
    }

    func testPathRepresentableSlashPrefixes() {
        XCTAssertEqual(Path("/").normalize().pathString, "/")
        XCTAssertEqual(Path("//").normalize().pathString, "//")
        XCTAssertEqual(Path("///").normalize().pathString, "/")
    }

    func testPathRepresentableCanonicalizePath() {
        XCTAssertEqual(Path("///foo/.//bar//").normalize().pathString, "/foo/bar")
        XCTAssertEqual(Path("///foo/.//bar//.//..//.//baz").normalize().pathString, "/foo/baz")
        XCTAssertEqual(Path("///..//./foo/.//bar").normalize().pathString, "/foo/bar")
    }
}
