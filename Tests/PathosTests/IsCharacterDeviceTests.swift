import Pathos
import XCTest

final class IsCharacterDeviceTests: XCTestCase {
    func testIsCharacterDeviceOnExistingFile() {
        XCTAssertFalse(try isA(.characterDevice, atPath: self.fixture(.fileThatExists)))
    }

    func testIsCharacterDeviceOnExistingDirectory() {
        XCTAssertFalse(try isA(.characterDevice, atPath: self.fixture(.directoryThatExists)))
    }

    func testIsCharacterDeviceOnNonExistingPath() {
        XCTAssertThrowsError(try isA(.characterDevice, atPath: self.fixture(.noneExistence))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testIsCharacterDeviceOnSymlink() {
        XCTAssertFalse(try isA(.characterDevice, atPath: self.fixture(.goodFileSymbol)))
    }

    func testIsCharacterDeviceOnSymbolicDirectoryLink() {
        XCTAssertFalse(try isA(.characterDevice, atPath: self.fixture(.goodDirectorySymbol)))
    }

    func testIsCharacterDeviceOnBadSymlink() {
        XCTAssertThrowsError(try isA(.characterDevice, atPath: self.fixture(.badSymbol))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testFileRepresentableIsCharacterDeviceOnExistingFile() {
        XCTAssertFalse(self.fixturePath(.fileThatExists).isA(.characterDevice))
    }

    func testFileRepresentableIsCharacterDeviceOnExistingDirectory() {
        XCTAssertFalse(self.fixturePath(.directoryThatExists).isA(.characterDevice))
    }

    func testFileRepresentableIsCharacterDeviceOnNonExistingFile() {
        XCTAssertFalse(self.fixturePath(.noneExistence).isA(.characterDevice))
    }

    func testPathRepresentableIsCharacterDeviceOnSymlink() {
        XCTAssertFalse(self.fixturePath(.goodFileSymbol).isA(.characterDevice))
    }

    func testPathRepresentableIsCharacterDeviceOnSymbolicDirectoryLink() {
        XCTAssertFalse(self.fixturePath(.goodDirectorySymbol).isA(.characterDevice))
    }

    func testPathRepresentableIsCharacterDeviceOnBadSymlink() {
        XCTAssertFalse(self.fixturePath(.badSymbol).isA(.characterDevice))
    }
}
