import Pathos
import XCTest

final class MakeSymbolicLinkTests: XCTestCase {
    var originalWorkingDirectory: String = (try? getCurrentWorkingDirectory()) ?? "."
    var rootPath = ""

    override func setUp() {
        self.rootPath = makeTemporaryRoot()
        try? setCurrentWorkingDirectory(toPath: self.rootPath)
    }

    override func tearDown() {
        try? setCurrentWorkingDirectory(toPath: self.originalWorkingDirectory)
        try? deletePath(self.rootPath, recursive: true)
    }

    func testMakingSymbolicLink() throws {
        let source = self.fixture(.fileThatExists)
        let destination = "test"
        try createSymbolicLink(fromPath: source, toPath: destination)
        XCTAssertEqual(try realPath(ofPath: destination), source)
    }

    func testPathRepresentableMakingSymbolicLink() throws {
        let source = self.fixturePath(.fileThatExists)
        let destination = Path(string: self.rootPath).join(with: Path(string: "test"))
        XCTAssertTrue(source.createSymbolicLink(to: destination))
        XCTAssertEqual(destination.realPath.pathString, source.pathString)
    }
}
