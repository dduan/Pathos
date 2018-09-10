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

extension XCTestCase {
    var fixtureRoot: String {
        return normalize(path: "\(#file)/../Fixtures")
    }

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
#if os(Linux)
            return 4096
#else
            return 160
#endif
        case .goodDirectorySymbol:
#if os(Linux)
            return 4096
#else
            return 160
#endif
        default:
            return -1
        }
    }

    var childFiles: Set<String> {
        return [self.fixture(.fileThatExists)]
    }

    var childDirectories: Set<String> {
        return [self.fixture(.directoryThatExists)]
    }

    var childSymbolicLinks: Set<String> {
        return [
            self.fixture(.goodFileSymbol),
            self.fixture(.goodDirectorySymbol),
            self.fixture(.badSymbol),
        ]
    }

    var childFilesRecursive: Set<String> {
        return [
            self.fixture(.fileThatExists),
            self.fixture(.fileInDirectory),
            self.fixture(.fileInNestedDirecory),
        ]
    }

    var childDirectoriesRecursive: Set<String> {
        return [
            self.fixture(.directoryThatExists),
            self.fixture(.directoryInDirectory),
        ]
    }

    var childSymbolicLinksRecursive: Set<String> {
        return [
            self.fixture(.goodFileSymbol),
            self.fixture(.goodDirectorySymbol),
            self.fixture(.badSymbol),
            self.fixture(.symbolInDirectory),
        ]
    }
}
