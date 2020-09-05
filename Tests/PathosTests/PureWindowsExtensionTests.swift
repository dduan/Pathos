import Pathos
import XCTest

final class PureWindowsPathExtensionTests: XCTestCase {
    func testSingleExtension() {
        XCTAssertEqual(PureWindowsPath(#"System\Pathos.dll"#).extension, ".dll")
    }

    func testNoExtension() {
        XCTAssertNil(PureWindowsPath(#"Open.Source.Software\Pathos"#).extension)
    }

    func testDotFileNoExtension() {
        XCTAssertNil(PureWindowsPath(".vimrc").extension)
    }

    func testDotFileWithExtension() {
        XCTAssertEqual(PureWindowsPath(".drstring.toml").extension, ".toml")
    }

    func testExtensionsForSingleExtension() {
        XCTAssertEqual(PureWindowsPath(#"Pathos\.drstring.toml"#).extensions, [".toml"])
    }

    func testExtensionsForMultipleExtension() {
        XCTAssertEqual(PureWindowsPath(#"C:\Downloads\linux.tar.gz"#).extensions, [".tar", ".gz"])
    }

    func testExtensionsForNoExtension() {
        XCTAssertEqual(PureWindowsPath("linux").extensions, [])
    }
}
