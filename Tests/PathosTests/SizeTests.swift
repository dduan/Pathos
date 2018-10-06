import Pathos
import XCTest

final class SizeTests: XCTestCase {
    func testSizeOfRegularFile() {
        XCTAssertTrue(
            self.expectedSize(of: .fileThatExists).contains(try size(atPath: self.fixture(.fileThatExists)))
        )
    }

    func testSizeOfSymbolToRegularFile() {
        XCTAssertTrue(
            self.expectedSize(of: .goodFileSymbol).contains(try size(atPath: self.fixture(.goodFileSymbol)))
        )
    }

    func testSizeOfDirectory() {
        XCTAssertTrue(
            self.expectedSize(of: .directoryThatExists)
                .contains(try size(atPath: self.fixture(.directoryThatExists)))
        )
    }

    func testSizeOfSymbolToDirectory() {
        XCTAssertTrue(
            self.expectedSize(of: .goodDirectorySymbol)
                .contains(try size(atPath: self.fixture(.goodDirectorySymbol)))
        )
    }

    func testSizeOfNonExistingPath() throws {
        XCTAssertThrowsError(try size(atPath: self.fixture(.noneExistence))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testPathRepresentableSizeOfRegularFile() {
        XCTAssertTrue(self.expectedSize(of: .fileThatExists).contains(self.fixturePath(.fileThatExists).size))
    }

    func testPathRepresentableSizeOfSymbolToRegularFile() {
        XCTAssertTrue(self.expectedSize(of: .goodFileSymbol).contains(self.fixturePath(.goodFileSymbol).size))
    }

    func testPathRepresentableSizeOfDirectory() {
        XCTAssertTrue(
            self.expectedSize(of: .directoryThatExists).contains(self.fixturePath(.directoryThatExists).size)
        )
    }

    func testPathRepresentableSizeOfSymbolToDirectory() {
        XCTAssertTrue(
            self.expectedSize(of: .goodDirectorySymbol).contains(self.fixturePath(.goodDirectorySymbol).size)
        )
    }

    func testPathRepresentableSizeOfNonExistingPath() {
        XCTAssertEqual(self.fixturePath(.noneExistence).size, 0)
    }
}
