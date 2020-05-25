import Pathos
import XCTest

#if !os(Windows)
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

    func testIsPipeOnSymlink() {
        XCTAssertFalse(try isA(.pipe, atPath: self.fixture(.goodFileSymbol)))
    }

    func testIsPipeOnSymbolicDirectoryLink() {
        XCTAssertFalse(try isA(.pipe, atPath: self.fixture(.goodDirectorySymbol)))
    }

    func testIsPipeOnBadSymlink() throws {
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

    func testPathRepresentableIsPipeOnSymlink() {
        XCTAssertFalse(self.fixturePath(.goodFileSymbol).isA(.pipe))
    }

    func testPathRepresentableIsPipeOnSymbolicDirectoryLink() {
        XCTAssertFalse(self.fixturePath(.goodDirectorySymbol).isA(.pipe))
    }

    func testPathRepresentableIsPipeOnBadSymlink() {
        XCTAssertFalse(self.fixturePath(.badSymbol).isA(.pipe))
    }
}
#endif
