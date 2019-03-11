import Pathos
import XCTest

final class JoinPathTests: XCTestCase {
    func testJoiningNothing() {
        XCTAssertEqual(join(paths: []), "")
    }

    func testSimpleSingleJoinings() {
        XCTAssertEqual(join(paths: ["/foo", "bar"]), "/foo/bar")
        XCTAssertEqual(join(paths: "/foo", "bar"), "/foo/bar")
    }

    func testMultipleJoining() {
        XCTAssertEqual(join(paths: ["/foo", "bar", "baz"]), "/foo/bar/baz")
        XCTAssertEqual(join(paths: "/foo", "bar", "baz"), "/foo/bar/baz")
    }

    func testMultipleJoiningWithTrailingSeparators() {
        XCTAssertEqual(join(paths: ["/foo/", "bar/", "baz/"]), "/foo/bar/baz/")
        XCTAssertEqual(join(paths: "/foo/", "bar/", "baz/"), "/foo/bar/baz/")
    }

    func testJoiningWithAbsolutePath() {
        XCTAssertEqual(join(paths: ["/foo", "/bar"]), "/bar")
        XCTAssertEqual(join(paths: "/foo", "/bar"), "/bar")
        XCTAssertEqual(join(paths: ["/foo", "/bar", "baz"]), "/bar/baz")
        XCTAssertEqual(join(paths: "/foo", "/bar", "baz"), "/bar/baz")
        XCTAssertEqual(join(paths: ["/foo", "bar", "/baz"]), "/baz")
        XCTAssertEqual(join(paths: "/foo", "bar", "/baz"), "/baz")
    }

    func testPathRepresentableSimpleSingleJoining() {
        XCTAssertEqual(
            Path("/foo").join(with: [Path("bar")]).pathString,
            "/foo/bar")
        XCTAssertEqual(
            Path("/foo").join(with: Path("bar")).pathString,
            "/foo/bar")
    }

    func testPathRepresentableMultipleJoining() {
        XCTAssertEqual(
            Path("/foo").join(with: [Path("bar"), Path("baz")]).pathString,
            "/foo/bar/baz")
        XCTAssertEqual(
            Path("/foo").join(with: Path("bar"), Path("baz")).pathString,
            "/foo/bar/baz")
    }

    func testPathRepresentableMultipleJoiningWithTrailingSeparators() {
        XCTAssertEqual(
            Path("/foo/").join(with: [Path("bar/"), Path("baz/")]).pathString,
            "/foo/bar/baz/")
        XCTAssertEqual(
            Path("/foo/").join(with: Path("bar/"), Path("baz/")).pathString,
            "/foo/bar/baz/")
    }

    func testPathRepresentableJoiningWithNothing() {
        XCTAssertEqual(
            Path("/foo").join(with: []).pathString,
            "/foo")
    }

    func testPathRepresentableJoiningWithAbsolutePath() {
        XCTAssertEqual(
            Path("/foo").join(with: [Path("/bar")]).pathString,
            "/bar")
        XCTAssertEqual(
            Path("/foo").join(with: Path("/bar")).pathString,
            "/bar")

        XCTAssertEqual(
            Path("/foo").join(with: [Path("/bar"), Path("baz")]).pathString,
            "/bar/baz")
        XCTAssertEqual(
            Path("/foo").join(with: Path("/bar"), Path("baz")).pathString,
            "/bar/baz")

        XCTAssertEqual(
            Path("/foo").join(with: [Path("bar"), Path("/baz")]).pathString,
            "/baz")
        XCTAssertEqual(
            Path("/foo").join(with: Path("bar"), Path("/baz")).pathString,
            "/baz")
    }
}
