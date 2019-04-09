import Pathos
import XCTest

final class IsFileTests: XCTestCase {
    func testIsFileOnExistingFile() {
        XCTAssertTrue(try isA(.file, atPath: self.fixture(.fileThatExists)))
    }

    func testIsFileOnExistingDirectory() {
        XCTAssertFalse(try isA(.file, atPath: self.fixture(.directoryThatExists)))
    }

    func testIsFileOnNonExistingPath() throws {
        XCTAssertThrowsError(try isA(.file, atPath: self.fixture(.noneExistence))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testIsFileOnSymbolicLink() {
        XCTAssertTrue(try isA(.file, atPath: self.fixture(.goodFileSymbol)))
    }

    func testIsFileOnSymbolicDirectoryLink() {
        XCTAssertFalse(try isA(.file, atPath: self.fixture(.goodDirectorySymbol)))
    }

    func testIsFileOnBadSymbolicLink() throws {
        XCTAssertThrowsError(try isA(.file, atPath: self.fixture(.badSymbol))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testFileRepresentableIsFileOnExistingFile() {
        XCTAssertTrue(self.fixturePath(.fileThatExists).isA(.file))
    }

    func testFileRepresentableIsFileOnExistingDirectory() {
        XCTAssertFalse(self.fixturePath(.directoryThatExists).isA(.file))
    }

    func testFileRepresentableIsFileOnNonExistingFile() {
        XCTAssertFalse(self.fixturePath(.noneExistence).isA(.file))
    }

    func testPathRerpesentableIsFileOnSymbolicLink() {
        XCTAssertTrue(self.fixturePath(.goodFileSymbol).isA(.file))
    }

    func testPathRepresentableIsFileOnSymbolicDirectoryLink() {
        XCTAssertFalse(self.fixturePath(.goodDirectorySymbol).isA(.file))
    }

    func testPathRerpesentableIsFileOnBadSymbolicLink() {
        XCTAssertFalse(self.fixturePath(.badSymbol).isA(.file))
    }
}
