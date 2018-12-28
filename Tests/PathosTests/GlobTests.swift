import Pathos
import XCTest

final class GlobTests: XCTestCase {
    var originalWorkingDirectory: String = (try? getCurrentWorkingDirectory()) ?? "."
    override func setUp() {
        _ = try? setCurrentWorkingDirectory(to: self.fixtureRoot)
    }

    override func tearDown() {
        _ = try? setCurrentWorkingDirectory(to: self.originalWorkingDirectory)
    }

    func testGlobWithResult() throws {
        XCTAssertEqual(
            Set(try Pathos.glob("*_symbol")),
            Set([
                FixturePath.badSymbol.rawValue,
                FixturePath.goodFileSymbol.rawValue,
                FixturePath.goodDirectorySymbol.rawValue,
            ])
        )
    }

    func testGlobWithoutResult() {
        // `./hello` should not be found by this pattern
        XCTAssertEqual(
            Set(try Pathos.glob("*/hello")),
            Set(),
            "Non recursive glob pattern shouldn't return result due to `*/`"
        )
    }

    func testGlobWithRecursivePattern() {
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

    func testPathRepresentableGlobWithResult() throws {
        XCTAssertEqual(
            Set(Path.glob("*_symbol").map { $0.pathString }),
            Set([
                FixturePath.badSymbol.rawValue,
                FixturePath.goodFileSymbol.rawValue,
                FixturePath.goodDirectorySymbol.rawValue,
            ])
        )
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
