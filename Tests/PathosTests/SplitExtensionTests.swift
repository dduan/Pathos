import Pathos
import XCTest

final class SplitExtensionTests: XCTestCase {
    func _testSplitExtension(_ path: String, _ filename: String, _ fileExtension: String,
                             file: StaticString = #file, line: UInt = #line)
    {
        var result = splitExtension(ofPath: path)
        XCTAssertEqual(result.0, filename, file: file, line: line)
        XCTAssertEqual(result.1, fileExtension, file: file, line: line)

        result = splitExtension(ofPath: "/" + path)
        XCTAssertEqual(result.0, "/" + filename, file: file, line: line)
        XCTAssertEqual(result.1, fileExtension, file: file, line: line)

        result = splitExtension(ofPath: "abc/" + path)
        XCTAssertEqual(result.0, "abc/" + filename, file: file, line: line)
        XCTAssertEqual(result.1, fileExtension, file: file, line: line)

        result = splitExtension(ofPath: "abc.def/" + path)
        XCTAssertEqual(result.0, "abc.def/" + filename, file: file, line: line)
        XCTAssertEqual(result.1, fileExtension, file: file, line: line)

        result = splitExtension(ofPath: "/abc.def/" + path)
        XCTAssertEqual(result.0, "/abc.def/" + filename, file: file, line: line)
        XCTAssertEqual(result.1, fileExtension, file: file, line: line)

        result = splitExtension(ofPath: path + "/")
        XCTAssertEqual(result.0, filename + fileExtension + "/", file: file, line: line)
        XCTAssertEqual(result.1, "", file: file, line: line)
    }

    func _testPathRepresentableSplitExtension(_ path: String, _ filename: String, _ fileExtension: String,
                                              file: StaticString = #file, line: UInt = #line)
    {
        var result = Path(path).splitExtension()
        XCTAssertEqual(result.0.pathString, filename, file: file, line: line)
        XCTAssertEqual(result.1, fileExtension, file: file, line: line)

        result = Path("/" + path).splitExtension()
        XCTAssertEqual(result.0.pathString, "/" + filename, file: file, line: line)
        XCTAssertEqual(result.1, fileExtension, file: file, line: line)

        result = Path("abc/" + path).splitExtension()
        XCTAssertEqual(result.0.pathString, "abc/" + filename, file: file, line: line)
        XCTAssertEqual(result.1, fileExtension, file: file, line: line)

        result = Path("abc.def/" + path).splitExtension()
        XCTAssertEqual(result.0.pathString, "abc.def/" + filename, file: file, line: line)
        XCTAssertEqual(result.1, fileExtension, file: file, line: line)

        result = Path("/abc.def/" + path).splitExtension()
        XCTAssertEqual(result.0.pathString, "/abc.def/" + filename, file: file, line: line)
        XCTAssertEqual(result.1, fileExtension, file: file, line: line)

        result = Path(path + "/").splitExtension()
        XCTAssertEqual(result.0.pathString, filename + fileExtension + "/", file: file, line: line)
        XCTAssertEqual(result.1, "", file: file, line: line)
    }

    func testSplitExtensionOnSimplePath() {
        _testSplitExtension("foo.bar", "foo", ".bar")
    }

    func testSplitExtensionOnPathWithMultipleDots() {
        _testSplitExtension("foo.boo.bar", "foo.boo", ".bar")
        _testSplitExtension("foo.boo.biff.bar", "foo.boo.biff", ".bar")
    }

    func testSplitExtensionOnPathWithLeadingDot() {
        _testSplitExtension(".csh.rc", ".csh", ".rc")
    }

    func testSplitExtensionOnPathWithNoDots() {
        _testSplitExtension("nodots", "nodots", "")
    }

    func testSplitExtensionOnPathWithLeadingDotButNoExtension() {
        _testSplitExtension(".cshrc", ".cshrc", "")
    }

    func testSplitExtensionOnPathWithManyLeadingDotsButNoExtension() {
        _testSplitExtension("...manydots", "...manydots", "")
    }

    func testSplitExtensionOnPathWithLeadingDotsButNoExtension() {
        _testSplitExtension("...manydots.ext", "...manydots", ".ext")
    }

    func testSplitExtensionOnPathWithLeadingDots() {
        _testSplitExtension(".", ".", "")
    }

    func testSplitExtensionOnPathWithOnlyDots() {
        _testSplitExtension("..", "..", "")
        _testSplitExtension("........", "........", "")
    }

    func testSplitExtensionOnEmptyPath() {
        _testSplitExtension("", "", "")
    }

    func testPathRepresentableSplitExtensionOnSimplePath() {
        _testPathRepresentableSplitExtension("foo.bar", "foo", ".bar")
    }

    func testPathRepresentableSplitExtensionOnPathWithMultipleDots() {
        _testPathRepresentableSplitExtension("foo.boo.bar", "foo.boo", ".bar")
        _testPathRepresentableSplitExtension("foo.boo.biff.bar", "foo.boo.biff", ".bar")
    }

    func testPathRepresentableSplitExtensionOnPathWithLeadingDot() {
        _testPathRepresentableSplitExtension(".csh.rc", ".csh", ".rc")
    }

    func testPathRepresentableSplitExtensionOnPathWithNoDots() {
        _testPathRepresentableSplitExtension("nodots", "nodots", "")
    }

    func testPathRepresentableSplitExtensionOnPathWithLeadingDotButNoExtension() {
        _testPathRepresentableSplitExtension(".cshrc", ".cshrc", "")
    }

    func testPathRepresentableSplitExtensionOnPathWithManyLeadingDotsButNoExtension() {
        _testPathRepresentableSplitExtension("...manydots", "...manydots", "")
    }

    func testPathRepresentableSplitExtensionOnPathWithLeadingDotsButNoExtension() {
        _testPathRepresentableSplitExtension("...manydots.ext", "...manydots", ".ext")
    }

    func testPathRepresentableSplitExtensionOnPathWithLeadingDots() {
        _testPathRepresentableSplitExtension(".", ".", "")
    }

    func testPathRepresentableSplitExtensionOnPathWithOnlyDots() {
        _testPathRepresentableSplitExtension("..", "..", "")
        _testPathRepresentableSplitExtension("........", "........", "")
    }

    func testPathRepresentableSplitExtensionOnEmptyPath() {
        _testPathRepresentableSplitExtension("", "", "")
    }
}
