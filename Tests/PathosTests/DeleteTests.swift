import Pathos
import XCTest

final class DeleteTests: XCTestCase {
    func testFile() throws {
        try withTemporaryDirectory { _ in
            let path = "test"
            try write("", atPath: path)
            XCTAssertTrue(try isFile(atPath: path))

            try deletePath(path)

            XCTAssertFalse(exists(atPath: path))
        }
    }

    func testDirectory() throws {
        try withTemporaryDirectory { _ in
            let path = "test"
            try createDirectory(atPath: path)
            XCTAssertTrue(try isDirectory(atPath: path))

            try deletePath(path)

            XCTAssertFalse(exists(atPath: path))
        }
    }

    func testDirectoryWithContent() throws {
        try withTemporaryDirectory { _ in
            let rootPath = "test"
            let contentPath = "test/content"
            let nestedPath = "test/test"
            try createDirectory(atPath: rootPath)
            try createDirectory(atPath: nestedPath)
            try write("", atPath: contentPath)
            XCTAssertTrue(try isDirectory(atPath: rootPath))
            XCTAssertTrue(try isDirectory(atPath: nestedPath))
            XCTAssertTrue(try isFile(atPath: contentPath))

            try deletePath(rootPath)

            XCTAssertFalse(exists(atPath: rootPath))
        }
    }

    func testDirectoryWithContentNotAllowed() throws {
        try withTemporaryDirectory { _ in
            let rootPath = "test"
            let contentPath = "test/content"
            try createDirectory(atPath: rootPath)
            try write("", atPath: contentPath)
            XCTAssertTrue(try isDirectory(atPath: rootPath))
            XCTAssertTrue(try isFile(atPath: contentPath))

            XCTAssertThrowsError(try deletePath(rootPath, recursive: false))

            XCTAssertTrue(try isDirectory(atPath: rootPath))
            XCTAssertTrue(try isFile(atPath: contentPath))
        }
    }

    func testPathRepresentableFile() throws {
        try withTemporaryDirectory { _ in
            let path = "test"
            try write("", atPath: path)
            XCTAssertTrue(try isFile(atPath: path))

            let result = Path(string: path).delete()

            XCTAssertTrue(result)
            XCTAssertFalse(exists(atPath: path))
        }
    }

    func testPathRepresentableDirectory() throws {
        try withTemporaryDirectory { _ in
            let path = "test"
            try createDirectory(atPath: path)
            XCTAssertTrue(try isDirectory(atPath: path))

            let result = Path(string: path).delete()

            XCTAssertTrue(result)
            XCTAssertFalse(exists(atPath: path))
        }
    }

    func testPathRepresentableDirectoryWithContent() throws {
        try withTemporaryDirectory { _ in
            let rootPath = "test"
            let contentPath = "test/content"
            let nestedPath = "test/test"
            try createDirectory(atPath: rootPath)
            try createDirectory(atPath: nestedPath)
            try write("", atPath: contentPath)
            XCTAssertTrue(try isDirectory(atPath: rootPath))
            XCTAssertTrue(try isDirectory(atPath: nestedPath))
            XCTAssertTrue(try isFile(atPath: contentPath))

            let result = Path(string: rootPath).delete()

            XCTAssertTrue(result)
            XCTAssertFalse(exists(atPath: rootPath))
        }
    }

    func testPathRepresentableDirectoryWithContentNotAllowed() throws {
        try withTemporaryDirectory { _ in
            let rootPath = "test"
            let contentPath = "test/content"
            try createDirectory(atPath: rootPath)
            try write("", atPath: contentPath)
            XCTAssertTrue(try isDirectory(atPath: rootPath))
            XCTAssertTrue(try isFile(atPath: contentPath))

            let result = Path(string: rootPath).delete(recursive: false)

            XCTAssertFalse(result)
            XCTAssertTrue(try isFile(atPath: contentPath))
        }
    }
}
