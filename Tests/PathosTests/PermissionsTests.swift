import Pathos
import XCTest

final class PermissionsTests: XCTestCase {
    func testMutatingReadOnly() {
        #if os(Windows)
        var p: Permissions = WindowsAttributes()
        #else
        var p: Permissions = POSIXPermissions()
        #endif
        let first = p.isReadOnly
        p.isReadOnly.toggle()
        XCTAssertNotEqual(first, p.isReadOnly)
        p.isReadOnly.toggle()
        XCTAssertEqual(first, p.isReadOnly)
    }
}
