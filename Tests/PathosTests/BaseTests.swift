import Pathos
import XCTest

final class BaseTests: XCTestCase {
    func testBaseDoesNotContainExtension() {
        let path = Path("hello") + "world.md"
        let base = Path("hello") + "world"
        XCTAssertEqual(path.base, base)
    }

    func testBaseOfPathWithoutExtensionIsItself() {
        let path = Path("hello") + "world"
        XCTAssertEqual(path.base, path)
    }
}
