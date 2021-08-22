import XCTest
import Pathos

final class PathJoiningTests: XCTestCase {
    private let p = Path(".")
    func testJoiningWithLiterals() {
        _ = self.p + "b" + "c" // overload resolution supports this common use case
    }
}
