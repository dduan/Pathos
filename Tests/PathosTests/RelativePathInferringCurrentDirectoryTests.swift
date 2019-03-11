import Pathos
import XCTest

final class RelativePathInferringCurrentDirectoryTests: XCTestCase {
    let originalWorkingDirectory = (try? Pathos.getCurrentWorkingDirectory()) ?? "."
    var testRoot = makeTemporaryRoot()
    /// create a new directory, which contains directories a/b/c. cd into a/b.
    override func setUp() {
        try! deletePath(self.testRoot)
        let newRoot = makeTemporaryRoot()
        try! createDirectory(atPath: join(paths: newRoot, "a/b/c"), createParents: true)
        try! setCurrentWorkingDirectory(toPath: join(paths: newRoot, "a/b"))
        self.testRoot = try! normalize(path: join(paths: getCurrentWorkingDirectory(), "../../"))
    }

    override func tearDown() {
        _ = try? setCurrentWorkingDirectory(toPath: self.originalWorkingDirectory)
    }

    func testAbsoluteParent() throws {
        XCTAssertEqual(try relativePath(ofPath: self.testRoot), "../..")
    }

    func testAbsoluteChild() throws {
        let testPath = join(paths: self.testRoot, "a/b/c")
        XCTAssertEqual(try relativePath(ofPath: testPath), "c")
    }

    func testRelativeParent() throws {
        XCTAssertEqual(try relativePath(ofPath: "../.."), "../..")
    }

    func testRelativeChild() throws {
        XCTAssertEqual(try relativePath(ofPath: "./c"), "c")
    }

    func testPathRepresentableAbsoluteParent() throws {
        XCTAssertEqual(Path(self.testRoot).relativePath().pathString, "../..")
    }

    func testPathRepresentableAbsoluteChild() throws {
        let testPath = join(paths: self.testRoot, "a/b/c")
        XCTAssertEqual(Path(testPath).relativePath().pathString, "c")
    }

    func testPathRepresentableRelativeParent() throws {
        XCTAssertEqual(Path("../..").relativePath().pathString, "../..")
    }

    func testPathRepresentableRelativeChild() throws {
        XCTAssertEqual(Path("./c").relativePath().pathString, "c")
    }
}
