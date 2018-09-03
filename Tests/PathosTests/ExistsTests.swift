import Pathos
import XCTest

final class ExistsTests: FixtureTestCase {
    func testExistingFiles() {
        XCTAssertTrue(exists(atPath: self.fixture(.fileThatExists)))
    }

    func testNonExistingFiles() {
        XCTAssertFalse(exists(atPath: self.fixture(.noneExistence)))
    }

    func testExistingFilesFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(.fileThatExists), followSymbol: true))
    }

    func testExistingFilesNotFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(.fileThatExists), followSymbol: false))
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
        XCTAssertTrue(exists(atPath: self.fixture(.goodFileSymbol), followSymbol: true))
    }

    func testGoodSymbolicDirectoryLinkFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(.goodDirectorySymbol), followSymbol: true))
    }

    func testBadSymbolicLinkFollowingSymbol() {
        XCTAssertFalse(exists(atPath: self.fixture(.badSymbol), followSymbol: true))
    }

    func testGoodSymbolicLinkNotFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(.goodFileSymbol), followSymbol: false))
    }

    func testGoodSymbolicDirectoryLinkNotFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(.goodDirectorySymbol), followSymbol: false))
    }

    func testBadSymbolicLinkNotFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(.badSymbol), followSymbol: false))
    }

    func testPathRepresentableExistingFiles() {
        XCTAssertTrue(self.fixturePath(.fileThatExists).exists())
    }

    func testPathRepresentableNonExistingFiles() {
        XCTAssertFalse(self.fixturePath(.noneExistence).exists())
    }

    func testPathRepresentableExistingFileFollowingSymbol() {
        XCTAssertTrue(self.fixturePath(.fileThatExists).exists(followSymbol: true))
    }

    func testPathRepresentableExistingFileNotFollowingSymbol() {
        XCTAssertTrue(self.fixturePath(.fileThatExists).exists(followSymbol: false))
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
        XCTAssertTrue(self.fixturePath(.goodFileSymbol).exists(followSymbol: true))
    }

    func testPathRepresentableGoodSymbolicDirectorcyLinkFollowingSymbol() {
        XCTAssertTrue(self.fixturePath(.goodDirectorySymbol).exists(followSymbol: true))
    }

    func testPathRepresentableBadSymbolicLinkFollowingSymbol() {
        XCTAssertFalse(self.fixturePath(.badSymbol).exists(followSymbol: true))
    }

    func testPathRepresentableGoodSymbolicLinkNotFollowingSymbol() {
        XCTAssertTrue(self.fixturePath(.goodFileSymbol).exists(followSymbol: false))
    }

    func testPathRepresentableGoodDirectorySymbolicLinkNotFollowingSymbol() {
        XCTAssertTrue(self.fixturePath(.goodDirectorySymbol).exists(followSymbol: false))
    }

    func testPathRepresentableBadSymbolicLinkNotFollowingSymbol() {
        XCTAssertTrue(self.fixturePath(.badSymbol).exists(followSymbol: false))
    }
}
