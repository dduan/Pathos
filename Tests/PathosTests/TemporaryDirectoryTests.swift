import Pathos
import XCTest

final class TemporaryDirectoryTests: XCTest {
    func testCreatingTemporaryDirectory() throws {
        let path = try makeTemporaryDirectory()
        XCTAssert(try isDirectory(atPath: path))
        try deletePath(path)
    }

    func testCreatingTemporaryDirectoryWithPrefix() throws {
        let kPrefix = "kPrefix"
        let path = try makeTemporaryDirectory(prefix: kPrefix)
        XCTAssert(try isDirectory(atPath: path))
        XCTAssert(path.hasPrefix(kPrefix))
        try deletePath(path)
    }

    func testCreatingTemporaryDirectoryWithSuffix() throws {
        let kSuffix = "kSuffix"
        let path = try makeTemporaryDirectory(suffix: kSuffix)
        XCTAssert(try isDirectory(atPath: path))
        XCTAssert(path.hasSuffix(kSuffix))
        try deletePath(path)
    }

    func testCreatingTemporaryDirectoryInDirectory() throws {
        let directory = try makeTemporaryDirectory()
        let path = try makeTemporaryDirectory(inDirectory: directory)
        XCTAssert(try isDirectory(atPath: path))
        XCTAssert(path.hasPrefix(directory))
        try deletePath(path)
        try deletePath(directory)
    }

    func testPathRepresentableCreatingTemporaryDirectory() {
        guard let path = Path.makeTemporaryDirectory() else {
            XCTFail("temprorary directory creation failed")
            return
        }

        XCTAssert(path.isDirectory)
        _ = path.delete()
    }

    func testPathRepresentableCreatingTemporaryDirectoryWithPrefix() {
        let kPrefix = "kPrefix"
        guard let path = Path.makeTemporaryDirectory(prefix: kPrefix) else {
            XCTFail("temprorary directory creation failed")
            return
        }

        XCTAssert(path.isDirectory)
        XCTAssert(path.pathString.hasPrefix(kPrefix))
        _ = path.delete()
    }

    func testPathRepresentableCreatingTemporaryDirectoryWithSuffix() {
        let kSuffix = "kSuffix"
        guard let path = Path.makeTemporaryDirectory(suffix: kSuffix) else {
            XCTFail("temprorary directory creation failed")
            return
        }

        XCTAssert(path.isDirectory)
        XCTAssert(path.pathString.hasSuffix(kSuffix))
        _ = path.delete()
    }

    func testPathRepresentableCreatingTemporaryDirectoryInDirectory() throws {
        let directory = try makeTemporaryDirectory()
        guard let path = Path.makeTemporaryDirectory(inDirectory: directory) else {
            XCTFail("temprorary directory creation failed")
            return
        }

        XCTAssert(path.isDirectory)
        XCTAssert(path.pathString.hasPrefix(directory))
        _ = path.delete()
        try deletePath(directory)
    }
}
