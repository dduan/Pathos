import Pathos
import XCTest

#if !os(Windows)
final class SameFileTests: XCTestCase {
    func testSameFileAsSymlink() {
        XCTAssertTrue(try sameFile(
            atPath: self.fixture(.fileThatExists),
            otherPath: self.fixture(.fileThatExists)))
        XCTAssertTrue(try sameFile(
            atPath: self.fixture(.fileThatExists),
            otherPath: self.fixture(.goodFileSymbol)))
        XCTAssertTrue(try sameFile(
            atPath: self.fixture(.directoryThatExists),
            otherPath: self.fixture(.goodDirectorySymbol)))
    }

    func testNotSameFile() {
        XCTAssertFalse(try sameFile(
            atPath: self.fixture(.fileThatExists),
            otherPath: self.fixture(.directoryThatExists)))
        XCTAssertFalse(try sameFile(
            atPath: self.fixture(.fileThatExists),
            otherPath: self.fixture(.fileInDirectory)))
    }

    func testPathRepresentableSameFileAsSymlink() {
        XCTAssertTrue(self.fixturePath(.fileThatExists)
            .isSame(as: self.fixturePath(.fileThatExists)))
        XCTAssertTrue(self.fixturePath(.fileThatExists)
            .isSame(as: self.fixturePath(.goodFileSymbol)))
        XCTAssertTrue(self.fixturePath(.directoryThatExists)
            .isSame(as: self.fixturePath(.goodDirectorySymbol)))
    }

    func testPathRepresentableNotSameFile() {
        XCTAssertFalse(self.fixturePath(.fileThatExists)
            .isSame(as: self.fixturePath(.directoryThatExists)))
        XCTAssertFalse(self.fixturePath(.fileThatExists)
            .isSame(as: self.fixturePath(.fileInDirectory)))
    }
}
#endif
