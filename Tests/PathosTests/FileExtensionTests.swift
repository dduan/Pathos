import Pathos
import XCTest

final class FileExtensionTests: XCTestCase {
    func testFileExtensionOnSimplePath() {
        XCTAssertEqual(fileExtension(ofPath: "foo.bar"), ".bar")
    }

    func testFileExtensionOnPathWithMultipleDots() {
        XCTAssertEqual(fileExtension(ofPath: "foo.boo.bar"), ".bar")
        XCTAssertEqual(fileExtension(ofPath:"foo.boo.biff.bar"), ".bar")
    }

    func testFileExtensionOnPathWithLeadingDot() {
        XCTAssertEqual(fileExtension(ofPath: ".csh.rc"), ".rc")
    }

    func testFileExtensionOnPathWithNoDots() {
        XCTAssertEqual(fileExtension(ofPath: "nodots"), "")
    }

    func testFileExtensionOnPathWithLeadingDotButNoExtension() {
        XCTAssertEqual(fileExtension(ofPath: ".cshrc"), "")
    }

    func testFileExtensionOnPathWithManyLeadingDotsButNoExtension() {
        XCTAssertEqual(fileExtension(ofPath: "...manydots"), "")
    }

    func testFileExtensionOnPathWithLeadingDotsButNoExtension() {
         XCTAssertEqual(fileExtension(ofPath: "...manydots.ext"), ".ext")
    }

    func testFileExtensionOnPathWithLeadingDots() {
        XCTAssertEqual(fileExtension(ofPath: "."), "")
    }

    func testFileExtensionOnPathWithOnlyDots() {
        XCTAssertEqual(fileExtension(ofPath: ".."), "")
        XCTAssertEqual(fileExtension(ofPath: "........"), "")
    }

    func testFileExtensionOnEmptyPath() {
        XCTAssertEqual(fileExtension(ofPath: ""), "")
    }

    func testPathRepresentableFileExtensionOnSimplePath() {
        XCTAssertEqual(Path("foo.bar").extension, ".bar")
    }

    func testPathRepresentableFileExtensionOnPathWithMultipleDots() {
        XCTAssertEqual(Path("foo.boo.bar").extension, ".bar")
        XCTAssertEqual(Path("foo.boo.biff.bar").extension, ".bar")
    }

    func testPathRepresentableFileExtensionOnPathWithLeadingDot() {
        XCTAssertEqual(Path(".csh.rc").extension, ".rc")
    }

    func testPathRepresentableFileExtensionOnPathWithNoDots() {
        XCTAssertEqual(Path("nodots").extension, "")
    }

    func testPathRepresentableFileExtensionOnPathWithLeadingDotButNoExtension() {
        XCTAssertEqual(Path(".cshrc").extension, "")
    }

    func testPathRepresentableFileExtensionOnPathWithManyLeadingDotsButNoExtension() {
        XCTAssertEqual(Path("...manydots").extension, "")
    }

    func testPathRepresentableFileExtensionOnPathWithLeadingDotsButNoExtension() {
         XCTAssertEqual(Path("...manydots.ext").extension, ".ext")
    }

    func testPathRepresentableFileExtensionOnPathWithLeadingDots() {
        XCTAssertEqual(Path(".").extension, "")
    }

    func testPathRepresentableFileExtensionOnPathWithOnlyDots() {
        XCTAssertEqual(Path("..").extension, "")
        XCTAssertEqual(fileExtension(ofPath: "........"), "")
    }

    func testPathRepresentableFileExtensionOnEmptyPath() {
        XCTAssertEqual(Path("").extension, "")
    }
}
