import Pathos
import XCTest

final class IsFileTests: FixtureTestCase {
    func testIsFileOnExistingFile() {
        XCTAssertTrue(try isFile(atPath: self.fixture(.fileThatExists)))
    }

    func testIsFileOnExistingDirectory() {
        XCTAssertFalse(try isFile(atPath: self.fixture(.directoryThatExists)))
    }

    func testIsFileOnNonExistingFile() {
        XCTAssertThrowsError(try isFile(atPath: self.fixture(.noneExistence))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testFileRepresentableIsFileOnExistingFile() {
        XCTAssertTrue(self.fixturePath(.fileThatExists).isFile)
    }

    func testFileRepresentableIsFileOnExistingDirectory() {
        XCTAssertFalse(self.fixturePath(.directoryThatExists).isFile)
    }

    func testFileRepresentableIsFileOnNonExistingFile() {
        XCTAssertFalse(self.fixturePath(.noneExistence).isFile)
    }
}
