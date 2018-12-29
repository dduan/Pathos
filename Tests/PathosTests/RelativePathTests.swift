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
        XCTAssertEqual(Path(string: "a").relativePath(to: Path(string: "a")).pathString, ".")
    }

    func testPathRepresentableRelativeParentSibling() {
        XCTAssertEqual(Path(string: "a").relativePath(to: Path(string: "b/c")).pathString, "../../a")
    }

    func testPathRepresentableAbsoluteSiblings() {
        XCTAssertEqual(Path(string: "/a/b").relativePath(to: Path(string: "/x/y")).pathString, "../../a/b")
    }

    func testPathRepresentableAbsoluteChild() {
        XCTAssertEqual(Path(string: "/a/b/c").relativePath(to: Path(string: "/a/b")).pathString, "c")
        XCTAssertEqual(Path(string: "/a/b/c").relativePath(to: Path(string: "/")).pathString, "a/b/c")
    }

    func testPathRepresentableAbsoluteParent() {
        XCTAssertEqual(Path(string: "/").relativePath(to: Path(string: "/a/b/c")).pathString, "../../..")
    }

    func testPathRepresentableAbsoluteRoot() {
        XCTAssertEqual(Path(string: "/").relativePath(to: Path(string: "/")).pathString, ".")
    }
}
