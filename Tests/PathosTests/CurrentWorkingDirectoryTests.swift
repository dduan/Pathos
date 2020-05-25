import Pathos
import XCTest

#if !os(Windows)
final class CurrentWorkingDirectoryTests: XCTestCase {
    func testGetting() throws {
        XCTAssertFalse(try getCurrentWorkingDirectory().isEmpty)
    }

    func testSetting() throws {
        let newDirectory = try realPath(ofPath: createTemporaryDirectory())
        let original = try getCurrentWorkingDirectory()
        try setCurrentWorkingDirectory(toPath: newDirectory)

        XCTAssertEqual(try getCurrentWorkingDirectory(), newDirectory)

        try setCurrentWorkingDirectory(toPath: original)
    }

    func testWorkingDirectoryBlock() throws {
        let original = try getCurrentWorkingDirectory()
        let temporary = try realPath(ofPath: createTemporaryDirectory())
        try withWorkingDirectory(beingPath: temporary) {
            XCTAssertEqual(try getCurrentWorkingDirectory(), temporary)
        }

        XCTAssertEqual(try getCurrentWorkingDirectory(), original)
    }

    func testPathRepresentableGetting() throws {
        XCTAssertFalse(Path.currentWorkingDirectory.pathString.isEmpty)
    }

    func testPathRepresentableSetting() throws {
        let newDirectory = Path(try realPath(ofPath: createTemporaryDirectory()))
        let original = try getCurrentWorkingDirectory()

        Path.currentWorkingDirectory = newDirectory

        XCTAssertEqual(Path.currentWorkingDirectory.pathString, newDirectory.pathString)

        try setCurrentWorkingDirectory(toPath: original)
    }

    func testPathRepresentableWorkingDirectoryBlock() throws {
        let original = Path.currentWorkingDirectory
        let temporary = Path.createTemporaryDirectory()!.realPath
        temporary.asCurrentWorkingDirectory {
            XCTAssertEqual(try getCurrentWorkingDirectory(), temporary.pathString)
        }

        XCTAssertEqual(try getCurrentWorkingDirectory(), original.pathString)
    }
}
#endif
