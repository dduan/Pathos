import Pathos
import XCTest

final class SymlinkTests: XCTestCase {
    func testCreatingSymlinks() throws {
        try Path.withTemporaryDirectory { _ in
            let target = Path("b.swift")
            try Path("a.swift").makeSymlink(at: target)
            XCTAssert(try target.metadata().fileType.isSymlink)
        }
    }

    func testReadingSymlinks() throws {
        try Path.withTemporaryDirectory { _ in
            let source = Path("a.swift")
            let target = Path("b.swift")
            try source.makeSymlink(at: target)
            try XCTAssertEqual(target.readSymlink(), source)
        }
    }
}
