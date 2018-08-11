// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import PathosTests

extension ExistsTest {
    static var allTests = [
        ("testExistingFiles", testExistingFiles),
        ("testNonExistingFiles", testNonExistingFiles),
        ("testExistingFilesFollowingSymbol", testExistingFilesFollowingSymbol),
        ("testExistingFilesNotFollowingSymbol", testExistingFilesNotFollowingSymbol),
        ("testGoodSymbolicLink", testGoodSymbolicLink),
        ("testBadSymbolicLink", testBadSymbolicLink),
        ("testGoodSymbolicLinkFollowingSymbol", testGoodSymbolicLinkFollowingSymbol),
        ("testBadSymbolicLinkFollowingSymbol", testBadSymbolicLinkFollowingSymbol),
        ("testGoodSymbolicLinkNotFollowingSymbol", testGoodSymbolicLinkNotFollowingSymbol),
        ("testBadSymbolicLinkNotFollowingSymbol", testBadSymbolicLinkNotFollowingSymbol),
        ("testPathRepresentableExistingFiles", testPathRepresentableExistingFiles),
        ("testPathRepresentableNonExistingFiles", testPathRepresentableNonExistingFiles),
        ("testPathRepresentableExistingFileFollowingSymbol", testPathRepresentableExistingFileFollowingSymbol),
        ("testPathRepresentableExistingFileNotFollowingSymbol", testPathRepresentableExistingFileNotFollowingSymbol),
        ("testPathRepresentableGoodSymbolicLink", testPathRepresentableGoodSymbolicLink),
        ("testPathRepresentableBadSymbolicLink", testPathRepresentableBadSymbolicLink),
        ("testPathRepresentableGoodSymbolicLinkFollowingSymbol", testPathRepresentableGoodSymbolicLinkFollowingSymbol),
        ("testPathRepresentableBadSymbolicLinkFollowingSymbol", testPathRepresentableBadSymbolicLinkFollowingSymbol),
        ("testPathRepresentableGoodSymbolicLinkNotFollowingSymbol", testPathRepresentableGoodSymbolicLinkNotFollowingSymbol),
        ("testPathRepresentableBadSymbolicLinkNotFollowingSymbol", testPathRepresentableBadSymbolicLinkNotFollowingSymbol),
    ]
}
extension ExpandUserDirectoryTests {
    static var allTests = [
        ("testExpandPathWithNoUser", testExpandPathWithNoUser),
        ("testUserDirectoryExpandsToHomeEnvironment", testUserDirectoryExpandsToHomeEnvironment),
        ("testSpecialHomeValue", testSpecialHomeValue),
        ("testFallbackToPasswdDatabase", testFallbackToPasswdDatabase),
        ("testPathRepresentableExpandPathWithNoUser", testPathRepresentableExpandPathWithNoUser),
        ("testPathRepresentableUserDirectoryExpandsToHomeEnvironment", testPathRepresentableUserDirectoryExpandsToHomeEnvironment),
        ("testPathRepresentableSpecialHomeValue", testPathRepresentableSpecialHomeValue),
        ("testPathRepresentableFallbackToPasswdDatabase", testPathRepresentableFallbackToPasswdDatabase),
    ]
}
extension FileExtensionTests {
    static var allTests = [
        ("testFileExtensionOnSimplePath", testFileExtensionOnSimplePath),
        ("testFileExtensionOnPathWithMultipleDots", testFileExtensionOnPathWithMultipleDots),
        ("testFileExtensionOnPathWithLeadingDot", testFileExtensionOnPathWithLeadingDot),
        ("testFileExtensionOnPathWithNoDots", testFileExtensionOnPathWithNoDots),
        ("testFileExtensionOnPathWithLeadingDotButNoExtension", testFileExtensionOnPathWithLeadingDotButNoExtension),
        ("testFileExtensionOnPathWithManyLeadingDotsButNoExtension", testFileExtensionOnPathWithManyLeadingDotsButNoExtension),
        ("testFileExtensionOnPathWithLeadingDotsButNoExtension", testFileExtensionOnPathWithLeadingDotsButNoExtension),
        ("testFileExtensionOnPathWithLeadingDots", testFileExtensionOnPathWithLeadingDots),
        ("testFileExtensionOnPathWithOnlyDots", testFileExtensionOnPathWithOnlyDots),
        ("testFileExtensionOnEmptyPath", testFileExtensionOnEmptyPath),
        ("testPathRepresentableFileExtensionOnSimplePath", testPathRepresentableFileExtensionOnSimplePath),
        ("testPathRepresentableFileExtensionOnPathWithMultipleDots", testPathRepresentableFileExtensionOnPathWithMultipleDots),
        ("testPathRepresentableFileExtensionOnPathWithLeadingDot", testPathRepresentableFileExtensionOnPathWithLeadingDot),
        ("testPathRepresentableFileExtensionOnPathWithNoDots", testPathRepresentableFileExtensionOnPathWithNoDots),
        ("testPathRepresentableFileExtensionOnPathWithLeadingDotButNoExtension", testPathRepresentableFileExtensionOnPathWithLeadingDotButNoExtension),
        ("testPathRepresentableFileExtensionOnPathWithManyLeadingDotsButNoExtension", testPathRepresentableFileExtensionOnPathWithManyLeadingDotsButNoExtension),
        ("testPathRepresentableFileExtensionOnPathWithLeadingDotsButNoExtension", testPathRepresentableFileExtensionOnPathWithLeadingDotsButNoExtension),
        ("testPathRepresentableFileExtensionOnPathWithLeadingDots", testPathRepresentableFileExtensionOnPathWithLeadingDots),
        ("testPathRepresentableFileExtensionOnPathWithOnlyDots", testPathRepresentableFileExtensionOnPathWithOnlyDots),
        ("testPathRepresentableFileExtensionOnEmptyPath", testPathRepresentableFileExtensionOnEmptyPath),
    ]
}
extension FixtureTestCase {
    static var allTests = [
    ]
}
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
extension MakeAbsoluteTests {
    static var allTests = [
        ("testMakeAbsolutePath", testMakeAbsolutePath),
        ("testPathRepresentableMakeAbsolutePath", testPathRepresentableMakeAbsolutePath),
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
    testCase(ExistsTest.allTests),
    testCase(ExpandUserDirectoryTests.allTests),
    testCase(FileExtensionTests.allTests),
    testCase(FixtureTestCase.allTests),
    testCase(IsAbsoluteTests.allTests),
    testCase(JoinPathTests.allTests),
    testCase(MakeAbsoluteTests.allTests),
    testCase(NormalizePathTests.allTests),
    testCase(PathBaseNameTests.allTests),
    testCase(PathDirectoryTests.allTests),
    testCase(SplitExtensionTests.allTests),
    testCase(SplitPathTests.allTests),
])
