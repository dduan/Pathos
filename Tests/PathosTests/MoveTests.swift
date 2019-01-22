import Pathos
import XCTest

final class MoveTests: XCTestCase {
    func testSingleFile() throws {
        try withTemporaryDirectory { directory in
            let temporaryFile = try makeTemporaryFile()
            XCTAssertTrue(try isFile(atPath: temporaryFile))
            let destination = join(paths: directory, "test")
            try movePath(temporaryFile, toPath: destination)
            XCTAssertTrue(try isFile(atPath: destination))
            XCTAssertFalse(exists(atPath: temporaryFile))
        }
    }

    func testDirectory() throws {
        try withTemporaryDirectory { directory in
            let originalDirectory = try makeTemporaryDirectory(inDirectory: directory)
            XCTAssertTrue(try isDirectory(atPath: originalDirectory))
            let destination = join(paths: defaultTemporaryDirectory, "test")
            try movePath(originalDirectory, toPath: destination)
            XCTAssertFalse(exists(atPath: originalDirectory))
            XCTAssertTrue(try isDirectory(atPath: destination))
        }
    }

    func testOverridingExistingFile() throws {
        try withTemporaryDirectory { _ in
            let filePath = "test"
            let fileContent = "hello"
            try writeString(atPath: filePath, fileContent)
            let otherFilePath = "test2"
            try writeString(atPath: otherFilePath, fileContent + " world")

            try movePath(filePath, toPath: otherFilePath)

            XCTAssertFalse(exists(atPath: filePath))
            XCTAssertEqual(try readString(atPath: otherFilePath), fileContent)
        }
    }

    func testOverridingExistingDirectory() throws {
        try withTemporaryDirectory { _ in
            let directoryPath = "test"
            try makeDirectory(atPath: directoryPath)
            let otherDirectoryPath = "test2"
            try makeDirectory(atPath: otherDirectoryPath)

            try movePath(directoryPath, toPath: otherDirectoryPath)

            XCTAssertFalse(exists(atPath: directoryPath))
            XCTAssertTrue(try isDirectory(atPath: otherDirectoryPath))
        }
    }

    func testMixingTypes() throws {
        try withTemporaryDirectory { _ in
            let filePath = "test"
            try writeString(atPath: filePath, "")
            let directoryPath = "test2"
            try makeDirectory(atPath: directoryPath)
            XCTAssertThrowsError(try movePath(filePath, toPath: directoryPath))
        }
    }

    func testPathRepresentableSingleFile() {
        Path.withTemporaryDirectory { directory in
            let temporaryFile = Path.makeTemporaryFile()!
            XCTAssertTrue(temporaryFile.isFile)
            let destination = directory.join(with: Path(string: "test"))
            XCTAssertTrue(temporaryFile.move(to: destination))
            XCTAssertTrue(destination.isFile)
            XCTAssertFalse(temporaryFile.exists())
        }
    }

    func testPathRepresentableDirectory() throws {
        Path.withTemporaryDirectory { directory in
            let originalDirectory = Path.makeTemporaryDirectory(inDirectory: directory)!
            XCTAssertTrue(originalDirectory.isDirectory)
            let destination = Path.defaultTemporaryDirectory.join(with: Path(string: "test"))
            XCTAssertTrue(originalDirectory.move(to: destination))
            XCTAssertFalse(originalDirectory.exists())
            XCTAssertTrue(destination.isDirectory)
        }
    }

    func testPathRepresentableOverridingExistingFile() throws {
        try withTemporaryDirectory { _ in
            let filePath = Path(string: "test")
            let fileContent = "hello"
            filePath.writeString(string: fileContent)
            let otherFilePath = Path(string: "test2")
            otherFilePath.writeString(string: fileContent + " world")

            XCTAssertTrue(filePath.move(to: otherFilePath))

            XCTAssertFalse(filePath.exists())
            XCTAssertEqual(otherFilePath.readString(), fileContent)
        }
    }

    func testPathRepresentableOverridingExistingDirectory() throws {
        try withTemporaryDirectory { _ in
            let directoryPath = Path(string: "test")
            XCTAssertTrue(directoryPath.makeDirectory())
            let otherDirectoryPath = Path(string: "test2")
            XCTAssertTrue(otherDirectoryPath.makeDirectory())

            XCTAssertTrue(directoryPath.move(to: otherDirectoryPath))

            XCTAssertFalse(directoryPath.exists())
            XCTAssertTrue(otherDirectoryPath.isDirectory)
        }
    }

    func testPathRepresentableMixingTypes() throws {
        try withTemporaryDirectory { _ in
            let filePath = Path(string: "test")
            XCTAssertTrue(filePath.writeString(string: ""))
            let directoryPath = Path(string: "test2")
            XCTAssertTrue(directoryPath.makeDirectory())
            XCTAssertFalse(filePath.move(to: directoryPath))
        }
    }
}
