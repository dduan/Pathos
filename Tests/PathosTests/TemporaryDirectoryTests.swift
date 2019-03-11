import Pathos
import XCTest

final class TemporaryDirectoryTests: XCTestCase {
    func testCreatingTemporaryDirectory() throws {
        let path = try createTemporaryDirectory()
        XCTAssert(try isDirectory(atPath: path))
        try deletePath(path)
    }

    func testCreatingTemporaryDirectoryWithPrefix() throws {
        let kPrefix = "kPrefix"
        let path = try createTemporaryDirectory(prefix: kPrefix)
        XCTAssertTrue(try isDirectory(atPath: path))
        XCTAssertTrue(split(path: path).1.hasPrefix(kPrefix), path)
        try deletePath(path)
    }

    func testCreatingTemporaryDirectoryWithSuffix() throws {
        let kSuffix = "kSuffix"
        let path = try createTemporaryDirectory(suffix: kSuffix)
        XCTAssertTrue(try isDirectory(atPath: path))
        XCTAssertTrue(split(path: path).1.hasSuffix(kSuffix))
        try deletePath(path)
    }

    func testCreatingTemporaryDirectoryInDirectory() throws {
        let directory = try createTemporaryDirectory()
        let path = try createTemporaryDirectory(inDirectory: directory)
        XCTAssertTrue(try isDirectory(atPath: path))
        XCTAssertTrue(path.hasPrefix(directory))
        try deletePath(path)
        try deletePath(directory)
    }

    func testTemporaryDirectoryClosure() throws {
        let startingDirectory = try getCurrentWorkingDirectory()
        var directory: String?
        var directoryExisted = false
        try withTemporaryDirectory() { temporaryDirectory in
            directory = temporaryDirectory
            directoryExisted = exists(atPath: temporaryDirectory)
        }

        XCTAssertEqual(try getCurrentWorkingDirectory(), startingDirectory)
        XCTAssertNotEqual(directory, startingDirectory)
        XCTAssertTrue(directoryExisted)
        XCTAssertFalse(directory.map { exists(atPath: $0) } ?? true)
    }

    func testPathRepresentableCreatingTemporaryDirectory() {
        guard let path = Path.createTemporaryDirectory() else {
            XCTFail("temprorary directory creation failed")
            return
        }

        XCTAssert(path.isDirectory)
        _ = path.delete()
    }

    func testPathRepresentableCreatingTemporaryDirectoryWithPrefix() {
        let kPrefix = "kPrefix"
        guard let path = Path.createTemporaryDirectory(prefix: kPrefix) else {
            XCTFail("temprorary directory creation failed")
            return
        }

        XCTAssert(path.isDirectory)
        XCTAssert(path.split().1.pathString.hasPrefix(kPrefix))
        _ = path.delete()
    }

    func testPathRepresentableCreatingTemporaryDirectoryWithSuffix() {
        let kSuffix = "kSuffix"
        guard let path = Path.createTemporaryDirectory(suffix: kSuffix) else {
            XCTFail("temprorary directory creation failed")
            return
        }

        XCTAssert(path.isDirectory)
        XCTAssert(path.split().1.pathString.hasSuffix(kSuffix))
        _ = path.delete()
    }

    func testPathRepresentableCreatingTemporaryDirectoryInDirectory() throws {
        let directory = try createTemporaryDirectory()
        guard let path = Path.createTemporaryDirectory(inDirectory: Path(directory)) else {
            XCTFail("temprorary directory creation failed")
            return
        }

        XCTAssert(path.isDirectory)
        XCTAssert(path.pathString.hasPrefix(directory))
        _ = path.delete()
        try deletePath(directory)
    }

    func testPathRepresentableTemporaryDirectoryClosure() throws {
        let startingDirectory = Path.currentWorkingDirectory
        var directory: Path?
        var directoryExisted = false

        Path.withTemporaryDirectory() { temporaryDirectory in
            directory = temporaryDirectory
            directoryExisted = temporaryDirectory.exists()
        }

        XCTAssertEqual(Path.currentWorkingDirectory.pathString, startingDirectory.pathString)
        XCTAssertNotEqual(directory?.pathString, startingDirectory.pathString)
        XCTAssertTrue(directoryExisted)
        XCTAssert(directory?.exists() == false)
    }
}
