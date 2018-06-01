import Pathos
import XCTest

final class JoinPathTests: XCTestCase {
    func testSimpleSingleJoining() {
        XCTAssertEqual(join(path: "/foo", withPath: "bar"), "/foo/bar")
        XCTAssertEqual(join(path: "/foo", withPaths: "bar"), "/foo/bar")
        XCTAssertEqual(join(path: "/foo", withPaths: ["bar"]), "/foo/bar")
        XCTAssertEqual(join(paths: "/foo", "bar"), "/foo/bar")
    }

    func testMultipleJoining() {
        XCTAssertEqual(join(path: "/foo", withPaths: "bar", "baz"), "/foo/bar/baz")
        XCTAssertEqual(join(path: "/foo", withPaths: ["bar", "baz"]), "/foo/bar/baz")
        XCTAssertEqual(join(paths: "/foo", "bar", "baz"), "/foo/bar/baz")
    }

    func testMultipleJoiningWithTrailingSeparators() {
        XCTAssertEqual(join(path: "/foo/", withPaths: "bar/", "baz/"), "/foo/bar/baz/")
        XCTAssertEqual(join(path: "/foo/", withPaths: ["bar/", "baz/"]), "/foo/bar/baz/")
        XCTAssertEqual(join(paths: "/foo/", "bar/", "baz/"), "/foo/bar/baz/")
    }

    func testJoiningWithAbsolutePath() {
        XCTAssertEqual(join(path: "/foo", withPath: "/bar"), "/bar")
        XCTAssertEqual(join(path: "/foo", withPaths: "/bar"), "/bar")
        XCTAssertEqual(join(path: "/foo", withPaths: ["/bar"]), "/bar")
        XCTAssertEqual(join(paths: "/foo", "/bar"), "/bar")
        XCTAssertEqual(join(path: "/foo", withPaths: "/bar", "baz"), "/bar/baz")
        XCTAssertEqual(join(path: "/foo", withPaths: ["/bar", "baz"]), "/bar/baz")
        XCTAssertEqual(join(paths: "/foo", "/bar", "baz"), "/bar/baz")
        XCTAssertEqual(join(path: "/foo", withPaths: "bar", "/baz"), "/baz")
        XCTAssertEqual(join(path: "/foo", withPaths: ["bar", "/baz"]), "/baz")
        XCTAssertEqual(join(paths: "/foo", "bar", "/baz"), "/baz")
    }

    func testPathRepresentableSimpleSingleJoining() {
        XCTAssertEqual(
            Path(string: "/foo").join(with: Path(string: "bar")).pathString,
            "/foo/bar")
    }

    func testPathRepresentableMultipleJoining() {
        XCTAssertEqual(
            Path(string: "/foo").join(with: Path(string: "bar"), Path(string: "baz")).pathString,
            "/foo/bar/baz")
    }

    func testPathRepresentableMultipleJoiningWithTrailingSeparators() {
        XCTAssertEqual(
            Path(string: "/foo/").join(with: Path(string: "bar/"), Path(string: "baz/")).pathString,
            "/foo/bar/baz/")
    }

    func testPathRepresentableJoiningWithAbsolutePath() {
        XCTAssertEqual(
            Path(string: "/foo").join(with: Path(string: "/bar")).pathString,
            "/bar")
        XCTAssertEqual(
            Path(string: "/foo").join(with: Path(string: "/bar"), Path(string: "baz")).pathString,
            "/bar/baz")
        XCTAssertEqual(
            Path(string: "/foo").join(with: Path(string: "bar"), Path(string: "/baz")).pathString,
            "/baz")
    }
}
