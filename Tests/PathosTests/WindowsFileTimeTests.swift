import Pathos
#if os(Windows)
import WinSDK
#endif
import XCTest

final class WindowsFileTimeTests: XCTestCase {
    func testCovertingFILETIME() {
        #if os(Windows)
        let epochInHundredNanos: UInt64 = 11_644_473_600 * 10_000_000
        var filetime = FILETIME()
        filetime.dwHighDateTime = DWORD(epochInHundredNanos >> 32)
        filetime.dwLowDateTime = DWORD((epochInHundredNanos << 32) >> 32)
        let result = FileTime(filetime)

        XCTAssertEqual(result.seconds, 0)
        XCTAssertEqual(result.nanoseconds, 0)
        #endif
    }
}
