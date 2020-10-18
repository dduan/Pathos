import Pathos
import XCTest

final class PureWindowsPathBaseTests: XCTestCase {
    func testBaseDoesNotContainExtension() {
        let path = PureWindowsPath(#"hello\world.md"#)
        let base = PureWindowsPath(#"hello\world"#)
        XCTAssertEqual(path.base, base)
    }

    func testBaseOfPathWithoutExtensionIsItself() {
        let path = PureWindowsPath(#"hello\world"#)
        XCTAssertEqual(path.base, path)
    }
}
