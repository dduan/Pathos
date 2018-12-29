import Pathos
import XCTest

final class RelativePathInferringCurrentDirectoryTests: XCTestCase {
    let originalWorkingDirectory = (try? Pathos.getCurrentWorkingDirectory()) ?? "."
    var testRoot = makeTemporaryRoot()
    /// create a new directory, which contains directories a/b/c. cd into a/b.
    override func setUp() {
        try! deletePath(self.testRoot)
        let newRoot = makeTemporaryRoot()
        try! makeDirectory(atPath: join(path: newRoot, withPath: "a/b/c"), createParents: true)
        try! setCurrentWorkingDirectory(to: join(path: newRoot, withPath: "a/b"))
        self.testRoot = try! normalize(path: join(path: getCurrentWorkingDirectory(), withPath: "../../"))
    }

    override func tearDown() {
        _ = try? setCurrentWorkingDirectory(to: self.originalWorkingDirectory)
    }

    func testAbsoluteParent() throws {
        XCTAssertEqual(try relativePath(ofPath: self.testRoot), "../..")
    }

    func testAbsoluteChild() throws {
        let testPath = join(path: self.testRoot, withPath: "a/b/c")
        XCTAssertEqual(try relativePath(ofPath: testPath), "c")
    }

    func testRelativeParent() throws {
        XCTAssertEqual(try relativePath(ofPath: "../.."), "../..")
    }

    func testRelativeChild() throws {
        XCTAssertEqual(try relativePath(ofPath: "./c"), "c")
    }

    func testPathRepresentableAbsoluteParent() throws {
        XCTAssertEqual(Path(string: self.testRoot).relativePath().pathString, "../..")
    }

    func testPathRepresentableAbsoluteChild() throws {
        let testPath = join(path: self.testRoot, withPath: "a/b/c")
        XCTAssertEqual(Path(string: testPath).relativePath().pathString, "c")
    }

    func testPathRepresentableRelativeParent() throws {
        XCTAssertEqual(Path(string: "../..").relativePath().pathString, "../..")
    }

    func testPathRepresentableRelativeChild() throws {
        XCTAssertEqual(Path(string: "./c").relativePath().pathString, "c")
    }
}
