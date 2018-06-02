// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import PathosTests

extension IsAbsoluteTests {
    static var allTests = [
        ("testIsAbsolutePath", testIsAbsolutePath),
        ("testPathRepresentableIsAbsolute", testPathRepresentableIsAbsolute),
    ]
}
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
extension PathBaseNameTests {
    static var allTests = [
        ("testBaseNameOfPath", testBaseNameOfPath),
        ("testPathRepresentableBaseNameOfPath", testPathRepresentableBaseNameOfPath),
    ]
}
extension PathDirectoryTests {
    static var allTests = [
        ("testPathDirectory", testPathDirectory),
        ("testPathRepresentableDirectory", testPathRepresentableDirectory),
    ]
}
extension SplitExtensionTests {
    static var allTests = [
        ("testSplitExtensionOnSimplePath", testSplitExtensionOnSimplePath),
        ("testSplitExtensionOnPathWithMultipleDots", testSplitExtensionOnPathWithMultipleDots),
        ("testSplitExtensionOnPathWithLeadingDot", testSplitExtensionOnPathWithLeadingDot),
        ("testSplitExtensionOnPathWithNoDots", testSplitExtensionOnPathWithNoDots),
        ("testSplitExtensionOnPathWithLeadingDotButNoExtension", testSplitExtensionOnPathWithLeadingDotButNoExtension),
        ("testSplitExtensionOnPathWithManyLeadingDotsButNoExtension", testSplitExtensionOnPathWithManyLeadingDotsButNoExtension),
        ("testSplitExtensionOnPathWithLeadingDotsButNoExtension", testSplitExtensionOnPathWithLeadingDotsButNoExtension),
        ("testSplitExtensionOnPathWithLeadingDots", testSplitExtensionOnPathWithLeadingDots),
        ("testSplitExtensionOnPathWithOnlyDots", testSplitExtensionOnPathWithOnlyDots),
        ("testSplitExtensionOnEmptyPath", testSplitExtensionOnEmptyPath),
        ("testPathRepresentableSplitExtensionOnSimplePath", testPathRepresentableSplitExtensionOnSimplePath),
        ("testPathRepresentableSplitExtensionOnPathWithMultipleDots", testPathRepresentableSplitExtensionOnPathWithMultipleDots),
        ("testPathRepresentableSplitExtensionOnPathWithLeadingDot", testPathRepresentableSplitExtensionOnPathWithLeadingDot),
        ("testPathRepresentableSplitExtensionOnPathWithNoDots", testPathRepresentableSplitExtensionOnPathWithNoDots),
        ("testPathRepresentableSplitExtensionOnPathWithLeadingDotButNoExtension", testPathRepresentableSplitExtensionOnPathWithLeadingDotButNoExtension),
        ("testPathRepresentableSplitExtensionOnPathWithManyLeadingDotsButNoExtension", testPathRepresentableSplitExtensionOnPathWithManyLeadingDotsButNoExtension),
        ("testPathRepresentableSplitExtensionOnPathWithLeadingDotsButNoExtension", testPathRepresentableSplitExtensionOnPathWithLeadingDotsButNoExtension),
        ("testPathRepresentableSplitExtensionOnPathWithLeadingDots", testPathRepresentableSplitExtensionOnPathWithLeadingDots),
        ("testPathRepresentableSplitExtensionOnPathWithOnlyDots", testPathRepresentableSplitExtensionOnPathWithOnlyDots),
        ("testPathRepresentableSplitExtensionOnEmptyPath", testPathRepresentableSplitExtensionOnEmptyPath),
    ]
}
extension SplitPathTests {
    static var allTests = [
        ("testSplitSimplePath", testSplitSimplePath),
        ("testSplitRootPath", testSplitRootPath),
        ("testSplitSingleCompomentPath", testSplitSingleCompomentPath),
        ("testSplitWithABunchOfPrefixSlashes", testSplitWithABunchOfPrefixSlashes),
        ("testSplitWithRedundantSeparator", testSplitWithRedundantSeparator),
        ("testPathRepresentableSplitSimplePath", testPathRepresentableSplitSimplePath),
        ("testPathRepresentableSplitRootPath", testPathRepresentableSplitRootPath),
        ("testPathRepresentableSplitSingleCompomentPath", testPathRepresentableSplitSingleCompomentPath),
        ("testPathRepresentableSplitWithABunchOfPrefixSlashes", testPathRepresentableSplitWithABunchOfPrefixSlashes),
        ("testPathRepresentableSplitWithRedundantSeparator", testPathRepresentableSplitWithRedundantSeparator),
    ]
}

XCTMain([
    testCase(IsAbsoluteTests.allTests),
    testCase(JoinPathTests.allTests),
    testCase(NormalizePathTests.allTests),
    testCase(PathBaseNameTests.allTests),
    testCase(PathDirectoryTests.allTests),
    testCase(SplitExtensionTests.allTests),
    testCase(SplitPathTests.allTests),
])
