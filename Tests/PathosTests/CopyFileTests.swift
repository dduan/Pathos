import Pathos
import XCTest

final class CopyFileTests: XCTestCase {
    var originalWorkingDirectory: String = (try? getCurrentWorkingDirectory()) ?? "."
    var rootPath = ""

    override func setUp() {
        self.rootPath = makeTemporaryRoot()
        try? setCurrentWorkingDirectory(toPath: self.rootPath)
    }

    override func tearDown() {
        try? setCurrentWorkingDirectory(toPath: self.originalWorkingDirectory)
        try? deletePath(self.rootPath, recursive: true)
    }

    func testFile() throws {
        let destination = "hello"
        let source = self.fixture(.fileThatExists)
        try copyFile(fromPath: source, toPath: destination)
        try XCTAssertEqual(metadata(atPath: destination).permissions, metadata(atPath: source).permissions)
        XCTAssertEqual(try readString(atPath: destination), try readString(atPath: source))
    }

    func testFollowingFileSymbol() throws {
        let destination = "hello"
        let source = self.fixture(.goodFileSymbol)
        let realSource = try realPath(ofPath: source)
        try copyFile(fromPath: source, toPath: destination)
        try XCTAssertEqual(
            metadata(atPath: destination).permissions,
            metadata(atPath: realSource).permissions
        )
        XCTAssertEqual(try readString(atPath: destination), try readString(atPath: realSource))
    }

    func testNotFollowingFileSymbol() throws {
        let destination = "hello"
        let source = self.fixture(.goodFileSymbol)
        try copyFile(fromPath: source, toPath: destination, followSymlink: false)
        XCTAssertTrue(try isA(.symlink, atPath: destination))
        try XCTAssertEqual(
            metadata(atPath: destination, followSymlink: false).permissions,
            metadata(atPath: source, followSymlink: false).permissions
        )
        XCTAssertEqual(try readSymlink(atPath: destination), try readSymlink(atPath: source))
    }

    func testDirectory() {
        let destination = "hello"
        let source = self.fixture(.directoryThatExists)
        XCTAssertThrowsError(try copyFile(fromPath: source, toPath: destination))
    }

    func testPathRepresentableFile() {
        let destination = Path("hello")
        let source = self.fixturePath(.fileThatExists)
        XCTAssertTrue(source.copy(to: destination))
        try XCTAssertEqual(
            metadata(atPath: destination.pathString).permissions,
            metadata(atPath: source.pathString).permissions
        )
        XCTAssertEqual(
            try readString(atPath: destination.pathString),
            try readString(atPath: source.pathString)
        )
    }

    func testPathRepresentableFollowingFileSymbol() throws {
        let destination = Path("hello")
        let source = self.fixturePath(.goodFileSymbol)
        let realSource = try realPath(ofPath: source.pathString)
        XCTAssertTrue(source.copy(to: destination))
        try XCTAssertEqual(
            metadata(atPath: destination.pathString).permissions,
            metadata(atPath: realSource).permissions
        )
        XCTAssertEqual(
            try readString(atPath: destination.pathString),
            try readString(atPath: realSource)
        )
    }

    func testPathRepresentableNotFollowingFileSymbol() {
        let destination = Path("hello")
        let source = self.fixturePath(.goodFileSymbol)
        XCTAssertTrue(source.copy(to: destination, followSymlink: false))
        XCTAssertTrue(try isA(.symlink, atPath: destination.pathString))
        try XCTAssertEqual(
            metadata(atPath: destination.pathString, followSymlink: false).permissions,
            metadata(atPath: source.pathString, followSymlink: false).permissions
        )
        XCTAssertEqual(
            try readSymlink(atPath: destination.pathString),
            try readSymlink(atPath: source.pathString)
        )
    }

    func testPathRepresentableDirectory() {
        let destination = Path("hello")
        let source = self.fixturePath(.directoryThatExists)
        XCTAssertFalse(source.copy(to: destination))
    }
}
