import Pathos
import XCTest

class FixtureTestCase: XCTestCase {
    let fixtureRoot = normalize(path: "\(#file)/../Fixtures")
    lazy var fixtureRootPath: Path = { return Path(string: self.fixtureRoot) }()

    func fixture(_ pathString: String) -> String {
        return join(path: self.fixtureRoot, withPath: pathString)
    }

    func fixture(_ path: Path) -> Path {
        return self.fixtureRootPath.join(with: path)
    }
}
