import Pathos
import XCTest

final class MetadataTests: XCTestCase {
    func testMetadataAccessing() throws {
        try XCTAssertEqual(
            metadata(atPath: self.fixture(.fileThatExists)).type,
            .file
        )
        try XCTAssertEqual(
            metadata(atPath: self.fixture(.directoryThatExists)).type,
            .directory
        )
    }

    func testPathRepresentableMetadataAccessing() throws {
        try XCTAssertEqual(
            XCTUnwrap(self.fixturePath(.fileThatExists).metadata()).type,
            .file
        )
        try XCTAssertEqual(
            XCTUnwrap(self.fixturePath(.directoryThatExists).metadata()).type,
            .directory
        )
    }
}
