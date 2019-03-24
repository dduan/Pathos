import Pathos
import XCTest

final class ChildrenTests: XCTestCase {
    var originalWorkingDirectory: String = (try? getCurrentWorkingDirectory()) ?? "."
    override func setUp() {
        _ = try? setCurrentWorkingDirectory(toPath: self.fixtureRoot)
    }

    override func tearDown() {
        _ = try? setCurrentWorkingDirectory(toPath: self.originalWorkingDirectory)
    }

    func testRelativeDirectoryRecursive() throws {
        // regression test!
        XCTAssertEqual(
            Set(try children(inPath: FixturePath.directoryThatExists.rawValue, recursive: true)),
            Set([
                FixturePath.fileInDirectory.rawValue,
                FixturePath.symbolInDirectory.rawValue,
                FixturePath.directoryInDirectory.rawValue,
                FixturePath.fileInNestedDirectory.rawValue,
            ])
        )
    }

    func testChildrenInPath() throws {
        XCTAssertEqual(
            Set(try children(inPath: self.fixtureRoot)),
            self.childFileFixture
                .union(self.childDirectoryFixture)
                .union(self.childSymbolicLinkFixture)
        )
    }

    func testChildrenRecursiveInPath() {
        XCTAssertEqual(
            Set(try children(inPath: self.fixtureRoot, recursive: true)),
            self.childFileRecursiveFixture
                .union(self.childDirectoryRecursiveFixture)
                .union(self.childSymbolicLinkRecursiveFixture)
        )
    }

    func testFilesInPath() throws {
        XCTAssertEqual(
            Set(try childFiles(inPath: self.fixtureRoot)),
            self.childFileFixture
        )
    }

    func testFilesRecursiveInPath() throws {
        XCTAssertEqual(
            Set(try childFiles(inPath: self.fixtureRoot, recursive: true)),
            self.childFileRecursiveFixture
        )
    }

    func testDirectoriesInPath() throws {
        XCTAssertEqual(
            Set(try childDirectories(inPath: self.fixtureRoot)),
            self.childDirectoryFixture
        )
    }

    func testDirectoriesRecursiveInPath() throws {
        XCTAssertEqual(
            Set(try childDirectories(inPath: self.fixtureRoot, recursive: true)),
            self.childDirectoryRecursiveFixture
        )
    }

    func testSymbolicLinksInPath() throws {
        XCTAssertEqual(
            Set(try childSymbolicLinks(inPath: self.fixtureRoot)),
            self.childSymbolicLinkFixture
        )
    }

    func testSymbolicLinksRecursiveInPath() throws {
        XCTAssertEqual(
            Set(try childSymbolicLinks(inPath: self.fixtureRoot, recursive: true)),
            self.childSymbolicLinkRecursiveFixture
        )
    }

    func testPathRepresentableChildrenInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).children().map { $0.pathString }),
            self.childFileFixture
                .union(self.childDirectoryFixture)
                .union(self.childSymbolicLinkFixture)
        )
    }

    func testPathRepresentableChildrenRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).children(recursive: true).map { $0.pathString }),
            self.childFileRecursiveFixture
                .union(self.childDirectoryRecursiveFixture)
                .union(self.childSymbolicLinkRecursiveFixture)
        )
    }

    func testPathRepresentableFilesInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).childFiles().map { $0.pathString }),
            self.childFileFixture
        )
    }

    func testPathRepresentableFilesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).childFiles(recursive: true).map { $0.pathString }),
            self.childFileRecursiveFixture
        )
    }

    func testPathRepresentableDirectoriesInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).childDirectories().map { $0.pathString }),
            self.childDirectoryFixture
        )
    }

    func testPathRepresentableDirectoriesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).childDirectories(recursive: true).map { $0.pathString }),
            self.childDirectoryRecursiveFixture
        )
    }

    func testPathRepresentableSymbolicLinksInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).childSymbolicLinks().map { $0.pathString }),
            self.childSymbolicLinkFixture
        )
    }

    func testPathRepresentableSymbolicLinksRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).childSymbolicLinks(recursive: true).map { $0.pathString }),
            self.childSymbolicLinkRecursiveFixture
        )
    }

    /// Negative tests: can't positively prove these are working, but at least make sure they don't return
    /// things they aren't supposed to.

    // unknownTypeFiles
    func testUnknownTypeFilesInPath() throws {
        XCTAssertEqual(Set(try childUnknownTypeFiles(inPath: self.fixtureRoot)), [])
    }

    func testUnknownTypeFilesRecursiveInPath() throws {
        XCTAssertEqual(Set(try childUnknownTypeFiles(inPath: self.fixtureRoot, recursive: true)), [])
    }

    func testPathRepresentableUnknownTypeFilesInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).childUnknownTypeFiles().map { $0.pathString }),
            []
        )
    }

    func testPathRepresentableUnknownTypeFilesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).childUnknownTypeFiles(recursive: true).map { $0.pathString }),
            []
        )
    }

    // pipes
    func testPipesInPath() throws {
        XCTAssertEqual(Set(try childPipes(inPath: self.fixtureRoot)), [])
    }

    func testPipesRecursiveInPath() throws {
        XCTAssertEqual(Set(try childPipes(inPath: self.fixtureRoot, recursive: true)), [])
    }

    func testPathRepresentablePipesInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).childPipes().map { $0.pathString }),
            []
        )
    }

    func testPathRepresentablePipesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).childPipes(recursive: true).map { $0.pathString }),
            []
        )
    }

    // characterDevices
    func testCharacterDevicesInPath() throws {
        XCTAssertEqual(Set(try childCharacterDevices(inPath: self.fixtureRoot)), [])
    }

    func testCharacterDevicesRecursiveInPath() throws {
        XCTAssertEqual(Set(try childCharacterDevices(inPath: self.fixtureRoot, recursive: true)), [])
    }

    func testPathRepresentableCharacterDevicesInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).childCharacterDevices().map { $0.pathString }),
            []
        )
    }

    func testPathRepresentableCharacterDevicesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).childCharacterDevices(recursive: true).map { $0.pathString }),
            []
        )
    }

    // blockDevices
    func testBlockDevicesInPath() throws {
        XCTAssertEqual(Set(try childBlockDevices(inPath: self.fixtureRoot)), [])
    }

    func testBlockDevicesRecursiveInPath() throws {
        XCTAssertEqual(Set(try childBlockDevices(inPath: self.fixtureRoot, recursive: true)), [])
    }

    func testPathRepresentableBlockDevicesInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).childBlockDevices().map { $0.pathString }),
            []
        )
    }

    func testPathRepresentableBlockDevicesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).childBlockDevices(recursive: true).map { $0.pathString }),
            []
        )
    }

    // sockets
    func testSocketsInPath() throws {
        XCTAssertEqual(Set(try childSockets(inPath: self.fixtureRoot)), [])
    }

    func testSocketsRecursiveInPath() throws {
        XCTAssertEqual(Set(try childSockets(inPath: self.fixtureRoot, recursive: true)), [])
    }

    func testPathRepresentableSocketsInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).childSockets().map { $0.pathString }),
            []
        )
    }

    func testPathRepresentableSocketsRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).childSockets(recursive: true).map { $0.pathString }),
            []
        )
    }
}
