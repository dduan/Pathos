import Pathos
import XCTest

final class IsSocketTests: XCTestCase {
    func testIsSocketOnExistingFile() {
        XCTAssertFalse(try isSocket(atPath: self.fixture(.fileThatExists)))
    }

    func testIsSocketOnExistingDirectory() {
        XCTAssertFalse(try isSocket(atPath: self.fixture(.directoryThatExists)))
    }

    func testIsSocketOnNonExistingPath() {
        XCTAssertThrowsError(try isSocket(atPath: self.fixture(.noneExistence))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testIsSocketOnSymbolicLink() {
        XCTAssertFalse(try isSocket(atPath: self.fixture(.goodFileSymbol)))
    }

    func testIsSocketOnSymbolicDirectoryLink() {
        XCTAssertFalse(try isSocket(atPath: self.fixture(.goodDirectorySymbol)))
    }

    func testIsSocketOnBadSymbolicLink() {
        XCTAssertThrowsError(try isSocket(atPath: self.fixture(.badSymbol))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testFileRepresentableIsSocketOnExistingFile() {
        XCTAssertFalse(self.fixturePath(.fileThatExists).isSocket)
    }

    func testFileRepresentableIsSocketOnExistingDirectory() {
        XCTAssertFalse(self.fixturePath(.directoryThatExists).isSocket)
    }

    func testFileRepresentableIsSocketOnNonExistingFile() {
        XCTAssertFalse(self.fixturePath(.noneExistence).isSocket)
    }

    func testPathRerpesentableIsSocketOnSymbolicLink() {
        XCTAssertFalse(self.fixturePath(.goodFileSymbol).isSocket)
    }

    func testPathRepresentableIsSocketOnSymbolicDirectoryLink() {
        XCTAssertFalse(self.fixturePath(.goodDirectorySymbol).isSocket)
    }

    func testPathRerpesentableIsSocketOnBadSymbolicLink() {
        XCTAssertFalse(self.fixturePath(.badSymbol).isSocket)
    }
}
