import Pathos
import XCTest

enum FixturePath: String {
    case fileThatExists = "hello"
    case noneExistence = "hello_not"
    case directoryThatExists = "world"
    case goodFileSymbol = "hello_symbol"
    case goodDirectorySymbol = "world_symbol"
    case badSymbol = "broken_symbol"
    case fileInDirectory = "world/world_hello"
    case symbolInDirectory = "world/world_symbol"
    case directoryInDirectory = "world/world_world"
    case fileInNestedDirecory = "world/world_world/hello"
}

class FixtureTestCase: XCTestCase {
    let fixtureRoot = normalize(path: "\(#file)/../Fixtures")

    func fixture(_ path: FixturePath) -> String {
        return join(path: self.fixtureRoot, withPath: path.rawValue)
    }

    func fixturePath(_ path: FixturePath) -> Path {
        return Path(string: self.fixture(path))
    }

    func expectedSize(of fixture: FixturePath) -> Int64 {
        switch fixture {
        case .fileThatExists:
            return 6
        case .goodFileSymbol:
            return 6
        case .directoryThatExists:
            return 160
        case .goodDirectorySymbol:
            return 160
        default:
            return -1
        }
    }
}
