import Pathos
import XCTest

final class MakeDirectoryTests: XCTestCase {
    private var randomTmpDirectoryPath: String {
        return join(paths: "/tmp", String(UInt64.random(in: .min ... .max)))
    }

    func testMakeDirectory() throws {
        let directory = self.randomTmpDirectoryPath
        try createDirectory(atPath: directory)
        XCTAssertTrue(try isDirectory(atPath: directory))
        var status = stat()
        lstat(directory, &status)
        XCTAssertEqual(status.st_mode & 0o7777, 0o0755)
        rmdir(directory)
    }

    func testMakeExistingDirectory() throws {
        let existingDirectory = self.randomTmpDirectoryPath
        try createDirectory(atPath: existingDirectory)
        XCTAssertThrowsError(try createDirectory(atPath: existingDirectory, throwIfAlreadyExists: true)) { error in
            guard case SystemError.fileExists = error else {
                XCTFail("unexpected error thrown by createDirectory")
                return
            }
        }
        rmdir(existingDirectory)
    }

    func testMakeExistingDirectoryExistOkay() throws {
        let existingDirectory = self.randomTmpDirectoryPath
        try createDirectory(atPath: existingDirectory)
        try createDirectory(atPath: existingDirectory)
        XCTAssertTrue(try isDirectory(atPath: existingDirectory))
        rmdir(existingDirectory)
    }

    func testMakeDirectoryWithNonExistParentShouldFail() {
        let path = join(paths: self.randomTmpDirectoryPath, "a/b/c")
        XCTAssertThrowsError(try createDirectory(atPath: path))
        XCTAssertFalse(exists(atPath: path))
    }

    func testMakeDirectoryWithCreateParent() throws {
        let path = join(paths: self.randomTmpDirectoryPath, "a/b/c")
        try createDirectory(atPath: path, createParents: true)
        XCTAssertTrue(try isDirectory(atPath: path))
        rmdir(path)
    }

    func testMakeDirectoryWithSpecificPermission() throws {
        let directory = self.randomTmpDirectoryPath
        let permission: FilePermission = 0o0744
        try createDirectory(atPath: directory, permission: permission)
        XCTAssertTrue(try isDirectory(atPath: directory))
        var status = stat()
        lstat(directory, &status)
        XCTAssertEqual(status.st_mode & 0o7777, permission.rawValue)
        rmdir(directory)
    }

    func testPathRepresentableMakeDiroctory() throws {
        let directory = self.randomTmpDirectoryPath
        XCTAssertTrue(Path(directory).createDirectory())
        XCTAssertTrue(try isDirectory(atPath: directory))
        var status = stat()
        lstat(directory, &status)
        XCTAssertEqual(status.st_mode & 0o7777, 0o0755)
        rmdir(directory)
    }

    func testPathRepresentableMakeExistingDirectory() throws {
        let existingDirectory = self.randomTmpDirectoryPath
        try createDirectory(atPath: existingDirectory)
        XCTAssertFalse(Path(existingDirectory).createDirectory(failIfAlreadyExists: true))
        rmdir(existingDirectory)
    }

    func testPathRepresentableMakeExistingDirectoryExistOkay() throws {
        let existingDirectory = self.randomTmpDirectoryPath
        try createDirectory(atPath: existingDirectory)
        XCTAssertTrue(Path(existingDirectory).createDirectory())
        XCTAssertTrue(try isDirectory(atPath: existingDirectory))
        rmdir(existingDirectory)
    }

    func testPathRepresentableMakeDirectoryWithNonExistParentShouldFail() {
        let path = join(paths: self.randomTmpDirectoryPath, "a/b/c")
        XCTAssertFalse(Path(path).createDirectory())
        XCTAssertFalse(exists(atPath: path))
    }

    func testPathRepresentableMakeDirectoryWithCreateParent() {
        let path = join(paths: self.randomTmpDirectoryPath, "a/b/c")
        XCTAssertTrue(Path(path).createDirectory(createParents: true))
        XCTAssertTrue(try isDirectory(atPath: path))
        rmdir(path)
    }

    func testPathRepresentableMakeDirectoryWithSpecificPermission() throws {
        let directory = self.randomTmpDirectoryPath
        let permission: FilePermission = 0o0744
        XCTAssertTrue(Path(directory).createDirectory(permission: permission))
        XCTAssertTrue(try isDirectory(atPath: directory))
        var status = stat()
        lstat(directory, &status)
        XCTAssertEqual(status.st_mode & 0o7777, permission.rawValue)
        rmdir(directory)
    }
}
