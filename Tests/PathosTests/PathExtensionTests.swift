import Pathos
import XCTest

final class PathExtensionTests: XCTestCase {
    func testSingleExtension() {
        XCTAssertEqual(Path("System/Pathos.dll").extension, ".dll")
    }

    func testNoExtension() {
        XCTAssertNil(Path("Open.Source.Software/Pathos").extension)
    }

    func testDotFileNoExtension() {
        XCTAssertNil(Path(".vimrc").extension)
    }

    func testDotFileWithExtension() {
        XCTAssertEqual(Path(".drstring.toml").extension, ".toml")
    }

    func testExtensionsForSingleExtension() {
        XCTAssertEqual(Path("Pathos/.drstring.toml").extensions, [".toml"])
    }

    func testExtensionsForMultipleExtension() {
        XCTAssertEqual(Path("/Downloads/linux.tar.gz").extensions, [".tar", ".gz"])
    }

    func testExtensionsForNoExtension() {
        XCTAssertEqual(Path("linux").extensions, [])
    }
}
