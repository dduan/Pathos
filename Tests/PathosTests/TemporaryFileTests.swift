import Pathos
import XCTest

#if !os(Windows)
final class TemporaryFileTests: XCTestCase {
    func testCreatingTemporaryDirectory() throws {
        let path = try createTemporaryFile()
        XCTAssert(try isA(.file, atPath: path))
        try deletePath(path)
    }

    func testCreatingTemporaryDirectoryWithPrefix() throws {
        let kPrefix = "kPrefix"
        let path = try createTemporaryFile(prefix: kPrefix)
        XCTAssert(try isA(.file, atPath: path))
        XCTAssert(split(path: path).1.hasPrefix(kPrefix))
        try deletePath(path)
    }

    func testCreatingTemporaryDirectoryWithSuffix() throws {
        let kSuffix = "kSuffix"
        let path = try createTemporaryFile(suffix: kSuffix)
        XCTAssert(try isA(.file, atPath: path))
        XCTAssert(path.hasSuffix(kSuffix))
        try deletePath(path)
    }

    func testCreatingTemporaryDirectoryInDirectory() throws {
        let directory = try createTemporaryDirectory()
        let path = try createTemporaryFile(inDirectory: directory)
        XCTAssert(try isA(.file, atPath: path))
        XCTAssert(path.hasPrefix(directory))
        try deletePath(path)
        try deletePath(directory)
    }

    func testPathRepresentableCreatingTemporaryDirectory() {
        guard let path = Path.createTemporaryFile() else {
            XCTFail("temprorary directory creation failed")
            return
        }

        XCTAssert(path.isA(.file))
        _ = path.delete()
    }

    func testPathRepresentableCreatingTemporaryDirectoryWithPrefix() {
        let kPrefix = "kPrefix"
        guard let path = Path.createTemporaryFile(prefix: kPrefix) else {
            XCTFail("temprorary directory creation failed")
            return
        }

        XCTAssert(path.isA(.file))
        XCTAssert(path.split().1.pathString.hasPrefix(kPrefix))
        _ = path.delete()
    }

    func testPathRepresentableCreatingTemporaryDirectoryWithSuffix() {
        let kSuffix = "kSuffix"
        guard let path = Path.createTemporaryFile(suffix: kSuffix) else {
            XCTFail("temprorary directory creation failed")
            return
        }

        XCTAssert(path.isA(.file))
        XCTAssert(path.pathString.hasSuffix(kSuffix))
        _ = path.delete()
    }

    func testPathRepresentableCreatingTemporaryDirectoryInDirectory() throws {
        let directory = try createTemporaryDirectory()
        guard let path = Path.createTemporaryFile(inDirectory: directory) else {
            XCTFail("temprorary directory creation failed")
            return
        }

        XCTAssert(path.isA(.file))
        XCTAssert(path.pathString.hasPrefix(directory))
        _ = path.delete()
        try deletePath(directory)
    }
}
#endif
