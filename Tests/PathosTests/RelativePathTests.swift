import Pathos
import XCTest

final class RelativePathTests: XCTestCase {
    func testRelativeSelf() {
        XCTAssertEqual(relativePath(ofPath: "a", startingFromPath: "a"), ".")
    }

    func testRelativeParentSibling() {
        XCTAssertEqual(relativePath(ofPath: "a", startingFromPath: "b/c"), "../../a")
    }

    func testAbsoluteSiblings() {
        XCTAssertEqual(relativePath(ofPath: "/a/b", startingFromPath: "/x/y"), "../../a/b")
    }

    func testAbsoluteChild() {
        XCTAssertEqual(relativePath(ofPath: "/a/b/c", startingFromPath: "/a/b"), "c")
        XCTAssertEqual(relativePath(ofPath: "/a/b/c", startingFromPath: "/"), "a/b/c")
    }

    func testAbsoluteParent() {
        XCTAssertEqual(relativePath(ofPath: "/", startingFromPath: "/a/b/c"), "../../..")
    }

    func testAbsoluteRoot() {
        XCTAssertEqual(relativePath(ofPath: "/", startingFromPath: "/"), ".")
    }

    func testPathRepresentableRelativeSelf() {
        XCTAssertEqual(Path("a").relativePath(to: Path("a")).pathString, ".")
    }

    func testPathRepresentableRelativeParentSibling() {
        XCTAssertEqual(Path("a").relativePath(to: Path("b/c")).pathString, "../../a")
    }

    func testPathRepresentableAbsoluteSiblings() {
        XCTAssertEqual(Path("/a/b").relativePath(to: Path("/x/y")).pathString, "../../a/b")
    }

    func testPathRepresentableAbsoluteChild() {
        XCTAssertEqual(Path("/a/b/c").relativePath(to: Path("/a/b")).pathString, "c")
        XCTAssertEqual(Path("/a/b/c").relativePath(to: Path("/")).pathString, "a/b/c")
    }

    func testPathRepresentableAbsoluteParent() {
        XCTAssertEqual(Path("/").relativePath(to: Path("/a/b/c")).pathString, "../../..")
    }

    func testPathRepresentableAbsoluteRoot() {
        XCTAssertEqual(Path("/").relativePath(to: Path("/")).pathString, ".")
    }
}
