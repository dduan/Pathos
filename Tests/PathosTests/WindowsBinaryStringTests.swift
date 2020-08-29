import Pathos
import XCTest

final class WindowsBinaryStringTests: XCTestCase {
    func testDecodingAndEncodingIsCommunitive() {
        let content = "A 🎭 二 production"
        XCTAssertEqual(WindowsBinaryString(content).description, content)
    }
}
