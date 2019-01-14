import Pathos
import XCTest

final class WritingTests: XCTestCase {
    var originalWorkingDirectory: String = (try? getCurrentWorkingDirectory()) ?? "."
    var rootPath = makeTemporaryRoot()

    override func setUp() {
        try? deletePath(self.rootPath, recursive: true)
        self.rootPath = makeTemporaryRoot()
        try? setCurrentWorkingDirectory(to: self.rootPath)
    }

    override func tearDown() {
        try? setCurrentWorkingDirectory(to: self.originalWorkingDirectory)
    }

    func testStringToNewFile() throws {
        let expected = "Hello"
        let path = "world"

        try writeString(atPath: path, expected)

        let createdPermission = try permissions(forPath: path)
        XCTAssertEqual(createdPermission, self.defaultPermission)
        XCTAssertEqual(try readString(atPath: path), expected)
    }

    func testStringToExistingFile() throws {
        let expected = "Hello"
        let path = "world"
        try writeString(atPath: path, "")

        try writeString(atPath: path, expected)

        let createdPermission = try permissions(forPath: path)
        XCTAssertEqual(createdPermission, self.defaultPermission)
        XCTAssertEqual(try readString(atPath: path), expected)
    }

    func testStringToUnwantedNewFile() throws {
        let path = "world"
        XCTAssertThrowsError(try writeString(atPath: path, "", createIfNecessary: false))
    }

    func testBytesToNewFile() throws {
        let expected = "Hello"
        let expectedBytes = expected.cString(using: String.defaultCStringEncoding)!
        let path = "world"

        try writeBytes(atPath: path, expectedBytes)

        let createdPermission = try permissions(forPath: path)
        XCTAssertEqual(createdPermission, self.defaultPermission)
        XCTAssertEqual(try readString(atPath: path), expected)
    }


    func testBytesToExistingFile() throws {
        let expected = "Hello"
        let expectedBytes = expected.cString(using: String.defaultCStringEncoding)!
        let path = "world"
        try writeString(atPath: path, "")

        try writeBytes(atPath: path, expectedBytes)

        let createdPermission = try permissions(forPath: path)
        XCTAssertEqual(createdPermission, self.defaultPermission)
        XCTAssertEqual(try readString(atPath: path), expected)
    }

    func testBytesToUnwantedNewFile() throws {
        let path = "world"
        XCTAssertThrowsError(try writeBytes(atPath: path, "".cString(using: .utf8)!, createIfNecessary: false))
    }

    func testPathRepresentableStringToNewFile() throws {
        let expected = "Hello"
        let path = Path(string: "world")

        XCTAssertTrue(path.writeString(string: expected))

        let createdPermission = try permissions(forPath: path.pathString)
        XCTAssertEqual(createdPermission, self.defaultPermission)
        XCTAssertEqual(try readString(atPath: path.pathString), expected)
    }

    func testPathRepresentableStringToExistingFile() throws {
        let expected = "Hello"
        let path = Path(string: "world")
        try writeString(atPath: path.pathString, "")

        XCTAssertTrue(path.writeString(string: expected))

        let createdPermission = try permissions(forPath: path.pathString)
        XCTAssertEqual(createdPermission, self.defaultPermission)
        XCTAssertEqual(try readString(atPath: path.pathString), expected)
    }

    func testPathRepresentableStringToUnwantedNewFile() throws {
        let path = Path(string: "world")
        XCTAssertFalse(path.writeString(string: "", createIfNecessary: false))
    }

    func testPathRepresentableBytesToNewFile() throws {
        let expected = "Hello"
        let expectedBytes = expected.cString(using: String.defaultCStringEncoding)!
        let path = Path(string: "world")

        XCTAssertTrue(path.writeBytes(bytes: expectedBytes))

        let createdPermission = try permissions(forPath: path.pathString)
        XCTAssertEqual(createdPermission, self.defaultPermission)
        XCTAssertEqual(try readString(atPath: path.pathString), expected)
    }


    func testPathRepresentableBytesToExistingFile() throws {
        let expected = "Hello"
        let expectedBytes = expected.cString(using: String.defaultCStringEncoding)!
        let path = Path(string: "world")
        try writeString(atPath: path.pathString, "")

        XCTAssertTrue(path.writeBytes(bytes: expectedBytes))

        let createdPermission = try permissions(forPath: path.pathString)
        XCTAssertEqual(createdPermission, self.defaultPermission)
        XCTAssertEqual(try readString(atPath: path.pathString), expected)
    }

    func testPathRepresentableBytesToUnwantedNewFile() throws {
        let path = Path(string: "world")
        XCTAssertFalse(path.writeBytes(bytes: "".cString(using: .utf8)!, createIfNecessary: false))
    }
}
