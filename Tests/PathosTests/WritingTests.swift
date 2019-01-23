import Pathos
import XCTest

final class WritingTests: XCTestCase {
    var originalWorkingDirectory: String = (try? getCurrentWorkingDirectory()) ?? "."
    var rootPath = makeTemporaryRoot()

    override func setUp() {
        try? deletePath(self.rootPath, recursive: true)
        self.rootPath = makeTemporaryRoot()
        try? setCurrentWorkingDirectory(toPath: self.rootPath)
    }

    override func tearDown() {
        try? setCurrentWorkingDirectory(toPath: self.originalWorkingDirectory)
    }

    func testStringToNewFile() throws {
        let expected = "Hello"
        let path = "world"

        try write(expected, atPath: path)

        let createdPermission = try permissions(forPath: path)
        XCTAssertEqual(createdPermission, self.defaultPermission)
        XCTAssertEqual(try readString(atPath: path), expected)
    }

    func testStringToExistingFile() throws {
        let expected = "Hello"
        let path = "world"
        try write("", atPath: path)

        try write(expected, atPath: path)

        let createdPermission = try permissions(forPath: path)
        XCTAssertEqual(createdPermission, self.defaultPermission)
        XCTAssertEqual(try readString(atPath: path), expected)
    }

    func testStringToUnwantedNewFile() throws {
        let path = "world"
        XCTAssertThrowsError(try write("", atPath: path, createIfNecessary: false))
    }

    func testBytesToNewFile() throws {
        let expected = "Hello"
        let expectedBytes = expected.cString(using: String.defaultCStringEncoding)!
        let path = "world"

        try write(expectedBytes, atPath: path)

        let createdPermission = try permissions(forPath: path)
        XCTAssertEqual(createdPermission, self.defaultPermission)
        XCTAssertEqual(try readString(atPath: path), expected)
    }


    func testBytesToExistingFile() throws {
        let expected = "Hello"
        let expectedBytes = expected.cString(using: String.defaultCStringEncoding)!
        let path = "world"
        try write("", atPath: path)

        try write(expectedBytes, atPath: path)

        let createdPermission = try permissions(forPath: path)
        XCTAssertEqual(createdPermission, self.defaultPermission)
        XCTAssertEqual(try readString(atPath: path), expected)
    }

    func testBytesToUnwantedNewFile() throws {
        let path = "world"
        XCTAssertThrowsError(try write("".cString(using: .utf8)!, atPath: path, createIfNecessary: false))
    }

    func testPathRepresentableStringToNewFile() throws {
        let expected = "Hello"
        let path = Path(string: "world")

        XCTAssertTrue(path.write(expected))

        let createdPermission = try permissions(forPath: path.pathString)
        XCTAssertEqual(createdPermission, self.defaultPermission)
        XCTAssertEqual(try readString(atPath: path.pathString), expected)
    }

    func testPathRepresentableStringToExistingFile() throws {
        let expected = "Hello"
        let path = Path(string: "world")
        try write(expected, atPath: path.pathString)

        XCTAssertTrue(path.write(expected))

        let createdPermission = try permissions(forPath: path.pathString)
        XCTAssertEqual(createdPermission, self.defaultPermission)
        XCTAssertEqual(try readString(atPath: path.pathString), expected)
    }

    func testPathRepresentableStringToUnwantedNewFile() throws {
        let path = Path(string: "world")
        XCTAssertFalse(path.write("", createIfNecessary: false))
    }

    func testPathRepresentableBytesToNewFile() throws {
        let expected = "Hello"
        let expectedBytes = expected.cString(using: String.defaultCStringEncoding)!
        let path = Path(string: "world")

        XCTAssertTrue(path.write(expectedBytes))

        let createdPermission = try permissions(forPath: path.pathString)
        XCTAssertEqual(createdPermission, self.defaultPermission)
        XCTAssertEqual(try readString(atPath: path.pathString), expected)
    }


    func testPathRepresentableBytesToExistingFile() throws {
        let expected = "Hello"
        let expectedBytes = expected.cString(using: String.defaultCStringEncoding)!
        let path = Path(string: "world")
        try write("", atPath: path.pathString)

        XCTAssertTrue(path.write(expectedBytes))

        let createdPermission = try permissions(forPath: path.pathString)
        XCTAssertEqual(createdPermission, self.defaultPermission)
        XCTAssertEqual(try readString(atPath: path.pathString), expected)
    }

    func testPathRepresentableBytesToUnwantedNewFile() throws {
        let path = Path(string: "world")
        XCTAssertFalse(path.write("".cString(using: .utf8)!, createIfNecessary: false))
    }
}
