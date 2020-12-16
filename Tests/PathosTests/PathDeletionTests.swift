import Pathos
import XCTest

final class PathDeletionTests: XCTestCase {
    func testNonExistingPathDoesNotThrow() throws {
        try Path.withTemporaryDirectory { _ in
            try Path("X").delete()
        }
    }

    func testDeletingNormalFile() throws {
        try Path.withTemporaryDirectory { _ in
            let p = Path("X")
            try p.write(utf8: "x")
            try p.delete()
            XCTAssertFalse(p.exists())
        }
    }

    func testDeletingNormalFileNonRecursive() throws {
        try Path.withTemporaryDirectory { _ in
            let p = Path("X")
            try p.write(utf8: "x")
            try p.delete(recursive: false)
            XCTAssertFalse(p.exists())
        }
    }

    func testDeletingEmptyDirectory() throws {
        try Path.withTemporaryDirectory { _ in
            let p = Path("X")
            try p.makeDirectory()
            try p.delete()
            XCTAssertFalse(p.exists())
        }
    }

    func testDeletingEmptyDirectoryNonRecursive() throws {
        try Path.withTemporaryDirectory { _ in
            let p = Path("X")
            try p.makeDirectory()
            try p.delete(recursive: false)
            XCTAssertFalse(p.exists())
        }
    }

    func testDeletingSymlink() throws {
        try Path.withTemporaryDirectory { _ in
            let a = Path("a")
            try a.write(utf8: "")
            let b = Path("b")
            try a.makeSymlink(at: b)
            try b.delete()
            XCTAssertFalse(b.exists())
        }
    }

    func testDeletingNonEmptyDirectory() throws {
        try Path.withTemporaryDirectory { _ in
            let p = Path("p")
            try p.makeDirectory()
            let a = p + "a"
            try a.write(utf8: "")
            try p.delete()
            XCTAssertFalse(p.exists())
        }
    }

    func testDeletingNonEmptyDirectoryNonRecursive() throws {
        try Path.withTemporaryDirectory { _ in
            let p = Path("p")
            try p.makeDirectory()
            let a = p + "a"
            try a.write(utf8: "")
            XCTAssertThrowsError(try p.delete(recursive: false))
        }
    }
}
