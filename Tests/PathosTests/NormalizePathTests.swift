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
        XCTAssertEqual(Path(string: "").normalize().pathString, ".")
    }

    func testPathRepresentableSlashPrefixes() {
        XCTAssertEqual(Path(string: "/").normalize().pathString, "/")
        XCTAssertEqual(Path(string: "//").normalize().pathString, "//")
        XCTAssertEqual(Path(string: "///").normalize().pathString, "/")
    }

    func testPathRepresentableCanonicalizePath() {
        XCTAssertEqual(Path(string: "///foo/.//bar//").normalize().pathString, "/foo/bar")
        XCTAssertEqual(Path(string: "///foo/.//bar//.//..//.//baz").normalize().pathString, "/foo/baz")
        XCTAssertEqual(Path(string: "///..//./foo/.//bar").normalize().pathString, "/foo/bar")
    }
}
