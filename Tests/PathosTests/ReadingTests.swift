import Pathos
import XCTest

final class ReadingTests: XCTestCase {
    func testReadString() {
        XCTAssertEqual(try readString(atPath: self.fixture(.fileThatExists)), "hello\n")
    }

    func testReadBytes() {
        XCTAssertEqual(try readBytes(atPath: self.fixture(.fileThatExists)), [UInt8]("hello\n".utf8))
    }

    func testReadStringFromDirectory() {
        XCTAssertEqual(try readString(atPath: self.fixture(.directoryThatExists)), "")
    }

    func testReadStringFromNoWhere() {
        XCTAssertThrowsError(try readString(atPath: self.fixture(.noneExistence)))
    }

    func testReadSymbolicLink() {
        XCTAssertEqual(try Pathos.readSymbolicLink(atPath: self.fixture(.goodFileSymbol)), "hello")
    }

    func testPathRepresentableReadString() {
        XCTAssertEqual(self.fixturePath(.fileThatExists).readString(), "hello\n")
    }

    func testPathRepresentableReadBytes() {
        XCTAssertEqual(self.fixturePath(.fileThatExists).readBytes(), [UInt8]("hello\n".utf8))
    }

    func testPathRepresentableReadStringFromDirectory() {
        XCTAssertEqual(self.fixturePath(.directoryThatExists).readString(), "")
    }

    func testPathRepresentableReadStringFromNoWhere() {
        XCTAssertEqual(self.fixturePath(.noneExistence).readString(), "")
    }

    func testPathRepresentableReadSymbolicLink() {
        XCTAssertEqual(self.fixturePath(.goodFileSymbol).readSymbolicLink(), "hello")
    }
}
