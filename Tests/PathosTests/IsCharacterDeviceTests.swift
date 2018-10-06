import Pathos
import XCTest

final class IsCharacterDeviceTests: XCTestCase {
    func testIsCharacterDeviceOnExistingFile() {
        XCTAssertFalse(try isCharacterDevice(atPath: self.fixture(.fileThatExists)))
    }

    func testIsCharacterDeviceOnExistingDirectory() {
        XCTAssertFalse(try isCharacterDevice(atPath: self.fixture(.directoryThatExists)))
    }

    func testIsCharacterDeviceOnNonExistingPath() {
        XCTAssertThrowsError(try isCharacterDevice(atPath: self.fixture(.noneExistence))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testIsCharacterDeviceOnSymbolicLink() {
        XCTAssertFalse(try isCharacterDevice(atPath: self.fixture(.goodFileSymbol)))
    }

    func testIsCharacterDeviceOnSymbolicDirectoryLink() {
        XCTAssertFalse(try isCharacterDevice(atPath: self.fixture(.goodDirectorySymbol)))
    }

    func testIsCharacterDeviceOnBadSymbolicLink() {
        XCTAssertThrowsError(try isCharacterDevice(atPath: self.fixture(.badSymbol))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testFileRepresentableIsCharacterDeviceOnExistingFile() {
        XCTAssertFalse(self.fixturePath(.fileThatExists).isCharacterDevice)
    }

    func testFileRepresentableIsCharacterDeviceOnExistingDirectory() {
        XCTAssertFalse(self.fixturePath(.directoryThatExists).isCharacterDevice)
    }

    func testFileRepresentableIsCharacterDeviceOnNonExistingFile() {
        XCTAssertFalse(self.fixturePath(.noneExistence).isCharacterDevice)
    }

    func testPathRepresentableIsCharacterDeviceOnSymbolicLink() {
        XCTAssertFalse(self.fixturePath(.goodFileSymbol).isCharacterDevice)
    }

    func testPathRepresentableIsCharacterDeviceOnSymbolicDirectoryLink() {
        XCTAssertFalse(self.fixturePath(.goodDirectorySymbol).isCharacterDevice)
    }

    func testPathRepresentableIsCharacterDeviceOnBadSymbolicLink() {
        XCTAssertFalse(self.fixturePath(.badSymbol).isCharacterDevice)
    }
}
