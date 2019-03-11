#if os(Linux)
import Glibc
#else
import Darwin
#endif
import Pathos
import XCTest

final class ExpandUserDirectoryTests: XCTestCase {
    private var originalHome: UnsafeMutablePointer<Int8>? = nil

    override func setUp() {
        self.originalHome = getenv("HOME")
    }

    override func tearDown() {
        if let home = self.originalHome {
            setenv("HOME", home, 1)
        }
    }

    func testExpandPathWithNoUser() {
        XCTAssertEqual(try expandUserDirectory(inPath: "foo"), "foo")
    }

    func testUserDirectoryExpandsToHomeEnvironment() {
        setenv("HOME", "/I/do/not/exist", 1)
        XCTAssertEqual(try expandUserDirectory(inPath: "~"), "/I/do/not/exist")
        XCTAssertEqual(try expandUserDirectory(inPath: "~/foo"), "/I/do/not/exist/foo")
    }

    func testSpecialHomeValue() {
        setenv("HOME", "/", 1)
        XCTAssertEqual(try expandUserDirectory(inPath: "~"), "/")
        XCTAssertEqual(try expandUserDirectory(inPath: "~/"), "/")
        XCTAssertEqual(try expandUserDirectory(inPath: "~/foo"), "/foo")

        setenv("HOME", "", 1)
        XCTAssertEqual(try expandUserDirectory(inPath: "~"), "/")
        XCTAssertEqual(try expandUserDirectory(inPath: "~/"), "/")
        XCTAssertEqual(try expandUserDirectory(inPath: "~/foo"), "/foo")

        setenv("HOME", "//", 1)
        XCTAssertEqual(try expandUserDirectory(inPath: "~"), "/")
        XCTAssertEqual(try expandUserDirectory(inPath: "~/"), "/")
        XCTAssertEqual(try expandUserDirectory(inPath: "~/foo"), "/foo")

        setenv("HOME", "///", 1)
        XCTAssertEqual(try expandUserDirectory(inPath: "~"), "/")
        XCTAssertEqual(try expandUserDirectory(inPath: "~/"), "/")
        XCTAssertEqual(try expandUserDirectory(inPath: "~/foo"), "/foo")
    }

    func testFallbackToPasswdDatabase() {
        let userPasswd = getpwuid(getuid())
        guard let homePointer = userPasswd?.pointee.pw_dir,
            case let home = String(cString: homePointer) else
        {
            XCTFail("cannot run test on platform where passwd db is not available")
            return
        }
        unsetenv("HOME")
        XCTAssertEqual(try expandUserDirectory(inPath: "~"), home)
    }

    func testPathRepresentableExpandPathWithNoUser() {
        XCTAssertEqual(Path("foo").expandUserDirectory().pathString, "foo")
    }

    func testPathRepresentableUserDirectoryExpandsToHomeEnvironment() {
        setenv("HOME", "/I/do/not/exist", 1)
        XCTAssertEqual(Path("~").expandUserDirectory().pathString, "/I/do/not/exist")
        XCTAssertEqual(Path("~/foo").expandUserDirectory().pathString, "/I/do/not/exist/foo")
    }

    func testPathRepresentableSpecialHomeValue() {
        setenv("HOME", "/", 1)
        XCTAssertEqual(Path("~").expandUserDirectory().pathString, "/")
        XCTAssertEqual(Path("~/").expandUserDirectory().pathString, "/")
        XCTAssertEqual(Path("~/foo").expandUserDirectory().pathString, "/foo")

        setenv("HOME", "", 1)
        XCTAssertEqual(Path("~").expandUserDirectory().pathString, "/")
        XCTAssertEqual(Path("~/").expandUserDirectory().pathString, "/")
        XCTAssertEqual(Path("~/foo").expandUserDirectory().pathString, "/foo")

        setenv("HOME", "//", 1)
        XCTAssertEqual(Path("~").expandUserDirectory().pathString, "/")
        XCTAssertEqual(Path("~/").expandUserDirectory().pathString, "/")
        XCTAssertEqual(Path("~/foo").expandUserDirectory().pathString, "/foo")

        setenv("HOME", "///", 1)
        XCTAssertEqual(Path("~").expandUserDirectory().pathString, "/")
        XCTAssertEqual(Path("~/").expandUserDirectory().pathString, "/")
        XCTAssertEqual(Path("~/foo").expandUserDirectory().pathString, "/foo")
    }

    func testPathRepresentableFallbackToPasswdDatabase() {
        let userPasswd = getpwuid(getuid())
        guard let homePointer = userPasswd?.pointee.pw_dir,
            case let home = String(cString: homePointer) else
        {
            XCTFail("cannot run test on platform where passwd db is not available")
            return
        }
        unsetenv("HOME")
        XCTAssertEqual(Path("~").expandUserDirectory().pathString, home)
    }
}
