import XCTest
@testable import PathosTests

extension NormalizePathTests {
    static let __allTests__NomalizePathTests = [
        ("testAssertEmptyPathBecomesCurrent", testAssertEmptyPathBecomesCurrent),
        ("testSlashPrefixes", testSlashPrefixes),
        ("testCanonicalizePath", testCanonicalizePath),
        ("testPathRepresentableEmptyPathBecomesCurrent", testPathRepresentableEmptyPathBecomesCurrent),
        ("testPathRepresentableSlashPrefixes", testPathRepresentableSlashPrefixes),
        ("testPathRepresentableCanonicalizePath", testPathRepresentableCanonicalizePath),
    ]
}

XCTMain([
    testCase(NormalizePathTests.__allTests__NomalizePathTests)
])
