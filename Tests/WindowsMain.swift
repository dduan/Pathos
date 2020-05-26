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

extension IsAbsoluteTests {
    static let __allTests__IsAbsoluteTests = [
        ("testIsAbsolutePath", testIsAbsolutePath),
        ("testPathRepresentableIsAbsolute", testPathRepresentableIsAbsolute),
    ]
}

extension SplitDriveTests {
    static let __allTests__SplitDriveTests = [
        ("testSimpleDriveSplit", testSimpleDriveSplit),
        ("testSimpleDriveNoPathSplit", testSimpleDriveNoPathSplit),
        ("testSimpleNoDrivePathSplit", testSimpleNoDrivePathSplit),
        ("testSimpleNoDrivePathSplit", testSimpleNoDrivePathSplit),
        ("testSplitingUNCHost", testSplitingUNCHost),
        ("testPathRepresentableSimpleDriveSplit", testPathRepresentableSimpleDriveSplit),
        ("testPathRepresentableSimpleDriveNoPathSplit", testPathRepresentableSimpleDriveNoPathSplit),
        ("testPathRepresentableSimpleNoDrivePathSplit", testPathRepresentableSimpleNoDrivePathSplit),
        ("testPathRepresentableSplitingUNCHost", testPathRepresentableSplitingUNCHost),
    ]
}

XCTMain([
    testCase(NormalizePathTests.__allTests__NomalizePathTests),
    // testCase(IsAbsoluteTests.__allTests__IsAbsoluteTests),
    testCase(SplitDriveTests.__allTests__SplitDriveTests),
])
