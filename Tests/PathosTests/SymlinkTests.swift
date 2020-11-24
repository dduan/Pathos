import Pathos
import XCTest

final class SymlinkTests: XCTestCase {
    func testMakingAndReadingSymlinks() throws {
        try Path.withTemporaryDirectory { _ in
            let source = Path("a")
            try source.write(utf8: "a")
            let link = Path("b")
            try source.makeSymlink(at: link)
            XCTAssertEqual(try link.readSymlink(), source)
        }
    }
}
