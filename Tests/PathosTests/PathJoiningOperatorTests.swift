import Pathos
import XCTest

final class PathJoiningOperatorTests: XCTestCase {
    func testAddingPaths() {
        let result = Path("a") + Path("b")
        XCTAssertEqual(result, Path("a").joined(with: "b"))
    }

    func testAddingPathAndPurePath() {
        let result = Path("a") + PurePath("b")
        XCTAssertEqual(result, Path("a").joined(with: "b"))
    }

    func testAddingPurePathAndPath() {
        let result = PurePath("a") + Path("b")
        XCTAssertEqual(result, Path("a").joined(with: "b"))
    }

    func testAddingPathAndString() {
        let result = Path("a") + "b"
        XCTAssertEqual(result, Path("a").joined(with: "b"))
    }

    func testAddingStringAndPath() {
        let result = "a" + Path("b")
        XCTAssertEqual(result, Path("a").joined(with: "b"))
    }

    func testAddingPathAndBinaryString() {
        let result = Path("a") + BinaryString("b")
        XCTAssertEqual(result, Path("a").joined(with: "b"))
    }

    func testAddingBinaryStringAndPath() {
        let result = BinaryString("a") + Path("b")
        XCTAssertEqual(result, Path("a").joined(with: "b"))
    }
}
