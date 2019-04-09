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
        XCTAssertEqual(try permissions(forPath: destination), try permissions(forPath: source))
        XCTAssertEqual(try readString(atPath: destination), try readString(atPath: source))
    }

    func testFollowingFileSymbol() throws {
        let destination = "hello"
        let source = self.fixture(.goodFileSymbol)
        let realSource = try realPath(ofPath: source)
        try copyFile(fromPath: source, toPath: destination)
        XCTAssertEqual(try permissions(forPath: destination), try permissions(forPath: realSource))
        XCTAssertEqual(try readString(atPath: destination), try readString(atPath: realSource))
    }

    func testNotFollowingFileSymbol() throws {
        let destination = "hello"
        let source = self.fixture(.goodFileSymbol)
        try copyFile(fromPath: source, toPath: destination, followSymbolicLink: false)
        XCTAssertTrue(try isA(.symbolicLink, atPath: destination))
        XCTAssertEqual(try permissions(forPath: destination), try permissions(forPath: source))
        XCTAssertEqual(try readSymbolicLink(atPath: destination), try readSymbolicLink(atPath: source))
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
        XCTAssertEqual(
            try permissions(forPath: destination.pathString),
            try permissions(forPath: source.pathString)
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
        XCTAssertEqual(
            try permissions(forPath: destination.pathString),
            try permissions(forPath: realSource)
        )
        XCTAssertEqual(
            try readString(atPath: destination.pathString),
            try readString(atPath: realSource)
        )
    }

    func testPathRepresentableNotFollowingFileSymbol() {
        let destination = Path("hello")
        let source = self.fixturePath(.goodFileSymbol)
        XCTAssertTrue(source.copy(to: destination, followSymbolicLink: false))
        XCTAssertTrue(try isA(.symbolicLink, atPath: destination.pathString))
        XCTAssertEqual(
            try permissions(forPath: destination.pathString),
            try permissions(forPath: source.pathString)
        )
        XCTAssertEqual(
            try readSymbolicLink(atPath: destination.pathString),
            try readSymbolicLink(atPath: source.pathString)
        )
    }

    func testPathRepresentableDirectory() {
        let destination = Path("hello")
        let source = self.fixturePath(.directoryThatExists)
        XCTAssertFalse(source.copy(to: destination))
    }
}
