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

    func testAddingPermissions() throws {
        let destination = try createTemporaryFile()
        let initialPermissions: FilePermission = [.ownerRead, .ownerWrite, .otherRead, .groupRead]
        XCTAssertEqual(try metadata(atPath: destination).permissions, initialPermissions)
        let newPermission: FilePermission = .ownerExecute
        let resultPermissions: FilePermission = initialPermissions.union(newPermission)

        try Pathos.add(newPermission, forPath: destination)

        XCTAssertEqual(try metadata(atPath: destination).permissions, resultPermissions)
    }

    func testRemovingPermissions() throws {
        let destination = try createTemporaryFile()
        let initialPermissions: FilePermission = [.ownerRead, .ownerWrite, .otherRead, .groupRead]
        XCTAssertEqual(try metadata(atPath: destination).permissions, initialPermissions)
        let permissionToRemove: FilePermission = .ownerExecute
        let resultPermissions: FilePermission = initialPermissions.subtracting(permissionToRemove)

        try Pathos.remove(permissionToRemove, forPath: destination)

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

    func testPathRepresentableAddingPermissions() throws {
        let destination = Path.createTemporaryFile()!
        let initialPermissions: FilePermission = [.ownerRead, .ownerWrite, .otherRead, .groupRead]
        XCTAssertEqual(try metadata(atPath: destination.pathString).permissions, initialPermissions)
        let newPermission: FilePermission = .ownerExecute
        let resultPermissions: FilePermission = initialPermissions.union(newPermission)

        destination.add(newPermission)

        XCTAssertEqual(destination.metadata()?.permissions, .some(resultPermissions))
    }

    func testPathRepresentableRemovingPermissions() throws {
        let destination = Path.createTemporaryFile()!
        let initialPermissions: FilePermission = [.ownerRead, .ownerWrite, .otherRead, .groupRead]
        XCTAssertEqual(try metadata(atPath: destination.pathString).permissions, initialPermissions)
        let permissionToRemove: FilePermission = .ownerExecute
        let resultPermissions: FilePermission = initialPermissions.subtracting(permissionToRemove)

        destination.remove(permissionToRemove)

        XCTAssertEqual(destination.metadata()?.permissions, .some(resultPermissions))
    }
}
