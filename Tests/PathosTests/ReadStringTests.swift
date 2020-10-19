import Pathos
import XCTest

final class ReadStringTests: XCTestCase {
    func testReadingWithEncoding() throws {
        try Path.withTemporaryDirectory { _ in
            let filePath = Path("a")
            try filePath.write(bytes: [UInt8(97), 97])
            XCTAssertEqual("慡", try filePath.readString(as: UTF16.self))
            XCTAssertEqual("aa", try filePath.readString(as: UTF8.self))
        }
    }

    func testReadingWithoutEncoding() throws {
        try Path.withTemporaryDirectory { _ in
            let filePath = Path("a")
            try filePath.write(bytes: [UInt8(97), 97])
            try XCTAssertEqual(filePath.readString(as: UTF8.self), filePath.readUTF8String())
        }
    }
}
