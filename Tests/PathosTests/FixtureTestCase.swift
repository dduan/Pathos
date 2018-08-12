import Pathos
import XCTest

enum FixturePath: String {
    case pathThatExists = "hello"
    case pathThatExistsNot = "hello_not"
    case goodSymbol = "hello_symbol"
    case badSymbol = "broken_symbol"
}

class FixtureTestCase: XCTestCase {
    let fixtureRoot = normalize(path: "\(#file)/../Fixtures")

    func fixture(_ path: FixturePath) -> String {
        return join(path: self.fixtureRoot, withPath: path.rawValue)
    }

    func fixturePath(_ path: FixturePath) -> Path {
        return Path(string: self.fixture(path))
    }
}
