import Pathos
import XCTest

final class GlobTests: XCTestCase {
    func testSimplePattern() throws {
        try Path.withTemporaryDirectory { _ in
            let path0 = Path("1.swift")
            let path1 = Path("b.swift")
            let path2 = Path("3.py")
            try path0.write("")
            try path1.write("")
            try path2.write("")

            XCTAssertEqual(
                Set(try Path("*.swift").glob()),
                [
                    path0,
                    path1,
                ]
            )
        }
    }

    func testGlobStarPatterns() throws {
        try Path.withTemporaryDirectory { _ in
            let dirs: [Path] = [
                Path(".") + "x" + "a",
                Path(".") + "x" + "b",
                Path(".") + "y" + "a",
                Path(".") + "y" + "b",
            ]

            let files: [Path] = [
                dirs[0] + "1.swift",
                dirs[0] + "2.swift",
                dirs[1] + "1.swift",
                dirs[1] + "2.py",
                dirs[2] + "1.swift",
                dirs[3] + "2.swift",
            ]

            for dir in dirs {
                try dir.makeDirectory(withParents: true)
            }

            for file in files {
                try file.write("")
            }

            XCTAssertEqual(
                Set(try (Path(".") + "x" + "**" + "*.swift").glob()),
                [
                    files[0],
                    files[1],
                    files[2],
                ]
            )
        }
    }
}
