import Pathos
import XCTest

final class IsSymbolicLinkTests: XCTestCase {
    func testIsSymbolicLinkOnFile() {
        XCTAssertFalse(try isSymbolicLink(atPath: self.fixture(.fileThatExists)))
    }

    func testIsSymbolicLinkOnDirectory() {
        XCTAssertFalse(try isSymbolicLink(atPath: self.fixture(.directoryThatExists)))
    }

    func testIsSymbolicLinkOnNonExistingPath() throws {
        XCTAssertThrowsError(try isSymbolicLink(atPath: self.fixture(.noneExistence))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testIsSymbolicLinkOnGoodFileSymbol() {
        XCTAssertTrue(try isSymbolicLink(atPath: self.fixture(.goodFileSymbol)))
    }

    func testIsSymbolicLinkOnGoodDirectorySymbol() {
        XCTAssertTrue(try isSymbolicLink(atPath: self.fixture(.goodDirectorySymbol)))
    }

    func testIsSymbolicLinkOnBadSymbol() {
        XCTAssertTrue(try isSymbolicLink(atPath: self.fixture(.badSymbol)))
    }

    func testPathRepresentableIsSymbolicLinkOnFile() {
        XCTAssertFalse(self.fixturePath(.fileThatExists).isSymbolicLink)
    }

    func testPathRepresentableIsSymbolicLinkOnDirectory() {
        XCTAssertFalse(self.fixturePath(.directoryThatExists).isSymbolicLink)
    }

    func testPathRepresentableIsSymbolicLinkOnNonExistingPath() {
        XCTAssertFalse(self.fixturePath(.noneExistence).isSymbolicLink)
    }

    func testPathRepresentableIsSymbolicLinkOnGoodFileSymbol() {
        XCTAssertTrue(self.fixturePath(.goodFileSymbol).isSymbolicLink)
    }

    func testPathRepresentableIsSymbolicLinkOnGoodDirectorySymbol() {
        XCTAssertTrue(self.fixturePath(.goodDirectorySymbol).isSymbolicLink)
    }

    func testPathRepresentableIsSymbolicLinkOnBadSymbol() {
        XCTAssertTrue(self.fixturePath(.badSymbol).isSymbolicLink)
    }
}
