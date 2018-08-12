import Pathos
import XCTest

final class IsPipeTests: FixtureTestCase {
    func testIsPipeOnExistingFile() {
        XCTAssertFalse(try isPipe(atPath: self.fixture(.fileThatExists)))
    }

    func testIsPipeOnExistingDirectory() {
        XCTAssertFalse(try isPipe(atPath: self.fixture(.directoryThatExists)))
    }

    func testIsPipeOnNonExistingPath() {
        XCTAssertThrowsError(try isPipe(atPath: self.fixture(.noneExistence))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testIsPipeOnSymbolicLink() {
        XCTAssertFalse(try isPipe(atPath: self.fixture(.goodFileSymbol)))
    }

    func testIsPipeOnSymbolicDirectoryLink() {
        XCTAssertFalse(try isPipe(atPath: self.fixture(.goodDirectorySymbol)))
    }

    func testIsPipeOnBadSymbolicLink() {
        XCTAssertThrowsError(try isPipe(atPath: self.fixture(.badSymbol))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testFileRepresentableIsPipeOnExistingFile() {
        XCTAssertFalse(self.fixturePath(.fileThatExists).isPipe)
    }

    func testFileRepresentableIsPipeOnExistingDirectory() {
        XCTAssertFalse(self.fixturePath(.directoryThatExists).isPipe)
    }

    func testFileRepresentableIsPipeOnNonExistingFile() {
        XCTAssertFalse(self.fixturePath(.noneExistence).isPipe)
    }

    func testPathRerpesentableIsPipeOnSymbolicLink() {
        XCTAssertFalse(self.fixturePath(.goodFileSymbol).isPipe)
    }

    func testPathRepresentableIsPipeOnSymbolicDirectoryLink() {
        XCTAssertFalse(self.fixturePath(.goodDirectorySymbol).isPipe)
    }

    func testPathRerpesentableIsPipeOnBadSymbolicLink() {
        XCTAssertFalse(self.fixturePath(.badSymbol).isPipe)
    }
}

