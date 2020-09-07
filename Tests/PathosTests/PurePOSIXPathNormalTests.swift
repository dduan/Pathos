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
        XCTAssertEqual(PurePOSIXPath("///foo/.//bar//").normal, PurePOSIXPath("/foo/bar"))
        XCTAssertEqual(PurePOSIXPath("///foo/.//bar//.//..//.//baz").normal, PurePOSIXPath("/foo/baz"))
        XCTAssertEqual(PurePOSIXPath("///..//./foo/.//bar").normal, PurePOSIXPath("/foo/bar"))
    }
}
