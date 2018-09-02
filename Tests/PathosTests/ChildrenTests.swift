import Pathos
import XCTest

final class ChildrenTests: FixtureTestCase {
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
}
