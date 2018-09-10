import Pathos
import XCTest

final class IsFileTests: XCTestCase {
    func testIsFileOnExistingFile() {
        XCTAssertTrue(try isFile(atPath: self.fixture(.fileThatExists)))
    }

    func testIsFileOnExistingDirectory() {
        XCTAssertFalse(try isFile(atPath: self.fixture(.directoryThatExists)))
    }

    func testIsFileOnNonExistingPath() {
        XCTAssertThrowsError(try isFile(atPath: self.fixture(.noneExistence))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testIsFileOnSymbolicLink() {
        XCTAssertTrue(try isFile(atPath: self.fixture(.goodFileSymbol)))
    }

    func testIsFileOnSymbolicDirectoryLink() {
        XCTAssertFalse(try isFile(atPath: self.fixture(.goodDirectorySymbol)))
    }

    func testIsFileOnBadSymbolicLink() {
        XCTAssertThrowsError(try isFile(atPath: self.fixture(.badSymbol))) { error in
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

    func testPathRerpesentableIsFileOnSymbolicLink() {
        XCTAssertTrue(self.fixturePath(.goodFileSymbol).isFile)
    }

    func testPathRepresentableIsFileOnSymbolicDirectoryLink() {
        XCTAssertFalse(self.fixturePath(.goodDirectorySymbol).isFile)
    }

    func testPathRerpesentableIsFileOnBadSymbolicLink() {
        XCTAssertFalse(self.fixturePath(.badSymbol).isFile)
    }
}
