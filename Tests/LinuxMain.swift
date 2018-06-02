// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import PathosTests

extension JoinPathTests {
    static var allTests = [
        ("testSimpleSingleJoining", testSimpleSingleJoining),
        ("testMultipleJoining", testMultipleJoining),
        ("testMultipleJoiningWithTrailingSeparators", testMultipleJoiningWithTrailingSeparators),
        ("testJoiningWithAbsolutePath", testJoiningWithAbsolutePath),
        ("testPathRepresentableSimpleSingleJoining", testPathRepresentableSimpleSingleJoining),
        ("testPathRepresentableMultipleJoining", testPathRepresentableMultipleJoining),
        ("testPathRepresentableMultipleJoiningWithTrailingSeparators", testPathRepresentableMultipleJoiningWithTrailingSeparators),
        ("testPathRepresentableJoiningWithAbsolutePath", testPathRepresentableJoiningWithAbsolutePath),
    ]
}
extension NormalizePathTests {
    static var allTests = [
        ("testAssertEmptyPathBecomesCurrent", testAssertEmptyPathBecomesCurrent),
        ("testSlashPrefixes", testSlashPrefixes),
        ("testConanicalizePath", testConanicalizePath),
        ("testPathRepresentableEmptyPathBecomesCurrent", testPathRepresentableEmptyPathBecomesCurrent),
        ("testPathRepresentableSlashPrefixes", testPathRepresentableSlashPrefixes),
        ("testPathRepresentableConanicalizePath", testPathRepresentableConanicalizePath),
    ]
}

XCTMain([
    testCase(JoinPathTests.allTests),
    testCase(NormalizePathTests.allTests),
])
