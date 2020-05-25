import Pathos
import XCTest

#if !os(Windows)
final class IsDirectoryTests: XCTestCase {
    func testIsDirectoryOnExistingFile() {
        XCTAssertFalse(try isA(.directory, atPath: self.fixture(.fileThatExists)))
    }

    func testIsDirectoryOnExistingDirectory() {
        XCTAssertTrue(try isA(.directory, atPath: self.fixture(.directoryThatExists)))
    }

    func testIsDirectoryOnNonExistingPath() {
        XCTAssertThrowsError(try isA(.directory, atPath: self.fixture(.noneExistence))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testIsDirectoryOnSymlink() {
        XCTAssertFalse(try isA(.directory, atPath: self.fixture(.goodFileSymbol)))
    }

    func testIsDirectoryOnSymbolicDirectoryLink() {
        XCTAssertTrue(try isA(.directory, atPath: self.fixture(.goodDirectorySymbol)))
    }

    func testIsDirectoryOnBadSymlink() throws {
        XCTAssertThrowsError(try isA(.directory, atPath: self.fixture(.badSymbol))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testDirectoryRepresentableIsFileOnExistingFile() {
        XCTAssertFalse(self.fixturePath(.fileThatExists).isA(.directory))
    }

    func testDirectoryRepresentableIsFileOnExistingDirectory() {
        XCTAssertTrue(self.fixturePath(.directoryThatExists).isA(.directory))
    }

    func testDirectoryRepresentableIsFileOnNonExistingFile() {
        XCTAssertFalse(self.fixturePath(.noneExistence).isA(.directory))
    }

    func testPathRepresentableIsDirectoryOnSymlink() {
        XCTAssertFalse(self.fixturePath(.goodFileSymbol).isA(.directory))
    }

    func testPathRepresentableIsDirectoryOnSymbolicDirectoryLink() {
        XCTAssertTrue(self.fixturePath(.goodDirectorySymbol).isA(.directory))
    }

    func testPathRepresentableIsDirectoryOnBadSymlink() {
        XCTAssertFalse(self.fixturePath(.badSymbol).isA(.directory))
    }
}
#endif
