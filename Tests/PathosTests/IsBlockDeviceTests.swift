import Pathos
import XCTest

final class IsBlockDeviceTests: XCTestCase {
    func testIsBlockDeviceOnExistingFile() {
        XCTAssertFalse(try isBlockDevice(atPath: self.fixture(.fileThatExists)))
    }

    func testIsBlockDeviceOnExistingDirectory() {
        XCTAssertFalse(try isBlockDevice(atPath: self.fixture(.directoryThatExists)))
    }

    func testIsBlockDeviceOnNonExistingPath() throws {
        XCTAssertThrowsError(try isBlockDevice(atPath: self.fixture(.noneExistence))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testIsBlockDeviceOnSymbolicLink() {
        XCTAssertFalse(try isBlockDevice(atPath: self.fixture(.goodFileSymbol)))
    }

    func testIsBlockDeviceOnSymbolicDirectoryLink() {
        XCTAssertFalse(try isBlockDevice(atPath: self.fixture(.goodDirectorySymbol)))
    }

    func testIsBlockDeviceOnBadSymbolicLink() {
        XCTAssertThrowsError(try isBlockDevice(atPath: self.fixture(.badSymbol))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testFileRepresentableIsBlockDeviceOnExistingFile() {
        XCTAssertFalse(self.fixturePath(.fileThatExists).isBlockDevice)
    }

    func testFileRepresentableIsBlockDeviceOnExistingDirectory() {
        XCTAssertFalse(self.fixturePath(.directoryThatExists).isBlockDevice)
    }

    func testFileRepresentableIsBlockDeviceOnNonExistingFile() {
        XCTAssertFalse(self.fixturePath(.noneExistence).isBlockDevice)
    }

    func testPathRerpesentableIsBlockDeviceOnSymbolicLink() {
        XCTAssertFalse(self.fixturePath(.goodFileSymbol).isBlockDevice)
    }

    func testPathRepresentableIsBlockDeviceOnSymbolicDirectoryLink() {
        XCTAssertFalse(self.fixturePath(.goodDirectorySymbol).isBlockDevice)
    }

    func testPathRepresentableIsBlockDeviceOnBadSymbolicLink() {
        XCTAssertFalse(self.fixturePath(.badSymbol).isBlockDevice)
    }
}
