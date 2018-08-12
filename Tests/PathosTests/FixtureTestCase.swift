import Pathos
import XCTest

enum FixturePath: String {
    case fileThatExists = "hello"
    case noneExistence = "hello_not"
    case directoryThatExists = "world"
    case goodFileSymbol = "hello_symbol"
    case goodDirectorySymbol = "world_symbol"
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
