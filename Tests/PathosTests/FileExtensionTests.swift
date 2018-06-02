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
        XCTAssertEqual(Path(string: "foo.bar").extension, ".bar")
    }

    func testPathRepresentableFileExtensionOnPathWithMultipleDots() {
        XCTAssertEqual(Path(string: "foo.boo.bar").extension, ".bar")
        XCTAssertEqual(Path(string:"foo.boo.biff.bar").extension, ".bar")
    }

    func testPathRepresentableFileExtensionOnPathWithLeadingDot() {
        XCTAssertEqual(Path(string: ".csh.rc").extension, ".rc")
    }

    func testPathRepresentableFileExtensionOnPathWithNoDots() {
        XCTAssertEqual(Path(string: "nodots").extension, "")
    }

    func testPathRepresentableFileExtensionOnPathWithLeadingDotButNoExtension() {
        XCTAssertEqual(Path(string: ".cshrc").extension, "")
    }

    func testPathRepresentableFileExtensionOnPathWithManyLeadingDotsButNoExtension() {
        XCTAssertEqual(Path(string: "...manydots").extension, "")
    }

    func testPathRepresentableFileExtensionOnPathWithLeadingDotsButNoExtension() {
         XCTAssertEqual(Path(string: "...manydots.ext").extension, ".ext")
    }

    func testPathRepresentableFileExtensionOnPathWithLeadingDots() {
        XCTAssertEqual(Path(string: ".").extension, "")
    }

    func testPathRepresentableFileExtensionOnPathWithOnlyDots() {
        XCTAssertEqual(Path(string: "..").extension, "")
        XCTAssertEqual(fileExtension(ofPath: "........"), "")
    }

    func testPathRepresentableFileExtensionOnEmptyPath() {
        XCTAssertEqual(Path(string: "").extension, "")
    }
}
