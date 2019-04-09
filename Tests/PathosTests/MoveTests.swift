import Pathos
import XCTest

final class MoveTests: XCTestCase {
    func testSingleFile() throws {
        try withTemporaryDirectory { directory in
            let temporaryFile = try createTemporaryFile()
            XCTAssertTrue(try isA(.file, atPath: temporaryFile))
            let destination = join(paths: directory, "test")
            try movePath(temporaryFile, toPath: destination)
            XCTAssertTrue(try isA(.file, atPath: destination))
            XCTAssertFalse(exists(atPath: temporaryFile))
        }
    }

    func testDirectory() throws {
        try withTemporaryDirectory { directory in
            let originalDirectory = try createTemporaryDirectory(inDirectory: directory)
            XCTAssertTrue(try isA(.directory, atPath: originalDirectory))
            let destination = join(paths: defaultTemporaryDirectory, "test")
            try movePath(originalDirectory, toPath: destination)
            XCTAssertFalse(exists(atPath: originalDirectory))
            XCTAssertTrue(try isA(.directory, atPath: destination))
        }
    }

    func testOverridingExistingFile() throws {
        try withTemporaryDirectory { _ in
            let filePath = "test"
            let fileContent = "hello"
            try write(fileContent, atPath: filePath)
            let otherFilePath = "test2"
            try write(fileContent + " world", atPath: otherFilePath)

            try movePath(filePath, toPath: otherFilePath)

            XCTAssertFalse(exists(atPath: filePath))
            XCTAssertEqual(try readString(atPath: otherFilePath), fileContent)
        }
    }

    func testOverridingExistingDirectory() throws {
        try withTemporaryDirectory { _ in
            let directoryPath = "test"
            try createDirectory(atPath: directoryPath)
            let otherDirectoryPath = "test2"
            try createDirectory(atPath: otherDirectoryPath)

            try movePath(directoryPath, toPath: otherDirectoryPath)

            XCTAssertFalse(exists(atPath: directoryPath))
            XCTAssertTrue(try isA(.directory, atPath: otherDirectoryPath))
        }
    }

    func testMixingTypes() throws {
        try withTemporaryDirectory { _ in
            let filePath = "test"
            try write("", atPath: filePath)
            let directoryPath = "test2"
            try createDirectory(atPath: directoryPath)
            XCTAssertThrowsError(try movePath(filePath, toPath: directoryPath))
        }
    }

    func testPathRepresentableSingleFile() {
        Path.withTemporaryDirectory { directory in
            let temporaryFile = Path.createTemporaryFile()!
            XCTAssertTrue(temporaryFile.isA(.file))
            let destination = directory.join(with: Path("test"))
            XCTAssertTrue(temporaryFile.move(to: destination))
            XCTAssertTrue(destination.isA(.file))
            XCTAssertFalse(temporaryFile.exists())
        }
    }

    func testPathRepresentableDirectory() throws {
        Path.withTemporaryDirectory { directory in
            let originalDirectory = Path.createTemporaryDirectory(inDirectory: directory)!
            XCTAssertTrue(originalDirectory.isA(.directory))
            let destination = Path.defaultTemporaryDirectory.join(with: Path("test"))
            XCTAssertTrue(originalDirectory.move(to: destination))
            XCTAssertFalse(originalDirectory.exists())
            XCTAssertTrue(destination.isA(.directory))
        }
    }

    func testPathRepresentableOverridingExistingFile() throws {
        try withTemporaryDirectory { _ in
            let filePath = Path("test")
            let fileContent = "hello"
            filePath.write(fileContent)
            let otherFilePath = Path("test2")
            otherFilePath.write(fileContent + " world")

            XCTAssertTrue(filePath.move(to: otherFilePath))

            XCTAssertFalse(filePath.exists())
            XCTAssertEqual(otherFilePath.readString(), fileContent)
        }
    }

    func testPathRepresentableOverridingExistingDirectory() throws {
        try withTemporaryDirectory { _ in
            let directoryPath = Path("test")
            XCTAssertTrue(directoryPath.createDirectory())
            let otherDirectoryPath = Path("test2")
            XCTAssertTrue(otherDirectoryPath.createDirectory())

            XCTAssertTrue(directoryPath.move(to: otherDirectoryPath))

            XCTAssertFalse(directoryPath.exists())
            XCTAssertTrue(otherDirectoryPath.isA(.directory))
        }
    }

    func testPathRepresentableMixingTypes() throws {
        try withTemporaryDirectory { _ in
            let filePath = Path("test")
            XCTAssertTrue(filePath.write(""))
            let directoryPath = Path("test2")
            XCTAssertTrue(directoryPath.createDirectory())
            XCTAssertFalse(filePath.move(to: directoryPath))
        }
    }
}
