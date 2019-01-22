import Pathos
import XCTest

final class GlobTests: XCTestCase {
    var originalWorkingDirectory: String = (try? getCurrentWorkingDirectory()) ?? "."
    override func setUp() {
        _ = try? setCurrentWorkingDirectory(toPath: self.fixtureRoot)
    }

    override func tearDown() {
        _ = try? setCurrentWorkingDirectory(toPath: self.originalWorkingDirectory)
    }

    func testGlobWithResult() throws {
        // Eww, libc platform differences
#if os(Linux)
        XCTAssertEqual(
            Set(try Pathos.glob("*_symbol")),
            Set([
                FixturePath.goodFileSymbol.rawValue,
                FixturePath.goodDirectorySymbol.rawValue,
            ])
        )
#else
        XCTAssertEqual(
            Set(try Pathos.glob("*_symbol")),
            Set([
                FixturePath.badSymbol.rawValue,
                FixturePath.goodFileSymbol.rawValue,
                FixturePath.goodDirectorySymbol.rawValue,
            ])
        )
#endif

    }

    func testGlobWithoutResult() throws {
        // `./hello` should not be found by this pattern
        XCTAssertEqual(
            Set(try Pathos.glob("*/hello")),
            Set(),
            "Non recursive glob pattern shouldn't return result due to `*/`"
        )
    }

    func testGlobWithRecursivePattern() throws {
        XCTAssertEqual(
            Set(try Pathos.glob("*/**/hello")),
            Set([
                FixturePath.fileInNestedDirectory.rawValue,
                FixturePath.fileInNestedDirectoryViaDirectorySymbol.rawValue,
            ])
        )

        XCTAssertEqual(
            Set(try Pathos.glob("world/**/hello")),
            Set([
                FixturePath.fileInNestedDirectory.rawValue,
            ])
        )
    }

    func testPathRepresentableGlobWithResult() {
        // Eww, libc platform differences
#if os(Linux)
        XCTAssertEqual(
            Set(Path.glob("*_symbol").map { $0.pathString }),
            Set([
                FixturePath.goodFileSymbol.rawValue,
                FixturePath.goodDirectorySymbol.rawValue,
            ])
        )
#else
        XCTAssertEqual(
            Set(Path.glob("*_symbol").map { $0.pathString }),
            Set([
                FixturePath.badSymbol.rawValue,
                FixturePath.goodFileSymbol.rawValue,
                FixturePath.goodDirectorySymbol.rawValue,
            ])
        )
#endif
    }

    func testPathRepresentableGlobWithoutResult() {
        // `./hello` should not be found by this pattern
        XCTAssertEqual(
            Set(Path.glob("*/hello").map { $0.pathString }),
            Set(),
            "Non recursive glob pattern shouldn't return result due to `*/`"
        )
    }

    func testPathRepresentableGlobWithRecursivePattern() {
        XCTAssertEqual(
            Set(Path.glob("*/**/hello").map { $0.pathString }),
            Set([
                FixturePath.fileInNestedDirectory.rawValue,
                FixturePath.fileInNestedDirectoryViaDirectorySymbol.rawValue,
                ])
        )

        XCTAssertEqual(
            Set(Path.glob("world/**/hello").map { $0.pathString }),
            Set([
                FixturePath.fileInNestedDirectory.rawValue,
            ])
        )
    }
}
