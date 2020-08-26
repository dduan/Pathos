import Pathos
import XCTest

final class POSIXPathJoiningTests: XCTestCase {
    func testSimpleJoining() {
        let a = PurePOSIXPath("a")
        let b = PurePOSIXPath("b")
        XCTAssertEqual(a.joined(with: b), PurePOSIXPath("a/b"))
    }

    func testSimpleJoiningWithMulilpePaths() {
        let a = PurePOSIXPath("a")
        let b = PurePOSIXPath("b")
        let c = PurePOSIXPath("c")
        let d = PurePOSIXPath("d")
        XCTAssertEqual(a.joined(with: b, c, d), PurePOSIXPath("a/b/c/d"))
    }

    func testJoiningWithExsitingSeparator() {
        let a = PurePOSIXPath("a/")
        let b = PurePOSIXPath("b")
        XCTAssertEqual(a.joined(with: b), PurePOSIXPath("a/b"))
    }

    func testSimpleJoiningStartingWithAbsolutePath() {
        let a = PurePOSIXPath("/a")
        let b = PurePOSIXPath("b")
        XCTAssertEqual(a.joined(with: b), PurePOSIXPath("/a/b"))
    }

    func testSimpleJoiningEndingWithAbsolutePath() {
        let a = PurePOSIXPath("a")
        let b = PurePOSIXPath("/b")
        XCTAssertEqual(a.joined(with: b), PurePOSIXPath("/b"))
    }

    func testSimpleJoiningStartingAndEndingWithAbsolutePath() {
        let a = PurePOSIXPath("/a")
        let b = PurePOSIXPath("/b")
        XCTAssertEqual(a.joined(with: b), PurePOSIXPath("/b"))
    }

    func testSimpleJoiningWithMultipleAbsolutePath() {
        let a = PurePOSIXPath("a")
        let b = PurePOSIXPath("/b/b")
        let c = PurePOSIXPath("/c")
        let d = PurePOSIXPath("d")
        XCTAssertEqual(a.joined(with: b, c, d), PurePOSIXPath("/c/d"))
    }

    func testJoiningMixedTypes() {
        let a = PurePOSIXPath("a")
        let b = "b"
        let c = PurePOSIXPath("c")
        let d = "d"
        XCTAssertEqual(a.joined(with: b, c, d), PurePOSIXPath("a/b/c/d"))
    }

    func testOperator() {
        let result = PurePOSIXPath("/") + "a" + PurePOSIXPath("b") + "c"
        XCTAssertEqual(result, PurePOSIXPath("/a/b/c"))
    }
}
