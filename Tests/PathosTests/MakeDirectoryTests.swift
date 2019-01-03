import Pathos
import XCTest

final class MakeDirectoryTests: XCTestCase {
    private var randomTmpDirectoryPath: String {
        return join(paths: "/tmp", String(UInt64.random(in: .min ... .max)))
    }

    func testMakeDirectory() throws {
        let directory = self.randomTmpDirectoryPath
        try makeDirectory(atPath: directory)
        XCTAssertTrue(try isDirectory(atPath: directory))
        var status = stat()
        lstat(directory, &status)
        XCTAssertEqual(status.st_mode & 0o7777, 0o0755)
        rmdir(directory)
    }

    func testMakeExistingDirectory() throws {
        let existingDirectory = self.randomTmpDirectoryPath
        try makeDirectory(atPath: existingDirectory)
        XCTAssertThrowsError(try makeDirectory(atPath: existingDirectory)) { error in
            guard case SystemError.fileExists = error else {
                XCTFail("unexpected error thrown by makeDirectory")
                return
            }
        }
        rmdir(existingDirectory)
    }

    func testMakeExistingDirectoryExistOkay() throws {
        let existingDirectory = self.randomTmpDirectoryPath
        try makeDirectory(atPath: existingDirectory)
        try makeDirectory(atPath: existingDirectory, existOkay: true)
        XCTAssertTrue(try isDirectory(atPath: existingDirectory))
        rmdir(existingDirectory)
    }

    func testMakeDirectoryWithNonExistParentShouldFail() {
        let path = join(paths: self.randomTmpDirectoryPath, "a/b/c")
        XCTAssertThrowsError(try makeDirectory(atPath: path))
        XCTAssertFalse(exists(atPath: path))
    }

    func testMakeDirectoryWithCreateParent() throws {
        let path = join(paths: self.randomTmpDirectoryPath, "a/b/c")
        try makeDirectory(atPath: path, createParents: true)
        XCTAssertTrue(try isDirectory(atPath: path))
        rmdir(path)
    }

    func testMakeDirectoryWithSpecificPermission() throws {
        let directory = self.randomTmpDirectoryPath
        let permission: FilePermission = 0o0744
        try makeDirectory(atPath: directory, permission: permission)
        XCTAssertTrue(try isDirectory(atPath: directory))
        var status = stat()
        lstat(directory, &status)
        XCTAssertEqual(status.st_mode & 0o7777, permission.rawValue)
        rmdir(directory)
    }

    func testPathRepresentableMakeDiroctory() throws {
        let directory = self.randomTmpDirectoryPath
        XCTAssertTrue(Path(string: directory).makeDirectory())
        XCTAssertTrue(try isDirectory(atPath: directory))
        var status = stat()
        lstat(directory, &status)
        XCTAssertEqual(status.st_mode & 0o7777, 0o0755)
        rmdir(directory)
    }

    func testPathRepresentableMakeExistingDirectory() throws {
        let existingDirectory = self.randomTmpDirectoryPath
        try makeDirectory(atPath: existingDirectory)
        XCTAssertFalse(Path(string: existingDirectory).makeDirectory())
        rmdir(existingDirectory)
    }

    func testPathRepresentableMakeExistingDirectoryExistOkay() throws {
        let existingDirectory = self.randomTmpDirectoryPath
        try makeDirectory(atPath: existingDirectory)
        XCTAssertTrue(Path(string: existingDirectory).makeDirectory(existOkay: true))
        XCTAssertTrue(try isDirectory(atPath: existingDirectory))
        rmdir(existingDirectory)
    }

    func testPathRepresentableMakeDirectoryWithNonExistParentShouldFail() {
        let path = join(paths: self.randomTmpDirectoryPath, "a/b/c")
        XCTAssertFalse(Path(string: path).makeDirectory())
        XCTAssertFalse(exists(atPath: path))
    }

    func testPathRepresentableMakeDirectoryWithCreateParent() {
        let path = join(paths: self.randomTmpDirectoryPath, "a/b/c")
        XCTAssertTrue(Path(string: path).makeDirectory(createParents: true))
        XCTAssertTrue(try isDirectory(atPath: path))
        rmdir(path)
    }

    func testPathRepresentableMakeDirectoryWithSpecificPermission() throws {
        let directory = self.randomTmpDirectoryPath
        let permission: FilePermission = 0o0744
        XCTAssertTrue(Path(string: directory).makeDirectory(permission: permission))
        XCTAssertTrue(try isDirectory(atPath: directory))
        var status = stat()
        lstat(directory, &status)
        XCTAssertEqual(status.st_mode & 0o7777, permission.rawValue)
        rmdir(directory)
    }
}
