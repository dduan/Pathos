import Pathos
import XCTest

final class TemporaryTests: XCTestCase {
    func testDefaultTemporaryPathExists() {
        XCTAssert(Path.defaultTemporaryDirectory.exists())
    }

    func testMakingTemporaryDirectory() throws {
        let path = try Path.makeTemporaryDirectory()
        defer {
            try? path.delete(recursive: true)
        }

        XCTAssert(path.exists())
    }

    func testMakingTemporaryDirectoryWithPrefix() throws {
        let prefix = "test_prefix"
        let path = try Path.makeTemporaryDirectory(prefix: prefix)
        defer {
            try? path.delete(recursive: true)
        }

        XCTAssert(path.exists())
        print(path.description)
        XCTAssert(try XCTUnwrap(path.name).hasPrefix(prefix))
    }

    func testMakingTemporaryDirectoryWithSuffix() throws {
        let suffix = "suffix_test"
        let path = try Path.makeTemporaryDirectory(suffix: suffix)
        defer {
            try? path.delete(recursive: true)
        }

        XCTAssert(path.exists())
        print(path.description)
        XCTAssert(try XCTUnwrap(path.name).hasSuffix(suffix))
    }

    func testWithTemporaryDirectory() throws {
        var path: Path?
        try Path.withTemporaryDirectory { tempPath in
            path = tempPath
            XCTAssert(tempPath.exists())
            XCTAssertEqual(
                try XCTUnwrap(Path.workingDirectory().name),
                try XCTUnwrap(tempPath.name)
            )
        }

        XCTAssertFalse(try XCTUnwrap(path).exists())
    }
}
