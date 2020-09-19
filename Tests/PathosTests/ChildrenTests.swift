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
            Set(try children(inPath: FixturePath.directoryThatExists.rawValue, recursive: true).map { $0.0 }),
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
            Set(try children(inPath: self.fixtureRoot).map { $0.0 }),
            self.childFileFixture
                .union(self.childDirectoryFixture)
                .union(self.childSymlinkFixture)
        )
    }

    func testChildrenRecursiveInPath() {
        XCTAssertEqual(
            Set(try children(inPath: self.fixtureRoot, recursive: true).map { $0.0 }),
            self.childFileRecursiveFixture
                .union(self.childDirectoryRecursiveFixture)
                .union(self.childSymlinkRecursiveFixture)
        )
    }

    func testFilesInPath() throws {
        XCTAssertEqual(
            Set(try children(inPath: self.fixtureRoot, ofType: .file)),
            self.childFileFixture
        )
    }

    func testFilesRecursiveInPath() throws {
        XCTAssertEqual(
            Set(try children(inPath: self.fixtureRoot, ofType: .file, recursive: true)),
            self.childFileRecursiveFixture
        )
    }

    func testDirectoriesInPath() throws {
        XCTAssertEqual(
            Set(try children(inPath: self.fixtureRoot, ofType: .directory)),
            self.childDirectoryFixture
        )
    }

    func testDirectoriesRecursiveInPath() throws {
        XCTAssertEqual(
            Set(try children(inPath: self.fixtureRoot, ofType: .directory, recursive: true)),
            self.childDirectoryRecursiveFixture
        )
    }

    func testSymlinksInPath() throws {
        XCTAssertEqual(
            Set(try children(inPath: self.fixtureRoot, ofType: .symlink)),
            self.childSymlinkFixture
        )
    }

    func testSymlinksRecursiveInPath() throws {
        XCTAssertEqual(
            Set(try children(inPath: self.fixtureRoot, ofType: .symlink, recursive: true)),
            self.childSymlinkRecursiveFixture
        )
    }

    func testNotFollowingSymlinks() throws {
        XCTAssertEqual(
            Set(try children(inPath: self.fixture(.secondDirectoryThatExists)).map { $0.0 }),
            [self.fixture(.secondSymbolInDirectory)]
        )
    }

    func testFollowingSymlinks() throws {
        XCTAssertEqual(
            Set(try children(inPath: self.fixture(.secondDirectoryThatExists), followSymlink: true).map { $0.0 }),
            [
                self.fixture(.secondSymbolInDirectory),
                self.fixture(.secondFileViaSymlink),
            ]
        )
    }

    func testPathRepresentableChildrenInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).children().map { $0.0.pathString }),
            self.childFileFixture
                .union(self.childDirectoryFixture)
                .union(self.childSymlinkFixture)
        )
    }

    func testPathRepresentableChildrenRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).children(recursive: true).map { $0.0.pathString }),
            self.childFileRecursiveFixture
                .union(self.childDirectoryRecursiveFixture)
                .union(self.childSymlinkRecursiveFixture)
        )
    }

    func testPathRepresentableFilesInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).children(ofType: .file).map { $0.pathString }),
            self.childFileFixture
        )
    }

    func testPathRepresentableFilesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).children(ofType: .file, recursive: true).map { $0.pathString }),
            self.childFileRecursiveFixture
        )
    }

    func testPathRepresentableDirectoriesInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).children(ofType: .directory).map { $0.pathString }),
            self.childDirectoryFixture
        )
    }

    func testPathRepresentableDirectoriesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).children(ofType: .directory, recursive: true).map { $0.pathString }),
            self.childDirectoryRecursiveFixture
        )
    }

    func testPathRepresentableSymlinksInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).children(ofType: .symlink).map { $0.pathString }),
            self.childSymlinkFixture
        )
    }

    func testPathRepresentableSymlinksRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).children(ofType: .symlink, recursive: true).map { $0.pathString }),
            self.childSymlinkRecursiveFixture
        )
    }

    /// Negative tests: can't positively prove these are working, but at least make sure they don't return
    /// things they aren't supposed to.

    // unknownTypeFiles
    func testUnknownTypeFilesInPath() throws {
        XCTAssertEqual(Set(try children(inPath: self.fixtureRoot, ofType: .unknown)), [])
    }

    func testUnknownTypeFilesRecursiveInPath() throws {
        XCTAssertEqual(Set(try children(inPath: self.fixtureRoot, ofType: .unknown, recursive: true)), [])
    }

    func testPathRepresentableUnknownTypeFilesInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).children(ofType: .unknown).map { $0.pathString }),
            []
        )
    }

    func testPathRepresentableUnknownTypeFilesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).children(ofType: .unknown, recursive: true).map { $0.pathString }),
            []
        )
    }

    // pipes
    func testPipesInPath() throws {
        XCTAssertEqual(Set(try children(inPath: self.fixtureRoot, ofType: .pipe)), [])
    }

    func testPipesRecursiveInPath() throws {
        XCTAssertEqual(Set(try children(inPath: self.fixtureRoot, ofType: .pipe, recursive: true)), [])
    }

    func testPathRepresentablePipesInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).children(ofType: .pipe).map { $0.pathString }),
            []
        )
    }

    func testPathRepresentablePipesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).children(ofType: .pipe, recursive: true).map { $0.pathString }),
            []
        )
    }

    // characterDevices
    func testCharacterDevicesInPath() throws {
        XCTAssertEqual(Set(try children(inPath: self.fixtureRoot, ofType: .characterDevice)), [])
    }

    func testCharacterDevicesRecursiveInPath() throws {
        XCTAssertEqual(Set(try children(inPath: self.fixtureRoot, ofType: .characterDevice, recursive: true)), [])
    }

    func testPathRepresentableCharacterDevicesInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).children(ofType: .characterDevice).map { $0.pathString }),
            []
        )
    }

    func testPathRepresentableCharacterDevicesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).children(ofType: .characterDevice, recursive: true).map { $0.pathString }),
            []
        )
    }

    // blockDevices
    func testBlockDevicesInPath() throws {
        XCTAssertEqual(Set(try children(inPath: self.fixtureRoot, ofType: .blockDevice)), [])
    }

    func testBlockDevicesRecursiveInPath() throws {
        XCTAssertEqual(Set(try children(inPath: self.fixtureRoot, ofType: .blockDevice, recursive: true)), [])
    }

    func testPathRepresentableBlockDevicesInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).children(ofType: .blockDevice).map { $0.pathString }),
            []
        )
    }

    func testPathRepresentableBlockDevicesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).children(ofType: .blockDevice, recursive: true).map { $0.pathString }),
            []
        )
    }

    // sockets
    func testSocketsInPath() throws {
        XCTAssertEqual(Set(try children(inPath: self.fixtureRoot, ofType: .socket)), [])
    }

    func testSocketsRecursiveInPath() throws {
        XCTAssertEqual(Set(try children(inPath: self.fixtureRoot, ofType: .socket, recursive: true)), [])
    }

    func testPathRepresentableSocketsInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).children(ofType: .socket).map { $0.pathString }),
            []
        )
    }

    func testPathRepresentableSocketsRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(self.fixtureRoot).children(ofType: .socket, recursive: true).map { $0.pathString }),
            []
        )
    }

    func testPathRepresentableNotFollowingSymlinks() throws {
        XCTAssertEqual(
            Set(self.fixturePath(.secondDirectoryThatExists).children().map { $0.0 }),
            [self.fixturePath(.secondSymbolInDirectory)]
        )
    }

    func testPathRepresentableFollowingSymlinks() throws {
        XCTAssertEqual(
            Set(self.fixturePath(.secondDirectoryThatExists).children(followSymlink: true).map { $0.0 }),
            [
                self.fixturePath(.secondSymbolInDirectory),
                self.fixturePath(.secondFileViaSymlink),
            ]
        )
    }
}
