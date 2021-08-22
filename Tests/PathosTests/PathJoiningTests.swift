import Pathos
import XCTest

final class PathJoiningTests: XCTestCase {
    private let p = Path(".")
    func testJoiningWithLiterals() {
        _ = p + "b" + "c" // overload resolution supports this common use case
    }
}
