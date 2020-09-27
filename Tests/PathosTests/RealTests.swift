import Pathos
import XCTest

final class RealTests: XCTestCase {
    func testResolvingSimpleSymlink() throws {
        try Path.withTemporaryDirectory { _ in
            let origin = Path("a")
            try origin.write("")
            let link = Path("b")
            try origin.makeSymlink(at: link)
            let real = try link.real()
            XCTAssert(real.isAbsolute)
            XCTAssertEqual(real.name, "a")
        }
    }

    func testResolving2LevelSymlink() throws {
        try Path.withTemporaryDirectory { _ in
            let origin = Path("a")
            try origin.write("")
            let link1 = Path("b")
            let link2 = Path("c")
            try origin.makeSymlink(at: link1)
            try link1.makeSymlink(at: link2)
            let real = try link2.real()
            XCTAssert(real.isAbsolute)
            XCTAssertEqual(real.name, "a")
        }
    }

    func testLinkAsPathSegment() throws {
        try Path.withTemporaryDirectory { _ in
            let dir = Path("dir")
            try dir.makeDirectory()
            try (dir + "a").write("")
            let dirLink = Path("dirlink")
            try dir.makeSymlink(at: dirLink)
            let file = dirLink + "a"
            let real = try file.real()
            XCTAssert(real.isAbsolute)
            XCTAssertEqual(real.segments.suffix(2), ["dir", "a"])

            try dirLink.delete()
        }
    }
}
