import Pathos
import XCTest

#if !os(Windows)
private let kTMPDIR = "TMPDIR"
private let kTEMP = "TEMP"
private let kTMP = "TMP"

private func generateTmp() -> String {
    /// yup, these tests assumes `/tmp` exists and is read/writeable.
    return join(paths: "/tmp", String(UInt.random(in: .min ... .max)))
}

final class DefaultTemporaryDirectorySearchingTests: XCTestCase {
    private var cachedTMPDIR: UnsafeMutablePointer<Int8>!
    private var cachedTEMP: UnsafeMutablePointer<Int8>!
    private var cachedTMP: UnsafeMutablePointer<Int8>!
    private var tmp = generateTmp()

    override func setUp() {
        self.cachedTMPDIR = getenv(kTMPDIR)
        self.cachedTEMP = getenv(kTEMP)
        self.cachedTMP = getenv(kTMP)

        mkdir(self.tmp, FilePermission.ownerAll.rawValue)
    }

    override func tearDown() {
        if let cachedTMP = self.cachedTMP {
            setenv(kTMP, cachedTMP, 1)
        } else {
            unsetenv(kTMP)
        }

        if let cachedTEMP = self.cachedTEMP {
            setenv(kTEMP, cachedTEMP, 1)
        } else {
            unsetenv(kTEMP)
        }

        if let cachedTMPDIR = self.cachedTMPDIR {
            setenv(kTMPDIR, cachedTMPDIR, 1)
        } else {
            unsetenv(kTMPDIR)
        }

        rmdir(self.tmp)
        self.tmp = generateTmp()
    }

    func testSearchingTemporaryDirectoryFromTMPDIR() {
        setenv(kTMPDIR, self.tmp, 1)
        let searchResult = searchForDefaultTemporaryDirectory()
        XCTAssertEqual(self.tmp, searchResult)
    }

    func testSearchingTemporaryDirectoryFromTEMP() {
        unsetenv(kTMPDIR)
        setenv(kTEMP, self.tmp, 1)
        let searchResult = searchForDefaultTemporaryDirectory()
        XCTAssertEqual(self.tmp, searchResult)
    }

    func testSearchingTemporaryDirectoryFromTMP() {
        unsetenv(kTMPDIR)
        unsetenv(kTEMP)
        setenv(kTMP, self.tmp, 1)
        let searchResult = searchForDefaultTemporaryDirectory()
        XCTAssertEqual(self.tmp, searchResult)
    }

    func testPathRepresentableSearchingTemporaryDirectoryFromTMPDIR() {
        setenv(kTMPDIR, self.tmp, 1)
        let searchResult = Path.searchForDefaultTemporaryDirectory()
        XCTAssertEqual(self.tmp, searchResult)
    }

    func testPathRepresentableSearchingTemporaryDirectoryFromTEMP() {
        unsetenv(kTMPDIR)
        setenv(kTEMP, self.tmp, 1)
        let searchResult = Path.searchForDefaultTemporaryDirectory()
        XCTAssertEqual(self.tmp, searchResult)
    }

    func testPathRepresentableSearchingTemporaryDirectoryFromTMP() {
        unsetenv(kTMPDIR)
        unsetenv(kTEMP)
        setenv(kTMP, self.tmp, 1)
        let searchResult = Path.searchForDefaultTemporaryDirectory()
        XCTAssertEqual(self.tmp, searchResult)
    }
}
#endif
