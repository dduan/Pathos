import Pathos
import XCTest

final class IsSocketTests: XCTestCase {
    func testIsSocketOnExistingFile() {
        XCTAssertFalse(try isA(.socket, atPath: self.fixture(.fileThatExists)))
    }

    func testIsSocketOnExistingDirectory() {
        XCTAssertFalse(try isA(.socket, atPath: self.fixture(.directoryThatExists)))
    }

    func testIsSocketOnNonExistingPath() throws {
        XCTAssertThrowsError(try isA(.socket, atPath: self.fixture(.noneExistence))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testIsSocketOnSymlink() {
        XCTAssertFalse(try isA(.socket, atPath: self.fixture(.goodFileSymbol)))
    }

    func testIsSocketOnSymbolicDirectoryLink() {
        XCTAssertFalse(try isA(.socket, atPath: self.fixture(.goodDirectorySymbol)))
    }

    func testIsSocketOnBadSymlink() throws {
        XCTAssertThrowsError(try isA(.socket, atPath: self.fixture(.badSymbol))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testFileRepresentableIsSocketOnExistingFile() {
        XCTAssertFalse(self.fixturePath(.fileThatExists).isA(.socket))
    }

    func testFileRepresentableIsSocketOnExistingDirectory() {
        XCTAssertFalse(self.fixturePath(.directoryThatExists).isA(.socket))
    }

    func testFileRepresentableIsSocketOnNonExistingFile() {
        XCTAssertFalse(self.fixturePath(.noneExistence).isA(.socket))
    }

    func testPathRepresentableIsSocketOnSymlink() {
        XCTAssertFalse(self.fixturePath(.goodFileSymbol).isA(.socket))
    }

    func testPathRepresentableIsSocketOnSymbolicDirectoryLink() {
        XCTAssertFalse(self.fixturePath(.goodDirectorySymbol).isA(.socket))
    }

    func testPathRepresentableIsSocketOnBadSymlink() {
        XCTAssertFalse(self.fixturePath(.badSymbol).isA(.socket))
    }
}
