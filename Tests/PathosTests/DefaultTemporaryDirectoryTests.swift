import Pathos
import XCTest

final class DefaultTemporaryDirectoryTests: XCTestCase {
    func testDefaultsTemporaryDirectory() throws {
        XCTAssertTrue(exists(atPath: defaultTemporaryDirectory))
        let permissions = try Pathos.permissions(forPath: defaultTemporaryDirectory)
        XCTAssertTrue(permissions.contains([.ownerRead, .ownerWrite]))
    }

    func testPathRepresentableDefaultsTemporaryDirectory() throws {
        XCTAssertTrue(Path.defaultTemporaryDirectory.exists())
        let permissions = Path.defaultTemporaryDirectory.permissions
        XCTAssertTrue(permissions.contains([.ownerRead, .ownerWrite]))
    }
}
