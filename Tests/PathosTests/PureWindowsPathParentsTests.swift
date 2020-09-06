import Pathos
import XCTest

final class PureWindowsPathParentsTests: XCTestCase {
    func testAbsolutePathIteratingOverParents() {
        var results = [PureWindowsPath]()
        for path in PureWindowsPath(#"D:\a\b\c"#).parents {
            results.append(path)
        }

        XCTAssertEqual(
            results,
            [
                PureWindowsPath(#"D:\a\b"#),
                PureWindowsPath(#"D:\a"#),
                PureWindowsPath(#"D:\"#),
            ]
        )
    }

    func testAbsolutePathArrayParents() {
        XCTAssertEqual(
            Array(PureWindowsPath(#"D:\a\b\c"#).parents),
            [
                PureWindowsPath(#"D:\a\b"#),
                PureWindowsPath(#"D:\a"#),
                PureWindowsPath(#"D:\"#),
            ]
        )
    }

    func testPathWithDriveIteratingOverParents() {
        var results = [PureWindowsPath]()
        for path in PureWindowsPath(#"D:a\b\c"#).parents {
            results.append(path)
        }

        XCTAssertEqual(
            results,
            [
                PureWindowsPath(#"D:a\b"#),
                PureWindowsPath(#"D:a"#),
                PureWindowsPath(#"D:"#),
            ]
        )
    }

    func testPathWithDriveArrayParents() {
        XCTAssertEqual(
            Array(PureWindowsPath(#"D:a\b\c"#).parents),
            [
                PureWindowsPath(#"D:a\b"#),
                PureWindowsPath(#"D:a"#),
                PureWindowsPath(#"D:"#),
            ]
        )
    }

    func testPathWithRootIteratingOverParents() {
        var results = [PureWindowsPath]()
        for path in PureWindowsPath(#"\a\b\c"#).parents {
            results.append(path)
        }

        XCTAssertEqual(
            results,
            [
                PureWindowsPath(#"\a\b"#),
                PureWindowsPath(#"\a"#),
                PureWindowsPath(#"\"#),
            ]
        )
    }

    func testPathWithRootArrayParents() {
        XCTAssertEqual(
            Array(PureWindowsPath(#"\a\b\c"#).parents),
            [
                PureWindowsPath(#"\a\b"#),
                PureWindowsPath(#"\a"#),
                PureWindowsPath(#"\"#),
            ]
        )
    }

    func testRelativePathIteratingOverParents() {
        var results = [PureWindowsPath]()
        for path in PureWindowsPath(#"a\b\c"#).parents {
            results.append(path)
        }

        XCTAssertEqual(
            results,
            [
                PureWindowsPath(#"a\b"#),
                PureWindowsPath(#"a"#),
                PureWindowsPath(#"."#),
            ]
        )
    }

    func testRelativePathArrayParents() {
        XCTAssertEqual(
            Array(PureWindowsPath(#"a\b\c"#).parents),
            [
                PureWindowsPath(#"a\b"#),
                PureWindowsPath(#"a"#),
                PureWindowsPath(#"."#),
            ]
        )
    }
}
