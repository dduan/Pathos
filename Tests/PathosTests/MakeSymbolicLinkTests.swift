import Pathos
import XCTest

final class MakeSymbolicLinkTests: XCTestCase {
    var originalWorkingDirectory: String = (try? getCurrentWorkingDirectory()) ?? "."
    var rootPath = makeTemporaryRoot()

    override func setUp() {
        self.rootPath = makeTemporaryRoot()
        try? setCurrentWorkingDirectory(to: self.rootPath)
    }

    override func tearDown() {
        try? setCurrentWorkingDirectory(to: self.originalWorkingDirectory)
        try? deletePath(self.rootPath, recursive: true)
    }

    func testMakingSymbolicLink() throws {
        let source = self.fixture(.fileThatExists)
        let destination = "test"
        try makeSymbolicLink(fromPath: source, toPath: destination)
        XCTAssertEqual(try realPath(ofPath: destination), source)
    }

    func testPathRepresentableMakingSymbolicLink() throws {
        let source = self.fixturePath(.fileThatExists)
        let destination = Path(string: self.rootPath).join(with: Path(string: "test"))
        XCTAssertTrue(source.makeSymbolicLink(to: destination))
        XCTAssertEqual(destination.realPath.pathString, source.pathString)
    }
}
