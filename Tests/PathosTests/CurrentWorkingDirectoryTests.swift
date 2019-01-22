import Pathos
import XCTest

final class CurrentWorkingDirectoryTests: XCTestCase {
    func testGetting() throws {
        XCTAssertFalse(try getCurrentWorkingDirectory().isEmpty)
    }

    func testSetting() throws {
        let newDirectory = try realPath(ofPath: makeTemporaryDirectory())
        let original = try getCurrentWorkingDirectory()
        try setCurrentWorkingDirectory(toPath: newDirectory)

        XCTAssertEqual(try getCurrentWorkingDirectory(), newDirectory)

        try setCurrentWorkingDirectory(toPath: original)
    }

    func testWorkingDirectoryBlock() throws {
        let original = try getCurrentWorkingDirectory()
        let temporary = try realPath(ofPath: makeTemporaryDirectory())
        let expectation = self.expectation(description: "closure is executed")
        try withWorkingDirectory(beingPath: temporary) {
            expectation.fulfill()
            XCTAssertEqual(try getCurrentWorkingDirectory(), temporary)
        }

        XCTAssertEqual(XCTWaiter.wait(for: [expectation], timeout: 0.01), .completed)
        XCTAssertEqual(try getCurrentWorkingDirectory(), original)
    }

    func testPathRepresentableGetting() throws {
        XCTAssertFalse(Path.currentWorkingDirectory.pathString.isEmpty)
    }

    func testPathRepresentableSetting() throws {
        let newDirectory = Path(string: try realPath(ofPath: makeTemporaryDirectory()))
        let original = try getCurrentWorkingDirectory()

        Path.currentWorkingDirectory = newDirectory

        XCTAssertEqual(Path.currentWorkingDirectory.pathString, newDirectory.pathString)

        try setCurrentWorkingDirectory(toPath: original)
    }

    func testPathRepresentableWorkingDirectoryBlock() throws {
        let original = Path.currentWorkingDirectory
        let temporary = Path.makeTemporaryDirectory()!.realPath
        let expectation = self.expectation(description: "closure is executed")
        temporary.asCurrentWorkingDirectory {
            expectation.fulfill()
            XCTAssertEqual(try getCurrentWorkingDirectory(), temporary.pathString)
        }

        XCTAssertEqual(XCTWaiter.wait(for: [expectation], timeout: 0.01), .completed)
        XCTAssertEqual(try getCurrentWorkingDirectory(), original.pathString)
    }
}
