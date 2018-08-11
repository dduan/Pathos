import Pathos
import XCTest

let kPathThatExists = "hello"
let kPathThatExistsNot = "hello_not"
let kGoodSymbol = "hello_symbol"
let kBadSymbol = "broken_symbol"

final class ExistsTest: FixtureTestCase {
    func testExistingFiles() {
        XCTAssertTrue(exists(atPath: self.fixture(kPathThatExists)))
    }

    func testNonExistingFiles() {
        XCTAssertFalse(exists(atPath: self.fixture(kPathThatExistsNot)))
    }

    func testExistingFilesFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(kPathThatExists), followSymbol: true))
    }

    func testExistingFilesNotFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(kPathThatExists), followSymbol: false))
    }

    func testGoodSymbolicLink() {
        XCTAssertTrue(exists(atPath: self.fixture(kGoodSymbol)))
    }

    func testBadSymbolicLink() {
        XCTAssertFalse(exists(atPath: self.fixture(kBadSymbol)))
    }

    func testGoodSymbolicLinkFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(kGoodSymbol), followSymbol: true))
    }

    func testBadSymbolicLinkFollowingSymbol() {
        XCTAssertFalse(exists(atPath: self.fixture(kBadSymbol), followSymbol: true))
    }

    func testGoodSymbolicLinkNotFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(kGoodSymbol), followSymbol: false))
    }

    func testBadSymbolicLinkNotFollowingSymbol() {
        XCTAssertTrue(exists(atPath: self.fixture(kBadSymbol), followSymbol: false))
    }

    func testPathRepresentableExistingFiles() {
        let path = self.fixtureRootPath.join(with: Path(string: kPathThatExists))
        XCTAssertTrue(path.exists())
    }

    
    func testPathRepresentableNonExistingFiles() {
        let path = self.fixtureRootPath.join(with: Path(string: kPathThatExistsNot))
        XCTAssertFalse(path.exists())
    }

    func testPathRepresentableExistingFileFollowingSymbol() {
        let path = self.fixtureRootPath.join(with: Path(string: kPathThatExists))
        XCTAssertTrue(path.exists())
    }

    func testPathRepresentableExistingFileNotFollowingSymbol() {
        let path = self.fixtureRootPath.join(with: Path(string: kPathThatExists))
        XCTAssertTrue(path.exists())
    }

    func testPathRepresentableGoodSymbolicLink() {
        let path = self.fixtureRootPath.join(with: Path(string: kGoodSymbol))
        XCTAssertTrue(path.exists())
    }

    func testPathRepresentableBadSymbolicLink() {
        let path = self.fixtureRootPath.join(with: Path(string: kBadSymbol))
        XCTAssertFalse(path.exists())
    }

    func testPathRepresentableGoodSymbolicLinkFollowingSymbol() {
        let path = self.fixtureRootPath.join(with: Path(string: kGoodSymbol))
        XCTAssertTrue(path.exists(followSymbol: true))
    }

    func testPathRepresentableBadSymbolicLinkFollowingSymbol() {
        let path = self.fixtureRootPath.join(with: Path(string: kBadSymbol))
        XCTAssertFalse(path.exists(followSymbol: true))
    }

    func testPathRepresentableGoodSymbolicLinkNotFollowingSymbol() {
        let path = self.fixtureRootPath.join(with: Path(string: kGoodSymbol))
        XCTAssertTrue(path.exists(followSymbol: false))
    }

    func testPathRepresentableBadSymbolicLinkNotFollowingSymbol() {
        let path = self.fixtureRootPath.join(with: Path(string: kBadSymbol))
        XCTAssertTrue(path.exists(followSymbol: false))
    }
}
