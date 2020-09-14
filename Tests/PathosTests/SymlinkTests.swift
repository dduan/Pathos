import Pathos
import XCTest

final class SymlinkTests: XCTestCase {
    func testCreatingSymlinks() throws {
        try Path.withTemporaryDirectory { temporary in
            let target = try Path("b.swift").absolute()
            try temporary.makeSymlink(at: target)
            XCTAssert(try target.metadata().fileType.isSymlink)
        }
    }

    func testReadingSymlinks() throws {
        try Path.withTemporaryDirectory { temporary in
            let target = Path("b.swift")
            try temporary.makeSymlink(at: target)
            try XCTAssertEqual(target.readSymlink(), temporary)
        }
    }
}
