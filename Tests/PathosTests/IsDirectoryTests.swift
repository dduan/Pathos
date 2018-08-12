import Pathos
import XCTest

final class IsDirectoryTests: FixtureTestCase {
    func testIsDirectoryOnExistingFile() {
        XCTAssertFalse(try isDirectory(atPath: self.fixture(.fileThatExists)))
    }

    func testIsDirectoryOnExistingDirectory() {
        XCTAssertTrue(try isDirectory(atPath: self.fixture(.directoryThatExists)))
    }

    func testIsDirectoryOnNonExistingPath() {
        XCTAssertThrowsError(try isDirectory(atPath: self.fixture(.noneExistence))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testDirectoryRepresentableIsFileOnExistingFile() {
        XCTAssertFalse(self.fixturePath(.fileThatExists).isDirectory)
    }

    func testDirectoryRepresentableIsFileOnExistingDirectory() {
        XCTAssertTrue(self.fixturePath(.directoryThatExists).isDirectory)
    }

    func testDirectoryRepresentableIsFileOnNonExistingFile() {
        XCTAssertFalse(self.fixturePath(.noneExistence).isDirectory)
    }
}
