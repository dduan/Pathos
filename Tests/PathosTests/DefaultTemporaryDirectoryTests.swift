import Pathos
import XCTest

#if !os(Windows)
final class DefaultTemporaryDirectoryTests: XCTestCase {
    func testDefaultsTemporaryDirectory() throws {
        XCTAssertTrue(exists(atPath: defaultTemporaryDirectory))
        let permissions = try metadata(atPath: defaultTemporaryDirectory).permissions
        XCTAssertTrue(permissions.contains([.ownerRead, .ownerWrite]))
    }

    func testPathRepresentableDefaultsTemporaryDirectory() throws {
        XCTAssertTrue(Path.defaultTemporaryDirectory.exists())
        let permissions = try XCTUnwrap(Path.defaultTemporaryDirectory.metadata()).permissions
        XCTAssertTrue(permissions.contains([.ownerRead, .ownerWrite]))
    }
}
#endif
