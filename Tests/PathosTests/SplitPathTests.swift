import Pathos
import XCTest

final class SplitPathTests: XCTestCase {

    func _testSplitPath(_ path: String, _ expected: (String, String), file: StaticString = #file,
                        line: UInt = #line)
    {
        let result = split(path: path)
        XCTAssertEqual(result.0, expected.0, file: file, line: line)
        XCTAssertEqual(result.1, expected.1, file: file, line: line)
    }

    func _testPathRepresentableSplit(_ path: String, _ expected: (String, String), file: StaticString = #file,
                                     line: UInt = #line)
    {
        let result = Path(string: path).split()
        XCTAssertEqual(result.0.pathString, expected.0, file: file, line: line)
        XCTAssertEqual(result.1.pathString, expected.1, file: file, line: line)
    }

    func testSplitSimplePath() {
        _testSplitPath("/foo/bar", ("/foo", "bar"))
    }

    func testSplitRootPath() {
        _testSplitPath("/", ("/", ""))
    }

    func testSplitSingleCompomentPath() {
        _testSplitPath("foo", ("", "foo"))
    }

    func testSplitWithABunchOfPrefixSlashes() {
        _testSplitPath("////foo", ("////", "foo"))
    }

    func testSplitWithRedundantSeparator() {
        _testSplitPath("//foo//bar", ("//foo", "bar"))
    }

    func testPathRepresentableSplitSimplePath() {
        _testPathRepresentableSplit("/foo/bar", ("/foo", "bar"))
    }

    func testPathRepresentableSplitRootPath() {
        _testPathRepresentableSplit("/", ("/", ""))
    }

    func testPathRepresentableSplitSingleCompomentPath() {
        _testPathRepresentableSplit("foo", ("", "foo"))
    }

    func testPathRepresentableSplitWithABunchOfPrefixSlashes() {
        _testPathRepresentableSplit("////foo", ("////", "foo"))
    }

    func testPathRepresentableSplitWithRedundantSeparator() {
        _testPathRepresentableSplit("//foo//bar", ("//foo", "bar"))
    }
}
