import Pathos
import XCTest

final class PermissionsTests: XCTestCase {
    func testReadingDefaultPermissions() throws {
        let destination = try createTemporaryFile()
        let expectedPermissions: FilePermission = [.ownerRead, .ownerWrite, .otherRead, .groupRead]
        XCTAssertEqual(try permissions(forPath: destination), expectedPermissions)
    }

    func testSettingPermissions() throws {
        let destination = try createTemporaryFile()
        let expectedPermissions: FilePermission = [.ownerRead, .ownerWrite, .otherRead, .groupRead]
        XCTAssertEqual(try permissions(forPath: destination), expectedPermissions)
        let resultPermissions: FilePermission = [.ownerRead, .ownerWrite]

        try set(resultPermissions, forPath: destination)

        XCTAssertEqual(try permissions(forPath: destination), resultPermissions)
    }

    func testAddingPermissions() throws {
        let destination = try createTemporaryFile()
        let initialPermissions: FilePermission = [.ownerRead, .ownerWrite, .otherRead, .groupRead]
        XCTAssertEqual(try permissions(forPath: destination), initialPermissions)
        let newPermission: FilePermission = .ownerExecute
        let resultPermissions: FilePermission = initialPermissions.union(newPermission)

        try Pathos.add(newPermission, toPath: destination)

        XCTAssertEqual(try permissions(forPath: destination), resultPermissions)
    }

    func testRemovingPermissions() throws {
        let destination = try createTemporaryFile()
        let initialPermissions: FilePermission = [.ownerRead, .ownerWrite, .otherRead, .groupRead]
        XCTAssertEqual(try permissions(forPath: destination), initialPermissions)
        let permissionToRemove: FilePermission = .ownerExecute
        let resultPermissions: FilePermission = initialPermissions.subtracting(permissionToRemove)

        try Pathos.remove(permissionToRemove, forPath: destination)

        XCTAssertEqual(try permissions(forPath: destination), resultPermissions)
    }

    func testPathRepresentableReadingDefaultPermissions() {
        let destination = Path.createTemporaryFile()!
        let expectedPermissions: FilePermission = [.ownerRead, .ownerWrite, .otherRead, .groupRead]
        XCTAssertEqual(destination.permissions, expectedPermissions)
    }

    func testPathRepresentableSettingPermissions() throws {
        var destination = Path.createTemporaryFile()!
        let expectedPermissions: FilePermission = [.ownerRead, .ownerWrite, .otherRead, .groupRead]
        XCTAssertEqual(try permissions(forPath: destination.pathString), expectedPermissions)
        let resultPermissions: FilePermission = [.ownerRead, .ownerWrite]

        destination.permissions = resultPermissions

        XCTAssertEqual(destination.permissions, resultPermissions)
    }

    func testPathRepresentableAddingPermissions() throws {
        let destination = Path.createTemporaryFile()!
        let initialPermissions: FilePermission = [.ownerRead, .ownerWrite, .otherRead, .groupRead]
        XCTAssertEqual(try permissions(forPath: destination.pathString), initialPermissions)
        let newPermission: FilePermission = .ownerExecute
        let resultPermissions: FilePermission = initialPermissions.union(newPermission)

        destination.add(newPermission)

        XCTAssertEqual(destination.permissions, resultPermissions)
    }

    func testPathRepresentableRemovingPermissions() throws {
        let destination = Path.createTemporaryFile()!
        let initialPermissions: FilePermission = [.ownerRead, .ownerWrite, .otherRead, .groupRead]
        XCTAssertEqual(try permissions(forPath: destination.pathString), initialPermissions)
        let permissionToRemove: FilePermission = .ownerExecute
        let resultPermissions: FilePermission = initialPermissions.subtracting(permissionToRemove)

        destination.remove(permissionToRemove)

        XCTAssertEqual(destination.permissions, resultPermissions)
    }
}
