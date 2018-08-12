import Pathos
import XCTest

final class ExistsTest: FixtureTestCase {
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
        XCTAssertTrue(exists(atPath: self.fixture(.goodSymbol)))
    }

    func testBadSymbolicLink() {
        XCTAssertFalse(exists(atPath: self.fixture(.badSymbol)))
    }

    func testGoodSymbolicLinkFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(.goodSymbol), followSymbol: true))
    }

    func testBadSymbolicLinkFollowingSymbol() {
        XCTAssertFalse(exists(atPath: self.fixture(.badSymbol), followSymbol: true))
    }

    func testGoodSymbolicLinkNotFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(.goodSymbol), followSymbol: false))
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
        XCTAssertTrue(self.fixturePath(.goodSymbol).exists())
    }

    func testPathRepresentableBadSymbolicLink() {
        XCTAssertFalse(self.fixturePath(.badSymbol).exists())
    }

    func testPathRepresentableGoodSymbolicLinkFollowingSymbol() {
        XCTAssertTrue(self.fixturePath(.goodSymbol).exists(followSymbol: true))
    }

    func testPathRepresentableBadSymbolicLinkFollowingSymbol() {
        XCTAssertFalse(self.fixturePath(.badSymbol).exists(followSymbol: true))
    }

    func testPathRepresentableGoodSymbolicLinkNotFollowingSymbol() {
        XCTAssertTrue(self.fixturePath(.goodSymbol).exists(followSymbol: false))
    }

    func testPathRepresentableBadSymbolicLinkNotFollowingSymbol() {
        XCTAssertTrue(self.fixturePath(.badSymbol).exists(followSymbol: false))
    }
}
