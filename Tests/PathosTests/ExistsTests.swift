import Pathos
import XCTest

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

    func testGoodSymbolicLink() {
        XCTAssertTrue(exists(atPath: self.fixture(.goodFileSymbol)))
    }

    func testGoodSymbolicDirectoryLink() {
        XCTAssertTrue(exists(atPath: self.fixture(.goodDirectorySymbol)))
    }

    func testBadSymbolicLink() {
        XCTAssertFalse(exists(atPath: self.fixture(.badSymbol)))
    }

    func testGoodSymbolicLinkFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(.goodFileSymbol), followSymlink: true))
    }

    func testGoodSymbolicDirectoryLinkFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(.goodDirectorySymbol), followSymlink: true))
    }

    func testBadSymbolicLinkFollowingSymbol() {
        XCTAssertFalse(exists(atPath: self.fixture(.badSymbol), followSymlink: true))
    }

    func testGoodSymbolicLinkNotFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(.goodFileSymbol), followSymlink: false))
    }

    func testGoodSymbolicDirectoryLinkNotFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(.goodDirectorySymbol), followSymlink: false))
    }

    func testBadSymbolicLinkNotFollowingSymbol() {
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

    func testPathRepresentableGoodSymbolicLink() {
        XCTAssertTrue(self.fixturePath(.goodFileSymbol).exists())
    }

    func testPathRepresentableGoodSymbolicDirectoryLink() {
        XCTAssertTrue(self.fixturePath(.goodDirectorySymbol).exists())
    }

    func testPathRepresentableBadSymbolicLink() {
        XCTAssertFalse(self.fixturePath(.badSymbol).exists())
    }

    func testPathRepresentableGoodSymbolicLinkFollowingSymbol() {
        XCTAssertTrue(self.fixturePath(.goodFileSymbol).exists(followSymlink: true))
    }

    func testPathRepresentableGoodSymbolicDirectoryLinkFollowingSymbol() {
        XCTAssertTrue(self.fixturePath(.goodDirectorySymbol).exists(followSymlink: true))
    }

    func testPathRepresentableBadSymbolicLinkFollowingSymbol() {
        XCTAssertFalse(self.fixturePath(.badSymbol).exists(followSymlink: true))
    }

    func testPathRepresentableGoodSymbolicLinkNotFollowingSymbol() {
        XCTAssertTrue(self.fixturePath(.goodFileSymbol).exists(followSymlink: false))
    }

    func testPathRepresentableGoodDirectorySymbolicLinkNotFollowingSymbol() {
        XCTAssertTrue(self.fixturePath(.goodDirectorySymbol).exists(followSymlink: false))
    }

    func testPathRepresentableBadSymbolicLinkNotFollowingSymbol() {
        XCTAssertTrue(self.fixturePath(.badSymbol).exists(followSymlink: false))
    }
}
