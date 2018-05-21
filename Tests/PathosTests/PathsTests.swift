import XCTest
@testable import Paths

final class PathsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Paths().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
