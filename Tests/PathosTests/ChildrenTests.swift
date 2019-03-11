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
            self.childFiles
                .union(self.childDirectories)
                .union(self.childSymbolicLinks)
        )
    }

    func testChildrenRecursiveInPath() {
        XCTAssertEqual(
            Set(try children(inPath: self.fixtureRoot, recursive: true)),
            self.childFilesRecursive
                .union(self.childDirectoriesRecursive)
                .union(self.childSymbolicLinksRecursive)
        )
    }

    func testFilesInPath() throws {
        XCTAssertEqual(
            Set(try files(inPath: self.fixtureRoot)),
            self.childFiles
        )
    }

    func testFilesRecursiveInPath() throws {
        XCTAssertEqual(
            Set(try files(inPath: self.fixtureRoot, recursive: true)),
            self.childFilesRecursive
        )
    }

    func testDirectoriesInPath() throws {
        XCTAssertEqual(
            Set(try directories(inPath: self.fixtureRoot)),
            self.childDirectories
        )
    }

    func testDirectoriesRecursiveInPath() throws {
        XCTAssertEqual(
            Set(try directories(inPath: self.fixtureRoot, recursive: true)),
            self.childDirectoriesRecursive
        )
    }

    func testSymbolicLinksInPath() throws {
        XCTAssertEqual(
            Set(try symbolicLinks(inPath: self.fixtureRoot)),
            self.childSymbolicLinks
        )
    }

    func testSymbolicLinksRecursiveInPath() throws {
        XCTAssertEqual(
            Set(try symbolicLinks(inPath: self.fixtureRoot, recursive: true)),
            self.childSymbolicLinksRecursive
        )
    }

    func testPathRepresentableChildrenInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).children().map { $0.pathString }),
            self.childFiles
                .union(self.childDirectories)
                .union(self.childSymbolicLinks)
        )
    }

    func testPathRepresentableChildrenRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).children(recursive: true).map { $0.pathString }),
            self.childFilesRecursive
                .union(self.childDirectoriesRecursive)
                .union(self.childSymbolicLinksRecursive)
        )
    }

    func testPathRepresentableFilesInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).files().map { $0.pathString }),
            self.childFiles
        )
    }

    func testPathRepresentableFilesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).files(recursive: true).map { $0.pathString }),
            self.childFilesRecursive
        )
    }

    func testPathRepresentableDirectoriesInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).directories().map { $0.pathString }),
            self.childDirectories
        )
    }

    func testPathRepresentableDirectoriesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).directories(recursive: true).map { $0.pathString }),
            self.childDirectoriesRecursive
        )
    }

    func testPathRepresentableSymbolicLinksInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).symbolicLinks().map { $0.pathString }),
            self.childSymbolicLinks
        )
    }

    func testPathRepresentableSymbolicLinksRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).symbolicLinks(recursive: true).map { $0.pathString }),
            self.childSymbolicLinksRecursive
        )
    }

    /// Negative tests: can't positively prove these are working, but at least make sure they don't return
    /// things they aren't supposed to.

    // unknownTypeFiles
    func testUnknownTypeFilesInPath() throws {
        XCTAssertEqual(Set(try unknownTypeFiles(inPath: self.fixtureRoot)), [])
    }

    func testUnknownTypeFilesRecursiveInPath() throws {
        XCTAssertEqual(Set(try unknownTypeFiles(inPath: self.fixtureRoot, recursive: true)), [])
    }

    func testPathRepresentableUnknownTypeFilesInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).unknownTypeFiles().map { $0.pathString }), 
            []
        )
    }

    func testPathRepresentableUnknownTypeFilesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).unknownTypeFiles(recursive: true).map { $0.pathString }), 
            []
        )
    }

    // pipes
    func testPipesInPath() throws {
        XCTAssertEqual(Set(try pipes(inPath: self.fixtureRoot)), [])
    }

    func testPipesRecursiveInPath() throws {
        XCTAssertEqual(Set(try pipes(inPath: self.fixtureRoot, recursive: true)), [])
    }

    func testPathRepresentablePipesInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).pipes().map { $0.pathString }), 
            []
        )
    }

    func testPathRepresentablePipesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).pipes(recursive: true).map { $0.pathString }), 
            []
        )
    }

    // characterDevices
    func testCharacterDevicesInPath() throws {
        XCTAssertEqual(Set(try characterDevices(inPath: self.fixtureRoot)), [])
    }

    func testCharacterDevicesRecursiveInPath() throws {
        XCTAssertEqual(Set(try characterDevices(inPath: self.fixtureRoot, recursive: true)), [])
    }

    func testPathRepresentableCharacterDevicesInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).characterDevices().map { $0.pathString }), 
            []
        )
    }

    func testPathRepresentableCharacterDevicesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).characterDevices(recursive: true).map { $0.pathString }), 
            []
        )
    }

    // blockDevices
    func testBlockDevicesInPath() throws {
        XCTAssertEqual(Set(try blockDevices(inPath: self.fixtureRoot)), [])
    }

    func testBlockDevicesRecursiveInPath() throws {
        XCTAssertEqual(Set(try blockDevices(inPath: self.fixtureRoot, recursive: true)), [])
    }

    func testPathRepresentableBlockDevicesInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).blockDevices().map { $0.pathString }), 
            []
        )
    }

    func testPathRepresentableBlockDevicesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).blockDevices(recursive: true).map { $0.pathString }), 
            []
        )
    }

    // sockets
    func testSocketsInPath() throws {
        XCTAssertEqual(Set(try sockets(inPath: self.fixtureRoot)), [])
    }

    func testSocketsRecursiveInPath() throws {
        XCTAssertEqual(Set(try sockets(inPath: self.fixtureRoot, recursive: true)), [])
    }

    func testPathRepresentableSocketsInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).sockets().map { $0.pathString }), 
            []
        )
    }

    func testPathRepresentableSocketsRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).sockets(recursive: true).map { $0.pathString }), 
            []
        )
    }
}
