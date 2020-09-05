import Pathos
import XCTest

final class PurePOSIXPathExtensionTests: XCTestCase {
    func testSingleExtension() {
        XCTAssertEqual(PurePOSIXPath("System/Pathos.dll").extension, ".dll")
    }

    func testNoExtension() {
        XCTAssertNil(PurePOSIXPath("Open.Source.Software/Pathos").extension)
    }

    func testDotFileNoExtension() {
        XCTAssertNil(PurePOSIXPath(".vimrc").extension)
    }

    func testDotFileWithExtension() {
        XCTAssertEqual(PurePOSIXPath(".drstring.toml").extension, ".toml")
    }

    func testExtensionsForSingleExtension() {
        XCTAssertEqual(PurePOSIXPath("Pathos/.drstring.toml").extensions, [".toml"])
    }

    func testExtensionsForMultipleExtension() {
        XCTAssertEqual(PurePOSIXPath("/Downloads/linux.tar.gz").extensions, [".tar", ".gz"])
    }

    func testExtensionsForNoExtension() {
        XCTAssertEqual(PurePOSIXPath("linux").extensions, [])
    }
}
