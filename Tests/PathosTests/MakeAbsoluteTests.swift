import Pathos
import XCTest

final class MakeAbsoluteTests: XCTestCase {
    func testMakeAbsolutePath() {
        do {
            let result = try absolutePath(ofPath: "foo")
            XCTAssertTrue(result.hasPrefix("/"))
            XCTAssertTrue(result.hasSuffix("foo"))
        } catch let error {
            XCTFail("system error occurred while testing \(#file):\(#line) \(error)")
        }
    }

    func testPathRepresentableMakeAbsolutePath() {
        let result = Path(string: "foo").absolutePath()
        XCTAssertTrue(result.pathString.hasPrefix("/"))
        XCTAssertTrue(result.pathString.hasSuffix("foo"))
    }
}
