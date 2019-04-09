import Pathos
import XCTest

final class IsPipeTests: XCTestCase {
    func testIsPipeOnExistingFile() {
        XCTAssertFalse(try isA(.pipe, atPath: self.fixture(.fileThatExists)))
    }

    func testIsPipeOnExistingDirectory() {
        XCTAssertFalse(try isA(.pipe, atPath: self.fixture(.directoryThatExists)))
    }

    func testIsPipeOnNonExistingPath() throws {
        XCTAssertThrowsError(try isA(.pipe, atPath: self.fixture(.noneExistence))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testIsPipeOnSymbolicLink() {
        XCTAssertFalse(try isA(.pipe, atPath: self.fixture(.goodFileSymbol)))
    }

    func testIsPipeOnSymbolicDirectoryLink() {
        XCTAssertFalse(try isA(.pipe, atPath: self.fixture(.goodDirectorySymbol)))
    }

    func testIsPipeOnBadSymbolicLink() throws {
        XCTAssertThrowsError(try isA(.pipe, atPath: self.fixture(.badSymbol))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testFileRepresentableIsPipeOnExistingFile() {
        XCTAssertFalse(self.fixturePath(.fileThatExists).isA(.pipe))
    }

    func testFileRepresentableIsPipeOnExistingDirectory() {
        XCTAssertFalse(self.fixturePath(.directoryThatExists).isA(.pipe))
    }

    func testFileRepresentableIsPipeOnNonExistingFile() {
        XCTAssertFalse(self.fixturePath(.noneExistence).isA(.pipe))
    }

    func testPathRepresentableIsPipeOnSymbolicLink() {
        XCTAssertFalse(self.fixturePath(.goodFileSymbol).isA(.pipe))
    }

    func testPathRepresentableIsPipeOnSymbolicDirectoryLink() {
        XCTAssertFalse(self.fixturePath(.goodDirectorySymbol).isA(.pipe))
    }

    func testPathRepresentableIsPipeOnBadSymbolicLink() {
        XCTAssertFalse(self.fixturePath(.badSymbol).isA(.pipe))
    }
}

