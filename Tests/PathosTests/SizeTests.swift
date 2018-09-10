import Pathos
import XCTest

final class SizeTests: XCTestCase {
    func testSizeOfRegularFile() {
        XCTAssertEqual(try size(atPath: self.fixture(.fileThatExists)),
                       self.expectedSize(of: .fileThatExists))
    }

    func testSizeOfSymbolToRegularFile() {
        XCTAssertEqual(try size(atPath: self.fixture(.goodFileSymbol)),
                       self.expectedSize(of: .goodFileSymbol))
    }

    func testSizeOfDirectory() {
        XCTAssertEqual(try size(atPath: self.fixture(.directoryThatExists)),
                       self.expectedSize(of: .directoryThatExists))
    }

    func testSizeOfSymbolToDirectory() {
        XCTAssertEqual(try size(atPath: self.fixture(.goodDirectorySymbol)),
                       self.expectedSize(of: .goodDirectorySymbol))
    }

    func testSizeOfNonExistingPath() {
        XCTAssertThrowsError(try size(atPath: self.fixture(.noneExistence))) { error in
            guard case SystemError.noSuchFileOrDirectory = error else {
                XCTFail("expected SystemError.noSuchFileOrDirectory")
                return
            }
        }
    }

    func testPathRepresentableSizeOfRegularFile() {
        XCTAssertEqual(self.fixturePath(.fileThatExists).size,
                       self.expectedSize(of: .fileThatExists))
    }

    func testPathRepresentableSizeOfSymbolToRegularFile() {
        XCTAssertEqual(self.fixturePath(.goodFileSymbol).size,
                       self.expectedSize(of: .goodFileSymbol))
    }

    func testPathRepresentableSizeOfDirectory() {
        XCTAssertEqual(self.fixturePath(.directoryThatExists).size,
                       self.expectedSize(of: .directoryThatExists))
    }

    func testPathRepresentableSizeOfSymbolToDirectory() {
        XCTAssertEqual(self.fixturePath(.goodDirectorySymbol).size,
                       self.expectedSize(of: .goodDirectorySymbol))
    }

    func testPathRepresentableSizeOfNonExistingPath() {
        XCTAssertEqual(self.fixturePath(.noneExistence).size, 0)
    }
}
