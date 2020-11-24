import Pathos
import XCTest

final class ChildrenTests: XCTestCase {
    func testListingChildrenNonRecursively() throws {
        try Path.withTemporaryDirectory { container in
            try Path("a").write(utf8: "")
            try Path("b").makeDirectory()
            try (Path("b") + "c").write(utf8: "")
            try Path("a").makeSymlink(at: Path("d"))
            var children = try container.children()
                .map { ($0.name ?? "", $1.isDirectory, $1.isSymlink, $1.isFile) }
            children.sort { $0.0 < $1.0 }
            XCTAssertEqual(children.count, 3)

            // a is a normal file
            XCTAssertEqual("a", children[0].0)
            XCTAssert(children[0].3)

            // b is a directory
            XCTAssertEqual("b", children[1].0)
            XCTAssert(children[1].1)

            // d is a symlink
            XCTAssertEqual("d", children[2].0)
            XCTAssert(children[2].2)
        }
    }

    func testListingChildrenRecursively() throws {
        try Path.withTemporaryDirectory { _ in
            try Path("a").write(utf8: "")
            try Path("b").makeDirectory()
            try (Path("b") + "c").write(utf8: "")
            try Path("a").makeSymlink(at: Path("d"))
            var children = try Path(".").children(recursive: true)
                .map { ($0.name ?? "", $1.isDirectory, $1.isSymlink, $1.isFile) }
            children.sort { $0.0 < $1.0 }
            XCTAssertEqual(children.count, 4)

            // a is a normal file
            XCTAssertEqual("a", children[0].0)
            XCTAssert(children[0].3)

            // b is a directory
            XCTAssertEqual("b", children[1].0)
            XCTAssert(children[1].1)

            // c is a file
            XCTAssertEqual("c", children[2].0)
            XCTAssert(children[2].3)

            // d is a symlink
            XCTAssertEqual("d", children[3].0)
            XCTAssert(children[3].2)
        }
    }

    func testListingChildrenRecursivelyFollowingSymlink() throws {
        try Path.withTemporaryDirectory { _ in
            try Path("a").write(utf8: "")
            try Path("b").makeDirectory()
            try (Path("b") + "e").makeDirectory()
            try (Path("b") + "e" + "f").write(utf8: "")
            try (Path("b") + "c").write(utf8: "")
            try Path("b").makeSymlink(at: Path("d"))
            let children = try Path(".").children(recursive: true, followSymlink: true)
            let names = Set(children.map(\.0))

            XCTAssertEqual(
                names,
                [
                    Path(".") + "a",
                    Path(".") + "b",
                    Path(".") + "b" + "c",
                    Path(".") + "b" + "e",
                    Path(".") + "b" + "e" + "f",
                    Path(".") + "d",
                    Path(".") + "d" + "c",
                    Path(".") + "d" + "e",
                    Path(".") + "d" + "e" + "f",
                ]
            )
        }
    }
}
