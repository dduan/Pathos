import Pathos
import XCTest

final class IsSymlinkTests: XCTestCase {
    func testIsSymlinkOnFile() {
        XCTAssertFalse(try isA(.symlink, atPath: self.fixture(.fileThatExists)))
    }

    func testIsSymlinkOnDirectory() {
        XCTAssertFalse(try isA(.symlink, atPath: self.fixture(.directoryThatExists)))
    }

    func testIsSymlinkOnNonExistingPath() throws {
        XCTAssertThrowsError(try isA(.symlink, atPath: self.fixture(.noneExistence))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testIsSymlinkOnGoodFileSymbol() {
        XCTAssertTrue(try isA(.symlink, atPath: self.fixture(.goodFileSymbol)))
    }

    func testIsSymlinkOnGoodDirectorySymbol() {
        XCTAssertTrue(try isA(.symlink, atPath: self.fixture(.goodDirectorySymbol)))
    }

    func testIsSymlinkOnBadSymbol() {
        XCTAssertTrue(try isA(.symlink, atPath: self.fixture(.badSymbol)))
    }

    func testPathRepresentableIsSymlinkOnFile() {
        XCTAssertFalse(self.fixturePath(.fileThatExists).isA(.symlink))
    }

    func testPathRepresentableIsSymlinkOnDirectory() {
        XCTAssertFalse(self.fixturePath(.directoryThatExists).isA(.symlink))
    }

    func testPathRepresentableIsSymlinkOnNonExistingPath() {
        XCTAssertFalse(self.fixturePath(.noneExistence).isA(.symlink))
    }

    func testPathRepresentableIsSymlinkOnGoodFileSymbol() {
        XCTAssertTrue(self.fixturePath(.goodFileSymbol).isA(.symlink))
    }

    func testPathRepresentableIsSymlinkOnGoodDirectorySymbol() {
        XCTAssertTrue(self.fixturePath(.goodDirectorySymbol).isA(.symlink))
    }

    func testPathRepresentableIsSymlinkOnBadSymbol() {
        XCTAssertTrue(self.fixturePath(.badSymbol).isA(.symlink))
    }
}
