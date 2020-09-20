import Pathos
import XCTest

final class WriteTests: XCTestCase {
    func testWritingUnsignedBytes() throws {
        try Path.withTemporaryDirectory { _ in
            let path = Path("a")
            let data: [UInt8] = [65]
            try path.write(bytes: data, byteCount: 1, createIfNecessary: true)
            XCTAssert(path.exists())
        }
    }

    func testWritingSignedBytes() throws {
        try Path.withTemporaryDirectory { _ in
            let path = Path("a")
            let data: [Int8] = [65]
            try path.write(bytes: data, byteCount: 1, createIfNecessary: true)
            XCTAssert(path.exists())
        }
    }

    func testWritingString() throws {
        try Path.withTemporaryDirectory { _ in
            let path = Path("a.txt")
            try path.write("a", createIfNecessary: true)
            XCTAssert(path.exists())
        }
    }

    func testWritingStringWithEncoding() throws {
        try Path.withTemporaryDirectory { _ in
            let path = Path("a.txt")
            try path.write("a", encoding: UTF16.self, createIfNecessary: true)
            XCTAssert(path.exists())
        }
    }
}
