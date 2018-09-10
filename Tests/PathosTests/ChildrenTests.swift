import Pathos
import XCTest

final class ChildrenTests: XCTestCase {
    func testChildrenInPath() {
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

    func testFilesInPath() {
        XCTAssertEqual(
            Set(try files(inPath: self.fixtureRoot)),
            self.childFiles
        )
    }

    func testFilesRecursiveInPath() {
        XCTAssertEqual(
            Set(try files(inPath: self.fixtureRoot, recursive: true)),
            self.childFilesRecursive
        )
    }

    func testDirectoriesInPath() {
        XCTAssertEqual(
            Set(try directories(inPath: self.fixtureRoot)),
            self.childDirectories
        )
    }

    func testDirectoriesRecursiveInPath() {
        XCTAssertEqual(
            Set(try directories(inPath: self.fixtureRoot, recursive: true)),
            self.childDirectoriesRecursive
        )
    }

    func testSymbolicLinksInPath() {
        XCTAssertEqual(
            Set(try symbolicLinks(inPath: self.fixtureRoot)),
            self.childSymbolicLinks
        )
    }

    func testSymbolicLinksRecursiveInPath() {
        XCTAssertEqual(
            Set(try symbolicLinks(inPath: self.fixtureRoot, recursive: true)),
            self.childSymbolicLinksRecursive
        )
    }

    func testPathRepresentableChildrenInPath() {
        XCTAssertEqual(
            Set(Path(string: self.fixtureRoot).children().map { $0.pathString }),
            self.childFiles
                .union(self.childDirectories)
                .union(self.childSymbolicLinks)
        )
    }

    func testPathRepresentableChildrenRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(string: self.fixtureRoot).children(recursive: true).map { $0.pathString }),
            self.childFilesRecursive
                .union(self.childDirectoriesRecursive)
                .union(self.childSymbolicLinksRecursive)
        )
    }

    func testPathRepresentableFilesInPath() {
        XCTAssertEqual(
            Set(Path(string: self.fixtureRoot).files().map { $0.pathString }),
            self.childFiles
        )
    }

    func testPathRepresentableFilesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(string: self.fixtureRoot).files(recursive: true).map { $0.pathString }),
            self.childFilesRecursive
        )
    }

    func testPathRepresentableDirectoriesInPath() {
        XCTAssertEqual(
            Set(Path(string: self.fixtureRoot).directories().map { $0.pathString }),
            self.childDirectories
        )
    }

    func testPathRepresentableDirectoriesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(string: self.fixtureRoot).directories(recursive: true).map { $0.pathString }),
            self.childDirectoriesRecursive
        )
    }

    func testPathRepresentableSymbolicLinksInPath() {
        XCTAssertEqual(
            Set(Path(string: self.fixtureRoot).symbolicLinks().map { $0.pathString }),
            self.childSymbolicLinks
        )
    }

    func testPathRepresentableSymbolicLinksRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(string: self.fixtureRoot).symbolicLinks(recursive: true).map { $0.pathString }),
            self.childSymbolicLinksRecursive
        )
    }

    /// Negative tests: can't positively prove these are working, but at least make sure they don't return
    /// things they aren't supposed to.

    // unknownTypeFiles
    func testUnknownTypeFilesInPath() {
        XCTAssertEqual(Set(try unknownTypeFiles(inPath: self.fixtureRoot)), [])
    }

    func testUnknownTypeFilesRecursiveInPath() {
        XCTAssertEqual(Set(try unknownTypeFiles(inPath: self.fixtureRoot, recursive: true)), [])
    }

    func testPathRepresentableUnknownTypeFilesInPath() {
        XCTAssertEqual(
            Set(Path(string: self.fixtureRoot).unknownTypeFiles().map { $0.pathString }), 
            []
        )
    }

    func testPathRepresentableUnknownTypeFilesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(string: self.fixtureRoot).unknownTypeFiles(recursive: true).map { $0.pathString }), 
            []
        )
    }

    // pipes
    func testPipesInPath() {
        XCTAssertEqual(Set(try pipes(inPath: self.fixtureRoot)), [])
    }

    func testPipesRecursiveInPath() {
        XCTAssertEqual(Set(try pipes(inPath: self.fixtureRoot, recursive: true)), [])
    }

    func testPathRepresentablePipesInPath() {
        XCTAssertEqual(
            Set(Path(string: self.fixtureRoot).pipes().map { $0.pathString }), 
            []
        )
    }

    func testPathRepresentablePipesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(string: self.fixtureRoot).pipes(recursive: true).map { $0.pathString }), 
            []
        )
    }

    // characterDevices
    func testCharacterDevicesInPath() {
        XCTAssertEqual(Set(try characterDevices(inPath: self.fixtureRoot)), [])
    }

    func testCharacterDevicesRecursiveInPath() {
        XCTAssertEqual(Set(try characterDevices(inPath: self.fixtureRoot, recursive: true)), [])
    }

    func testPathRepresentableCharacterDevicesInPath() {
        XCTAssertEqual(
            Set(Path(string: self.fixtureRoot).characterDevices().map { $0.pathString }), 
            []
        )
    }

    func testPathRepresentableCharacterDevicesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(string: self.fixtureRoot).characterDevices(recursive: true).map { $0.pathString }), 
            []
        )
    }

    // blockDevices
    func testBlockDevicesInPath() {
        XCTAssertEqual(Set(try blockDevices(inPath: self.fixtureRoot)), [])
    }

    func testBlockDevicesRecursiveInPath() {
        XCTAssertEqual(Set(try blockDevices(inPath: self.fixtureRoot, recursive: true)), [])
    }

    func testPathRepresentableBlockDevicesInPath() {
        XCTAssertEqual(
            Set(Path(string: self.fixtureRoot).blockDevices().map { $0.pathString }), 
            []
        )
    }

    func testPathRepresentableBlockDevicesRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(string: self.fixtureRoot).blockDevices(recursive: true).map { $0.pathString }), 
            []
        )
    }

    // sockets
    func testSocketsInPath() {
        XCTAssertEqual(Set(try sockets(inPath: self.fixtureRoot)), [])
    }

    func testSocketsRecursiveInPath() {
        XCTAssertEqual(Set(try sockets(inPath: self.fixtureRoot, recursive: true)), [])
    }

    func testPathRepresentableSocketsInPath() {
        XCTAssertEqual(
            Set(Path(string: self.fixtureRoot).sockets().map { $0.pathString }), 
            []
        )
    }

    func testPathRepresentableSocketsRecursiveInPath() {
        XCTAssertEqual(
            Set(Path(string: self.fixtureRoot).sockets(recursive: true).map { $0.pathString }), 
            []
        )
    }
}
