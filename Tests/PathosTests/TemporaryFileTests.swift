import Pathos
import XCTest

final class TemporaryFileTests: XCTest {
    func testCreatingTemporaryDirectory() throws {
        let path = try makeTemporaryFile()
        XCTAssert(try isFile(atPath: path))
        try deletePath(path)
    }

    func testCreatingTemporaryDirectoryWithPrefix() throws {
        let kPrefix = "kPrefix"
        let path = try makeTemporaryFile(prefix: kPrefix)
        XCTAssert(try isFile(atPath: path))
        XCTAssert(path.hasPrefix(kPrefix))
        try deletePath(path)
    }

    func testCreatingTemporaryDirectoryWithSuffix() throws {
        let kSuffix = "kSuffix"
        let path = try makeTemporaryFile(suffix: kSuffix)
        XCTAssert(try isFile(atPath: path))
        XCTAssert(path.hasSuffix(kSuffix))
        try deletePath(path)
    }

    func testCreatingTemporaryDirectoryInDirectory() throws {
        let directory = try makeTemporaryFile()
        let path = try makeTemporaryFile(inDirectory: directory)
        XCTAssert(try isFile(atPath: path))
        XCTAssert(path.hasPrefix(directory))
        try deletePath(path)
        try deletePath(directory)
    }

    func testPathRepresentableCreatingTemporaryDirectory() {
        guard let path = Path.makeTemporaryFile() else {
            XCTFail("temprorary directory creation failed")
            return
        }

        XCTAssert(path.isFile)
        _ = path.delete()
    }

    func testPathRepresentableCreatingTemporaryDirectoryWithPrefix() {
        let kPrefix = "kPrefix"
        guard let path = Path.makeTemporaryFile(prefix: kPrefix) else {
            XCTFail("temprorary directory creation failed")
            return
        }

        XCTAssert(path.isFile)
        XCTAssert(path.pathString.hasPrefix(kPrefix))
        _ = path.delete()
    }

    func testPathRepresentableCreatingTemporaryDirectoryWithSuffix() {
        let kSuffix = "kSuffix"
        guard let path = Path.makeTemporaryFile(suffix: kSuffix) else {
            XCTFail("temprorary directory creation failed")
            return
        }

        XCTAssert(path.isFile)
        XCTAssert(path.pathString.hasSuffix(kSuffix))
        _ = path.delete()
    }

    func testPathRepresentableCreatingTemporaryDirectoryInDirectory() throws {
        let directory = try makeTemporaryFile()
        guard let path = Path.makeTemporaryFile(inDirectory: directory) else {
            XCTFail("temprorary directory creation failed")
            return
        }

        XCTAssert(path.isFile)
        XCTAssert(path.pathString.hasPrefix(directory))
        _ = path.delete()
        try deletePath(directory)
    }
}
