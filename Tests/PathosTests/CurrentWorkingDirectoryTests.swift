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
}
