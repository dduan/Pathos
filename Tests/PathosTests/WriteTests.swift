import Pathos
import XCTest

final class WriteTests: XCTestCase {
    func testWritingUnsignedBytes() throws {
        try Path.withTemporaryDirectory { _ in
            let path = Path("a")
            let data: [UInt8] = [65]
            try path.write(bytes: data, createIfNecessary: true)
            XCTAssert(path.exists())
            XCTAssertEqual(try path.readBytes(), [65])
        }
    }

    func testWritingSignedBytes() throws {
        try Path.withTemporaryDirectory { _ in
            let path = Path("a")
            let data: [Int8] = [65]
            try path.write(bytes: data, createIfNecessary: true)
            XCTAssert(path.exists())
            XCTAssertEqual(try path.readBytes(), [65])
        }
    }

    func testWritingString() throws {
        try Path.withTemporaryDirectory { _ in
            let path = Path("a.txt")
            try path.write("axx", createIfNecessary: true)
            XCTAssert(path.exists())
            XCTAssertEqual(try path.readBytes(), [97, 120, 120])
        }
    }

    func testWritingStringWithEncoding() throws {
        try Path.withTemporaryDirectory { _ in
            let path = Path("a.txt")
            try path.write("a", encoding: UTF16.self, createIfNecessary: true)
            XCTAssert(path.exists())
            XCTAssertEqual(try path.readBytes(), [97, 0])
        }
    }
}
