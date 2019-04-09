import Pathos
import XCTest

final class IsBlockDeviceTests: XCTestCase {
    func testIsBlockDeviceOnExistingFile() {
        XCTAssertFalse(try isA(.blockDevice, atPath: self.fixture(.fileThatExists)))
    }

    func testIsBlockDeviceOnExistingDirectory() {
        XCTAssertFalse(try isA(.blockDevice, atPath: self.fixture(.directoryThatExists)))
    }

    func testIsBlockDeviceOnNonExistingPath() throws {
        XCTAssertThrowsError(try isA(.blockDevice, atPath: self.fixture(.noneExistence))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testIsBlockDeviceOnSymbolicLink() {
        XCTAssertFalse(try isA(.blockDevice, atPath: self.fixture(.goodFileSymbol)))
    }

    func testIsBlockDeviceOnSymbolicDirectoryLink() {
        XCTAssertFalse(try isA(.blockDevice, atPath: self.fixture(.goodDirectorySymbol)))
    }

    func testIsBlockDeviceOnBadSymbolicLink() {
        XCTAssertThrowsError(try isA(.blockDevice, atPath: self.fixture(.badSymbol))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testFileRepresentableIsBlockDeviceOnExistingFile() {
        XCTAssertFalse(self.fixturePath(.fileThatExists).isA(.blockDevice))
    }

    func testFileRepresentableIsBlockDeviceOnExistingDirectory() {
        XCTAssertFalse(self.fixturePath(.directoryThatExists).isA(.blockDevice))
    }

    func testFileRepresentableIsBlockDeviceOnNonExistingFile() {
        XCTAssertFalse(self.fixturePath(.noneExistence).isA(.blockDevice))
    }

    func testPathRerpesentableIsBlockDeviceOnSymbolicLink() {
        XCTAssertFalse(self.fixturePath(.goodFileSymbol).isA(.blockDevice))
    }

    func testPathRepresentableIsBlockDeviceOnSymbolicDirectoryLink() {
        XCTAssertFalse(self.fixturePath(.goodDirectorySymbol).isA(.blockDevice))
    }

    func testPathRepresentableIsBlockDeviceOnBadSymbolicLink() {
        XCTAssertFalse(self.fixturePath(.badSymbol).isA(.blockDevice))
    }
}
