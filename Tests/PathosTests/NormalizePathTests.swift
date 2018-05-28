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
        XCTAssertEqual(Path(path: "").normalize().pathString, ".")
    }

    func testPathRepresentableSlashPrefixes() {
        XCTAssertEqual(Path(path: "/").normalize().pathString, "/")
        XCTAssertEqual(Path(path: "//").normalize().pathString, "//")
        XCTAssertEqual(Path(path: "///").normalize().pathString, "/")
    }

    func testPathRepresentableConanicalizePath() {
        XCTAssertEqual(Path(path: "///foo/.//bar//").normalize().pathString, "/foo/bar")
        XCTAssertEqual(Path(path: "///foo/.//bar//.//..//.//baz").normalize().pathString, "/foo/baz")
        XCTAssertEqual(Path(path: "///..//./foo/.//bar").normalize().pathString, "/foo/bar")
    }
}
