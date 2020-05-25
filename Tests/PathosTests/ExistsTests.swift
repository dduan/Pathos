import Pathos
import XCTest

#if !os(Windows)
final class ExistsTests: XCTestCase {
    func testExistingFiles() {
        XCTAssertTrue(exists(atPath: self.fixture(.fileThatExists)))
    }

    func testNonExistingFiles() {
        XCTAssertFalse(exists(atPath: self.fixture(.noneExistence)))
    }

    func testExistingFilesFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(.fileThatExists), followSymlink: true))
    }

    func testExistingFilesNotFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(.fileThatExists), followSymlink: false))
    }

    func testGoodSymlink() {
        XCTAssertTrue(exists(atPath: self.fixture(.goodFileSymbol)))
    }

    func testGoodSymbolicDirectoryLink() {
        XCTAssertTrue(exists(atPath: self.fixture(.goodDirectorySymbol)))
    }

    func testBadSymlink() {
        XCTAssertFalse(exists(atPath: self.fixture(.badSymbol)))
    }

    func testGoodSymlinkFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(.goodFileSymbol), followSymlink: true))
    }

    func testGoodSymbolicDirectoryLinkFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(.goodDirectorySymbol), followSymlink: true))
    }

    func testBadSymlinkFollowingSymbol() {
        XCTAssertFalse(exists(atPath: self.fixture(.badSymbol), followSymlink: true))
    }

    func testGoodSymlinkNotFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(.goodFileSymbol), followSymlink: false))
    }

    func testGoodSymbolicDirectoryLinkNotFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(.goodDirectorySymbol), followSymlink: false))
    }

    func testBadSymlinkNotFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(.badSymbol), followSymlink: false))
    }

    func testPathRepresentableExistingFiles() {
        XCTAssertTrue(self.fixturePath(.fileThatExists).exists())
    }

    func testPathRepresentableNonExistingFiles() {
        XCTAssertFalse(self.fixturePath(.noneExistence).exists())
    }

    func testPathRepresentableExistingFileFollowingSymbol() {
        XCTAssertTrue(self.fixturePath(.fileThatExists).exists(followSymlink: true))
    }

    func testPathRepresentableExistingFileNotFollowingSymbol() {
        XCTAssertTrue(self.fixturePath(.fileThatExists).exists(followSymlink: false))
    }

    func testPathRepresentableGoodSymlink() {
        XCTAssertTrue(self.fixturePath(.goodFileSymbol).exists())
    }

    func testPathRepresentableGoodSymbolicDirectoryLink() {
        XCTAssertTrue(self.fixturePath(.goodDirectorySymbol).exists())
    }

    func testPathRepresentableBadSymlink() {
        XCTAssertFalse(self.fixturePath(.badSymbol).exists())
    }

    func testPathRepresentableGoodSymlinkFollowingSymbol() {
        XCTAssertTrue(self.fixturePath(.goodFileSymbol).exists(followSymlink: true))
    }

    func testPathRepresentableGoodSymbolicDirectoryLinkFollowingSymbol() {
        XCTAssertTrue(self.fixturePath(.goodDirectorySymbol).exists(followSymlink: true))
    }

    func testPathRepresentableBadSymlinkFollowingSymbol() {
        XCTAssertFalse(self.fixturePath(.badSymbol).exists(followSymlink: true))
    }

    func testPathRepresentableGoodSymlinkNotFollowingSymbol() {
        XCTAssertTrue(self.fixturePath(.goodFileSymbol).exists(followSymlink: false))
    }

    func testPathRepresentableGoodDirectorySymlinkNotFollowingSymbol() {
        XCTAssertTrue(self.fixturePath(.goodDirectorySymbol).exists(followSymlink: false))
    }

    func testPathRepresentableBadSymlinkNotFollowingSymbol() {
        XCTAssertTrue(self.fixturePath(.badSymbol).exists(followSymlink: false))
    }
}
#endif
