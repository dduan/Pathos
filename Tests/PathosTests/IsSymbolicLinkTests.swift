import Pathos
import XCTest

final class IsSymbolicLinkTests: XCTestCase {
    func testIsSymbolicLinkOnFile() {
        XCTAssertFalse(try isA(.symbolicLink, atPath: self.fixture(.fileThatExists)))
    }

    func testIsSymbolicLinkOnDirectory() {
        XCTAssertFalse(try isA(.symbolicLink, atPath: self.fixture(.directoryThatExists)))
    }

    func testIsSymbolicLinkOnNonExistingPath() throws {
        XCTAssertThrowsError(try isA(.symbolicLink, atPath: self.fixture(.noneExistence))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testIsSymbolicLinkOnGoodFileSymbol() {
        XCTAssertTrue(try isA(.symbolicLink, atPath: self.fixture(.goodFileSymbol)))
    }

    func testIsSymbolicLinkOnGoodDirectorySymbol() {
        XCTAssertTrue(try isA(.symbolicLink, atPath: self.fixture(.goodDirectorySymbol)))
    }

    func testIsSymbolicLinkOnBadSymbol() {
        XCTAssertTrue(try isA(.symbolicLink, atPath: self.fixture(.badSymbol)))
    }

    func testPathRepresentableIsSymbolicLinkOnFile() {
        XCTAssertFalse(self.fixturePath(.fileThatExists).isA(.symbolicLink))
    }

    func testPathRepresentableIsSymbolicLinkOnDirectory() {
        XCTAssertFalse(self.fixturePath(.directoryThatExists).isA(.symbolicLink))
    }

    func testPathRepresentableIsSymbolicLinkOnNonExistingPath() {
        XCTAssertFalse(self.fixturePath(.noneExistence).isA(.symbolicLink))
    }

    func testPathRepresentableIsSymbolicLinkOnGoodFileSymbol() {
        XCTAssertTrue(self.fixturePath(.goodFileSymbol).isA(.symbolicLink))
    }

    func testPathRepresentableIsSymbolicLinkOnGoodDirectorySymbol() {
        XCTAssertTrue(self.fixturePath(.goodDirectorySymbol).isA(.symbolicLink))
    }

    func testPathRepresentableIsSymbolicLinkOnBadSymbol() {
        XCTAssertTrue(self.fixturePath(.badSymbol).isA(.symbolicLink))
    }
}
