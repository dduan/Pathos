import Pathos
import XCTest

final class PureWindowsPathRelativeTests: XCTestCase {
    func testBasicRelativity() {
        XCTAssertEqual(
            PureWindowsPath(#"\"#).relative(to: #"\home\dan"#),
            PureWindowsPath(#"..\.."#)
        )
    }

    func testRelativeToSelf() {
        XCTAssertEqual(
            PureWindowsPath(#"a"#).relative(to: #"a"#),
            PureWindowsPath(#"."#)
        )
    }

    func testAbsoluteSibling() {
        XCTAssertEqual(
            PureWindowsPath(#"C:\a\b"#).relative(to: #"C:\x\y"#),
            PureWindowsPath(#"..\..\a\b"#)
        )
    }

    func testAbsoluteChild() {
        XCTAssertEqual(
            PureWindowsPath(#"C:\a\b\c"#).relative(to: #"C:\a\b"#),
            PureWindowsPath(#"c"#)
        )

        XCTAssertEqual(
            PureWindowsPath(#"C:\a\b\c"#).relative(to: #"C:\"#),
            PureWindowsPath(#"a\b\c"#)
        )
    }

    func testAbsoluteParent() {
        XCTAssertEqual(
            PureWindowsPath(#"C:\"#).relative(to: #"C:\a\b\c"#),
            PureWindowsPath(#"..\..\.."#)
        )
    }

    func testAbsoluteRoot() {
        XCTAssertEqual(
            PureWindowsPath(#"D:\"#).relative(to: #"D:\"#),
            PureWindowsPath(#"."#)
        )
    }
}
