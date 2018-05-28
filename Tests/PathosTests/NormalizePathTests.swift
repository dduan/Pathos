import Pathos
import XCTest

final class NormalizePathTests: XCTestCase {
    func testAssertEmptyPathBecomesCurrent() {
        XCTAssertEqual(normalizePath(""), ".")
    }

    func testSlashPrefixes() {
        XCTAssertEqual(normalizePath("/"), "/")
        XCTAssertEqual(normalizePath("//"), "//")
        XCTAssertEqual(normalizePath("///"), "/")
    }

    func testConanicalizePath() {
        XCTAssertEqual(normalizePath("///foo/.//bar//"), "/foo/bar")
        XCTAssertEqual(normalizePath("///foo/.//bar//.//..//.//baz"), "/foo/baz")
        XCTAssertEqual(normalizePath("///..//./foo/.//bar"), "/foo/bar")
    }

    func testPathRepresentableEmptyPathBecomesCurrent() {
        XCTAssertEqual(Path(string: "").normalize().pathString, ".")
    }

    func testPathRepresentableSlashPrefixes() {
        XCTAssertEqual(Path(string: "/").normalize().pathString, "/")
        XCTAssertEqual(Path(string: "//").normalize().pathString, "//")
        XCTAssertEqual(Path(string: "///").normalize().pathString, "/")
    }

    func testPathRepresentableConanicalizePath() {
        XCTAssertEqual(Path(string: "///foo/.//bar//").normalize().pathString, "/foo/bar")
        XCTAssertEqual(Path(string: "///foo/.//bar//.//..//.//baz").normalize().pathString, "/foo/baz")
        XCTAssertEqual(Path(string: "///..//./foo/.//bar").normalize().pathString, "/foo/bar")
    }
}
