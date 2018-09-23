import Pathos
import XCTest

final class MakeDirectoryTests: XCTestCase {
    private var randomTmpDirectoryPath: String {
        return join(path: "/tmp", withPath: String(UInt64.random(in: .min ... .max)))
    }

    func testMakeDiroctory() throws {
        let directory = self.randomTmpDirectoryPath
        try makeDirectory(atPath: directory)
        XCTAssertTrue(try isDirectory(atPath: directory))
        var status = stat()
        lstat(directory, &status)
        XCTAssertEqual(status.st_mode & 0o7777, 0o0755)
        rmdir(directory)
    }

    func testMakeExistingDirectory() throws {
        let exstingDirectory = self.randomTmpDirectoryPath
        try makeDirectory(atPath: exstingDirectory)
        XCTAssertThrowsError(try makeDirectory(atPath: exstingDirectory)) { error in
            guard case SystemError.fileExists = error else {
                XCTFail("unexpected error thrown by makeDirectory")
                return
            }
        }
        rmdir(exstingDirectory)
    }

    func testMakeExistingDirectoryExistOkay() throws {
        let exstingDirectory = self.randomTmpDirectoryPath
        try makeDirectory(atPath: exstingDirectory)
        try makeDirectory(atPath: exstingDirectory, existOkay: true)
        XCTAssertTrue(try isDirectory(atPath: exstingDirectory))
        rmdir(exstingDirectory)
    }

    func testMakeDirectoryWithNonExistParentShouldFail() {
        let path = join(path: self.randomTmpDirectoryPath, withPath: "a/b/c")
        XCTAssertThrowsError(try makeDirectory(atPath: path))
        XCTAssertFalse(exists(atPath: path))
    }

    func testMakeDirectoryWithCreateParent() throws {
        let path = join(path: self.randomTmpDirectoryPath, withPath: "a/b/c")
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
        let exstingDirectory = self.randomTmpDirectoryPath
        try makeDirectory(atPath: exstingDirectory)
        XCTAssertFalse(Path(string: exstingDirectory).makeDirectory())
        rmdir(exstingDirectory)
    }

    func testPathRepresentableMakeExistingDirectoryExistOkay() throws {
        let exstingDirectory = self.randomTmpDirectoryPath
        try makeDirectory(atPath: exstingDirectory)
        XCTAssertTrue(Path(string: exstingDirectory).makeDirectory(existOkay: true))
        XCTAssertTrue(try isDirectory(atPath: exstingDirectory))
        rmdir(exstingDirectory)
    }

    func testPathRepresentableMakeDirectoryWithNonExistParentShouldFail() {
        let path = join(path: self.randomTmpDirectoryPath, withPath: "a/b/c")
        XCTAssertFalse(Path(string: path).makeDirectory())
        XCTAssertFalse(exists(atPath: path))
    }

    func testPathRepresentableMakeDirectoryWithCreateParent() {
        let path = join(path: self.randomTmpDirectoryPath, withPath: "a/b/c")
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
