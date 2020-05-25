import Pathos
import XCTest

final class NormalizePathTests: XCTestCase {
    func testAssertEmptyPathBecomesCurrent() {
        XCTAssertEqual(normalize(path: ""), ".")
    }

    func testSlashPrefixes() {
#if os(Windows)
        XCTAssertEqual(normalize(path: "/"), #"\"#)
        XCTAssertEqual(normalize(path: "//"), #"\"#)
        XCTAssertEqual(normalize(path: "///"), #"\"#)
        XCTAssertEqual(normalize(path: #"\"#), #"\"#)
        XCTAssertEqual(normalize(path: #"\\"#), #"\"#)
        XCTAssertEqual(normalize(path: #"\\\"#), #"\"#)
#else
        XCTAssertEqual(normalize(path: "/"), "/")
        XCTAssertEqual(normalize(path: "//"), "//")
        XCTAssertEqual(normalize(path: "///"), "/")
#endif
    }

    func testCanonicalizePath() {
#if os(Windows)
        XCTAssertEqual(normalize(path: "///foo/.//bar//"), #"\foo\bar"#)
        XCTAssertEqual(normalize(path: "///foo/.//bar//.//..//.//baz"), #"\foo\baz"#)
        XCTAssertEqual(normalize(path: "///..//./foo/.//bar"), #"\foo\bar"#)
        XCTAssertEqual(normalize(path: #"///../\/./foo/.\bar"#), #"\foo\bar"#)
#else
        XCTAssertEqual(normalize(path: "///foo/.//bar//"), "/foo/bar")
        XCTAssertEqual(normalize(path: "///foo/.//bar//.//..//.//baz"), "/foo/baz")
        XCTAssertEqual(normalize(path: "///..//./foo/.//bar"), "/foo/bar")
#endif
    }

    func testPathRepresentableEmptyPathBecomesCurrent() {
        XCTAssertEqual(Path("").normalized.pathString, ".")
    }

    func testPathRepresentableSlashPrefixes() {
#if os(Windows)
        XCTAssertEqual(Path("/").normalized.pathString, #"\"#)
        XCTAssertEqual(Path("//").normalized.pathString, #"\"#)
        XCTAssertEqual(Path("///").normalized.pathString, #"\"#)
        XCTAssertEqual(Path(#"\"#).normalized.pathString, #"\"#)
        XCTAssertEqual(Path(#"\\"#).normalized.pathString, #"\"#)
        XCTAssertEqual(Path(#"\\\"#).normalized.pathString, #"\"#)
#else
        XCTAssertEqual(Path("/").normalized.pathString, "/")
        XCTAssertEqual(Path("//").normalized.pathString, "//")
        XCTAssertEqual(Path("///").normalized.pathString, "/")
#endif
    }

    func testPathRepresentableCanonicalizePath() {
#if os(Windows)
        XCTAssertEqual(Path("///foo/.//bar//").normalized.pathString, #"\foo\bar"#)
        XCTAssertEqual(Path("///foo/.//bar//.//..//.//baz").normalized.pathString, #"\foo\baz"#)
        XCTAssertEqual(Path("///..//./foo/.//bar").normalized.pathString, #"\foo\bar"#)
        XCTAssertEqual(Path(#"///../\/./foo/.\bar"#).normalized.pathString, #"\foo\bar"#)
#else
        XCTAssertEqual(Path("///foo/.//bar//").normalized.pathString, "/foo/bar")
        XCTAssertEqual(Path("///foo/.//bar//.//..//.//baz").normalized.pathString, "/foo/baz")
        XCTAssertEqual(Path("///..//./foo/.//bar").normalized.pathString, "/foo/bar")
#endif
    }
}
