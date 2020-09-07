import Pathos
import XCTest

final class PurePOSIXPathNormalTests: XCTestCase {
    func testEmptyPathBecomesCurrentContext() {
        XCTAssertEqual(PurePOSIXPath("").normal, PurePOSIXPath("."))
    }

    func testRoots() {
        XCTAssertEqual(PurePOSIXPath("/").normal, PurePOSIXPath("/"))
        XCTAssertEqual(PurePOSIXPath("//").normal, PurePOSIXPath("//"))
        XCTAssertEqual(PurePOSIXPath("///").normal, PurePOSIXPath("/"))
    }

    func testNormalization() {
        XCTAssertEqual(Path("///foo/.//bar//").normal, Path("/foo/bar"))
        XCTAssertEqual(Path("///foo/.//bar//.//..//.//baz").normal, Path("/foo/baz"))
        XCTAssertEqual(Path("///..//./foo/.//bar").normal, Path("/foo/bar"))
    }
}
