import Pathos
import XCTest

let kPathThatExists = "hello"
let kPathThatExistsNot = "hello_not"

final class ExistsTest: FixtureTestCase {
    func testExistingFiles() {
        XCTAssertTrue(exists(atPath: self.fixture(kPathThatExists)))
    }

    func testNonExistingFiles() {
        XCTAssertFalse(exists(atPath: self.fixture(kPathThatExistsNot)))
    }

    func testPathRepresentableExistingFiles() {
        let path = self.fixtureRootPath.join(with: Path(string: kPathThatExists))
        XCTAssertTrue(path.exists())
    }

    func testPathRepresentableNonExistingFiles() {
        let path = self.fixtureRootPath.join(with: Path(string: kPathThatExistsNot))
        XCTAssertFalse(path.exists())
    }
}
