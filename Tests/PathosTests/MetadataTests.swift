import Pathos
import XCTest

final class MetadataTests: XCTestCase {
    func testRetrievingDirectoryMetadata() throws {
        try Path.withTemporaryDirectory { temp in
            let meta = try temp.metadata()
            XCTAssertTrue(meta.fileType.isDirectory)
        }
    }

    func testRetrievingFileMetadata() throws {
        try Path.withTemporaryDirectory { _ in
            let path = Path("a")
            try path.write("")
            let meta = try path.metadata()
            XCTAssertTrue(meta.fileType.isFile)
        }
    }

    func testRetrievingSymlinkMetadata() throws {
        try Path.withTemporaryDirectory { _ in
            let path = Path("a")
            try path.write("")
            let link = Path("b")
            try path.makeSymlink(at: link)
            let meta = try link.metadata()
            XCTAssertTrue(meta.fileType.isSymlink)
        }
    }
}
