import Pathos
import XCTest

final class MetadataTests: XCTestCase {
    func testRetrievingMetadata() throws {
        var metadata: Metadata!
        XCTAssertNoThrow(metadata = try Path(".").metadata())
        XCTAssertTrue(metadata.fileType.isDirectory)
    }
}
