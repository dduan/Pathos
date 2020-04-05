import Pathos
import XCTest

final class MakeSymlinkTests: XCTestCase {
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

    func testMakingSymlink() throws {
        let source = self.fixture(.fileThatExists)
        let destination = "test"
        try createSymlink(fromPath: source, toPath: destination)
        XCTAssertEqual(try realPath(ofPath: destination), source)
    }

    func testPathRepresentableMakingSymlink() throws {
        let source = self.fixturePath(.fileThatExists)
        let destination = Path(self.rootPath).join(with: Path("test"))
        XCTAssertTrue(source.createSymlink(at: destination))
        XCTAssertEqual(destination.realPath.pathString, source.pathString)
    }
}
