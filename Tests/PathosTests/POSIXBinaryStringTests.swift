@testable import Pathos
import XCTest

final class POSIXBinaryStringTests: XCTestCase {
    func testDecodingAndEncodingIsCommunitive() {
        let content = "A 🎭 二 production"
        XCTAssertEqual(POSIXBinaryString(content).description, content)
    }
}
