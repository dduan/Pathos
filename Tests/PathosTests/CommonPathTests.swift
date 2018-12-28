import Pathos
import XCTest

final class CommonPathTests: XCTestCase {
    func testAbsolutePathWithoutTrailingSeparator() {
        XCTAssertEqual(commonPath(amongPaths: "/usr/local", "/usr/local"), "/usr/local")
    }

    func testAbsolutePathWithMixedTrailingSeparator() {
        XCTAssertEqual(commonPath(amongPaths: "/usr/local/", "/usr/local"), "/usr/local")
    }

    func testAbsolutePathWithTrailingSeparator() {
        XCTAssertEqual(commonPath(amongPaths: "/usr/local/", "/usr/local/"), "/usr/local")
    }

    func testAbsolutePathWithMixedExtraStartingSeparator() {
        XCTAssertEqual(commonPath(amongPaths: "/usr/local/", "//usr/local/"), "/usr/local")
    }

    func testAbsolutePathWithCurrentDirectorySegements() {
        XCTAssertEqual(commonPath(amongPaths: "/usr/./local/", "/./usr/local/"), "/usr/local")
    }

    func testAbsolutePath() {
        XCTAssertEqual(commonPath(amongPaths: "/", "/dev"), "/")
        XCTAssertEqual(commonPath(amongPaths: "/usr", "/dev"), "/")
        XCTAssertEqual(commonPath(amongPaths: "/usr/lib/", "/usr/lib/swift"), "/usr/lib")
    }

    func testSegmentWithCommonPrefix() {
        XCTAssertEqual(commonPath(amongPaths: "/usr/lib/", "/usr/lib64/"), "/usr")
    }

    func testMixedTrailingSeparatorInMixedOrders() {
        XCTAssertEqual(commonPath(amongPaths: "/usr/lib", "/usr/lib64/"), "/usr")
        XCTAssertEqual(commonPath(amongPaths: "/usr/lib/", "/usr/lib64"), "/usr")
    }

    func testRelativePath() {
        XCTAssertEqual(commonPath(amongPaths: "spam", "spam"), "spam")
        XCTAssertEqual(commonPath(amongPaths: "spam", "alot"), "")
        XCTAssertEqual(commonPath(amongPaths: "and/jam", "and/spam"), "and")
        XCTAssertEqual(commonPath(amongPaths: "and/jam", "and/spam", "alot"), "")
        XCTAssertEqual(commonPath(amongPaths: "and/jam", "and/spam", "and"), "and")
    }

    func testRelativePathWithExtraSeparators() {
        XCTAssertEqual(commonPath(amongPaths: "and//jam", "and/spam//"), "and")
    }

    func testMixingAbsoluteAndRelativePaths() {
        XCTAssertEqual(commonPath(amongPaths: "/bin", "bin"), "")
    }

    private func checkPathRepresentable(_ first: String, _ second: String) -> String? {
        return Path(string: first).commonPath(with: Path(string: second))?.pathString
    }

    private func checkPathRepresentable(_ first: String, _ second: String, _ third: String) -> String? {
        return Path(string: first).commonPath(with: Path(string: second), Path(string: third))?.pathString
    }

    func testPathRepresentableAbsolutePathWithoutTrailingSeparator() {
        XCTAssertEqual(checkPathRepresentable("/usr/local", "/usr/local"), "/usr/local")
    }

    func testPathRepresentableAbsolutePathWithMixedTrailingSeparator() {
        XCTAssertEqual(checkPathRepresentable("/usr/local/", "/usr/local"), "/usr/local")
    }

    func testPathRepresentableAbsolutePathWithTrailingSeparator() {
        XCTAssertEqual(checkPathRepresentable("/usr/local/", "/usr/local/"), "/usr/local")
    }

    func testPathRepresentableAbsolutePathWithMixedExtraStartingSeparator() {
        XCTAssertEqual(checkPathRepresentable("/usr/local/", "//usr/local/"), "/usr/local")
    }

    func testPathRepresentableAbsolutePathWithCurrentDirectorySegements() {
        XCTAssertEqual(checkPathRepresentable("/usr/./local/", "/./usr/local/"), "/usr/local")
    }

    func testPathRepresentableAbsolutePath() {
        XCTAssertEqual(checkPathRepresentable("/", "/dev"), "/")
        XCTAssertEqual(checkPathRepresentable("/usr", "/dev"), "/")
        XCTAssertEqual(checkPathRepresentable("/usr/lib/", "/usr/lib/swift"), "/usr/lib")
    }

    func testPathRepresentableSegmentWithCommonPrefix() {
        XCTAssertEqual(checkPathRepresentable("/usr/lib/", "/usr/lib64/"), "/usr")
    }

    func testPathRepresentableMixedTrailingSeparatorInMixedOrders() {
        XCTAssertEqual(checkPathRepresentable("/usr/lib", "/usr/lib64/"), "/usr")
        XCTAssertEqual(checkPathRepresentable("/usr/lib/", "/usr/lib64"), "/usr")
    }

    func testPathRepresentableRelativePath() {
        XCTAssertEqual(checkPathRepresentable("spam", "spam"), "spam")
        XCTAssertNil(checkPathRepresentable("spam", "alot"))
        XCTAssertEqual(checkPathRepresentable("and/jam", "and/spam"), "and")
        XCTAssertNil(checkPathRepresentable("and/jam", "and/spam", "alot"))
        XCTAssertEqual(checkPathRepresentable("and/jam", "and/spam", "and"), "and")
    }

    func testPathRepresentableRelativePathWithExtraSeparators() {
        XCTAssertEqual(checkPathRepresentable("and//jam", "and/spam//"), "and")
    }

    func testPathRepresentableMixingAbsoluteAndRelativePaths() {
        XCTAssertNil(checkPathRepresentable("/bin", "bin"))
    }
}
