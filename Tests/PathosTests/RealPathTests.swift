import Pathos
import XCTest

final class RealPathTests: XCTestCase {
    func testTerminalSymbolIsResolved() throws {
        XCTAssertEqual(
            try realPath(ofPath: self.fixture(.goodFileSymbol)),
            self.fixture(.fileThatExists)
        )
    }

    func testIntermediatSymbols() throws {
        XCTAssertEqual(
            try realPath(ofPath: self.fixture(.fileInNestedDirectoryViaDirectorySymbol)),
            self.fixture(.fileInNestedDirectory)
        )
    }

    func testPathThatDoesNotExist() throws {
        XCTAssertEqual(try realPath(ofPath: self.fixture(.noneExistence)), self.fixture(.noneExistence))
    }

    func testRoot() throws {
        XCTAssertEqual(try realPath(ofPath: "/"), "/")
    }

    func testEmpty() throws {
        XCTAssertEqual(try realPath(ofPath: ""), try getCurrentWorkingDirectory())
    }

    func testPathRepresentableTerminalSymbolIsResolved() {
        XCTAssertEqual(
            self.fixturePath(.goodFileSymbol).realPath.pathString,
            self.fixture(.fileThatExists)
        )
    }

    func testPathRepresentableIntermediatSymbols() {
        XCTAssertEqual(
            self.fixturePath(.fileInNestedDirectoryViaDirectorySymbol).realPath.pathString,
            self.fixture(.fileInNestedDirectory)
        )
    }

    func testPathRepresentablePathThatDoesNotExist() {
        XCTAssertEqual(self.fixturePath(.noneExistence).realPath.pathString, self.fixture(.noneExistence))
    }

    func testPathRepresentableRoot() {
        XCTAssertEqual(Path("/").realPath.pathString, "/")
    }

    func testPathRepresentableEmpty() {
        XCTAssertEqual(Path("").realPath.pathString, try getCurrentWorkingDirectory())
    }
}
