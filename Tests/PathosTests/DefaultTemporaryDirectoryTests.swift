import Pathos
import XCTest

final class DefaultTemporaryDirectoryTests: XCTestCase {
    func testDefaultsTemporaryDirectory() throws {
        XCTAssertTrue(exists(atPath: defaultTemporaryDirectory))
        let permissions = try Pathos.permissions(forPath: defaultTemporaryDirectory)
        XCTAssertTrue(permissions.contains([.ownerRead, .ownerWrite]))
    }

    func testPathRepresentableDefaultsTemporaryDirectory() throws {
        XCTAssertTrue(exists(atPath: Path.defaultTemporaryDirectory))
        let permissions = try Pathos.permissions(forPath: Path.defaultTemporaryDirectory)
        XCTAssertTrue(permissions.contains([.ownerRead, .ownerWrite]))
    }
}
