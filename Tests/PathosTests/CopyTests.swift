import Pathos
import XCTest

final class CopyTests: XCTestCase {
    func testCopyingNormalFileToNewLocation() throws {
        try Path.withTemporaryDirectory { _ in
            let content = "xyyyzz"
            let sourceFile = Path("a")
            try sourceFile.write(content)
            let destinationFile = Path("b")
            try sourceFile.copy(to: destinationFile)
            XCTAssertEqual(try destinationFile.readUTF8String(), content)
        }
    }

    func testCopyingNormalFileToNewLocationFollowingSymlink() throws {
        try Path.withTemporaryDirectory { _ in
            let content = "aoesubaoesurcaoheu"
            let sourceFile = Path("a")
            try sourceFile.write(content)
            let link = Path("b")
            try sourceFile.makeSymlink(at: link)
            let destinationFile = Path("c")
            try link.copy(to: destinationFile)
            XCTAssertEqual(try destinationFile.readUTF8String(), content)
        }
    }

    func testCopyingSymlinkToNewLocation() throws {
        try Path.withTemporaryDirectory { _ in
            let content = "aoesubaoesurcaoheu"
            let sourceFile = Path("a")
            try sourceFile.write(content)
            let link = Path("b")
            try sourceFile.makeSymlink(at: link)
            let destinationFile = Path("c")
            try link.copy(to: destinationFile, followSymlink: false)
            XCTAssertEqual(try destinationFile.readSymlink(), sourceFile)
        }
    }

    func testCopyingToExistingLocationNotFailingExisting() throws {
        try Path.withTemporaryDirectory { _ in
            let sourceContent = "aaa"
            let sourceFile = Path("a")
            let destinationFile = Path("b")

            try sourceFile.write(sourceContent)
            try destinationFile.write("bbb")

            try sourceFile.copy(to: destinationFile)
            XCTAssertEqual(try destinationFile.readUTF8String(), sourceContent)
        }
    }
}
