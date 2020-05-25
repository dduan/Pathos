import Pathos
import XCTest

#if !os(Windows)
final class DeleteTests: XCTestCase {
    func testFile() throws {
        try withTemporaryDirectory { _ in
            let path = "test"
            try write("", atPath: path)
            XCTAssertTrue(try isA(.file, atPath: path))

            try deletePath(path)

            XCTAssertFalse(exists(atPath: path))
        }
    }

    func testDirectory() throws {
        try withTemporaryDirectory { _ in
            let path = "test"
            try createDirectory(atPath: path)
            XCTAssertTrue(try isA(.directory, atPath: path))

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
            XCTAssertTrue(try isA(.directory, atPath: rootPath))
            XCTAssertTrue(try isA(.directory, atPath: nestedPath))
            XCTAssertTrue(try isA(.file, atPath: contentPath))

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
            XCTAssertTrue(try isA(.directory, atPath: rootPath))
            XCTAssertTrue(try isA(.file, atPath: contentPath))

            XCTAssertThrowsError(try deletePath(rootPath, recursive: false))

            XCTAssertTrue(try isA(.directory, atPath: rootPath))
            XCTAssertTrue(try isA(.file, atPath: contentPath))
        }
    }

    func testPathRepresentableFile() throws {
        try withTemporaryDirectory { _ in
            let path = "test"
            try write("", atPath: path)
            XCTAssertTrue(try isA(.file, atPath: path))

            let result = Path(path).delete()

            XCTAssertTrue(result)
            XCTAssertFalse(exists(atPath: path))
        }
    }

    func testPathRepresentableDirectory() throws {
        try withTemporaryDirectory { _ in
            let path = "test"
            try createDirectory(atPath: path)
            XCTAssertTrue(try isA(.directory, atPath: path))

            let result = Path(path).delete()

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
            XCTAssertTrue(try isA(.directory, atPath: rootPath))
            XCTAssertTrue(try isA(.directory, atPath: nestedPath))
            XCTAssertTrue(try isA(.file, atPath: contentPath))

            let result = Path(rootPath).delete()

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
            XCTAssertTrue(try isA(.directory, atPath: rootPath))
            XCTAssertTrue(try isA(.file, atPath: contentPath))

            let result = Path(rootPath).delete(recursive: false)

            XCTAssertFalse(result)
            XCTAssertTrue(try isA(.file, atPath: contentPath))
        }
    }
}
#endif
