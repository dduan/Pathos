import Pathos
import XCTest

class FixtureTestCase: XCTestCase {
    let fixtureRoot = normalize(path: "\(#file)/../Fixtures")

    func fixture(_ pathString: String) -> String {
        return join(path: self.fixtureRoot, withPath: pathString)
    }
}
