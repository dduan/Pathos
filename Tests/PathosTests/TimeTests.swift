import Pathos
import XCTest

final class TimeTests: XCTestCase {
    func testModificationTime() throws {
        XCTAssertNoThrow(try modificationTime(atPath: self.fixture(.fileThatExists)))
        XCTAssertNoThrow(try modificationTime(atPath: self.fixture(.directoryThatExists)))
        XCTAssertNoThrow(try modificationTime(atPath: self.fixture(.goodFileSymbol)))
    }

    func testAccessTime() throws {
        XCTAssertNoThrow(try accessTime(atPath: self.fixture(.fileThatExists)))
        XCTAssertNoThrow(try accessTime(atPath: self.fixture(.directoryThatExists)))
        XCTAssertNoThrow(try accessTime(atPath: self.fixture(.goodFileSymbol)))
    }

    func testMetadataChangeTime() throws {
        XCTAssertNoThrow(try metadataChangeTime(atPath: self.fixture(.fileThatExists)))
        XCTAssertNoThrow(try metadataChangeTime(atPath: self.fixture(.directoryThatExists)))
        XCTAssertNoThrow(try metadataChangeTime(atPath: self.fixture(.goodFileSymbol)))
    }

    func testPathRepresentableModificationTime() throws {
        XCTAssertNotNil(self.fixturePath(.fileThatExists).modificationTime)
        XCTAssertNotNil(self.fixturePath(.directoryThatExists).modificationTime)
        XCTAssertNotNil(self.fixturePath(.goodFileSymbol).modificationTime)
    }

    func testPathRepresentableAccessTime() throws {
        XCTAssertNotNil(self.fixturePath(.fileThatExists).accessTime)
        XCTAssertNotNil(self.fixturePath(.directoryThatExists).accessTime)
        XCTAssertNotNil(self.fixturePath(.goodFileSymbol).accessTime)
    }

    func testPathRepresentableMetadataChangeTime() throws {
        XCTAssertNotNil(self.fixturePath(.fileThatExists).metadataChangeTime)
        XCTAssertNotNil(self.fixturePath(.directoryThatExists).metadataChangeTime)
        XCTAssertNotNil(self.fixturePath(.goodFileSymbol).metadataChangeTime)
    }
}
