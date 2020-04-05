import Pathos
import XCTest

final class PermissionsTests: XCTestCase {
    func testReadingDefaultPermissions() throws {
        let destination = try createTemporaryFile()
        let expectedPermissions: FilePermission = [.ownerRead, .ownerWrite, .otherRead, .groupRead]
        XCTAssertEqual(try metadata(atPath: destination).permissions, expectedPermissions)
    }

    func testSettingPermissions() throws {
        let destination = try createTemporaryFile()
        let expectedPermissions: FilePermission = [.ownerRead, .ownerWrite, .otherRead, .groupRead]
        XCTAssertEqual(try metadata(atPath: destination).permissions, expectedPermissions)
        let resultPermissions: FilePermission = [.ownerRead, .ownerWrite]

        try set(resultPermissions, forPath: destination)

        XCTAssertEqual(try metadata(atPath: destination).permissions, resultPermissions)
    }

    func testPathRepresentableReadingDefaultPermissions() {
        let destination = Path.createTemporaryFile()!
        let expectedPermissions: FilePermission = [.ownerRead, .ownerWrite, .otherRead, .groupRead]
        XCTAssertEqual(destination.metadata()?.permissions, .some(expectedPermissions))
    }

    func testPathRepresentableSettingPermissions() throws {
        let destination = Path.createTemporaryFile()!
        let expectedPermissions: FilePermission = [.ownerRead, .ownerWrite, .otherRead, .groupRead]
        XCTAssertEqual(try metadata(atPath: destination.pathString).permissions, expectedPermissions)
        let resultPermissions: FilePermission = [.ownerRead, .ownerWrite]

        destination.set(resultPermissions)

        XCTAssertEqual(destination.metadata()?.permissions, .some(resultPermissions))
    }
}
