// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import PathosTests

extension ChildrenTests {
    static var allTests = [
        ("testChildrenInPath", testChildrenInPath),
        ("testChildrenRecursiveInPath", testChildrenRecursiveInPath),
        ("testFilesInPath", testFilesInPath),
        ("testFilesRecursiveInPath", testFilesRecursiveInPath),
        ("testDirectoriesInPath", testDirectoriesInPath),
        ("testDirectoriesRecursiveInPath", testDirectoriesRecursiveInPath),
        ("testSymbolicLinksInPath", testSymbolicLinksInPath),
        ("testSymbolicLinksRecursiveInPath", testSymbolicLinksRecursiveInPath),
        ("testPathRepresentableChildrenInPath", testPathRepresentableChildrenInPath),
        ("testPathRepresentableChildrenRecursiveInPath", testPathRepresentableChildrenRecursiveInPath),
        ("testPathRepresentableFilesInPath", testPathRepresentableFilesInPath),
        ("testPathRepresentableFilesRecursiveInPath", testPathRepresentableFilesRecursiveInPath),
        ("testPathRepresentableDirectoriesInPath", testPathRepresentableDirectoriesInPath),
        ("testPathRepresentableDirectoriesRecursiveInPath", testPathRepresentableDirectoriesRecursiveInPath),
        ("testPathRepresentableSymbolicLinksInPath", testPathRepresentableSymbolicLinksInPath),
        ("testPathRepresentableSymbolicLinksRecursiveInPath", testPathRepresentableSymbolicLinksRecursiveInPath),
        ("testUnknownTypeFilesInPath", testUnknownTypeFilesInPath),
        ("testUnknownTypeFilesRecursiveInPath", testUnknownTypeFilesRecursiveInPath),
        ("testPathRepresentableUnknownTypeFilesInPath", testPathRepresentableUnknownTypeFilesInPath),
        ("testPathRepresentableUnknownTypeFilesRecursiveInPath", testPathRepresentableUnknownTypeFilesRecursiveInPath),
        ("testPipesInPath", testPipesInPath),
        ("testPipesRecursiveInPath", testPipesRecursiveInPath),
        ("testPathRepresentablePipesInPath", testPathRepresentablePipesInPath),
        ("testPathRepresentablePipesRecursiveInPath", testPathRepresentablePipesRecursiveInPath),
        ("testCharacterDevicesInPath", testCharacterDevicesInPath),
        ("testCharacterDevicesRecursiveInPath", testCharacterDevicesRecursiveInPath),
        ("testPathRepresentableCharacterDevicesInPath", testPathRepresentableCharacterDevicesInPath),
        ("testPathRepresentableCharacterDevicesRecursiveInPath", testPathRepresentableCharacterDevicesRecursiveInPath),
        ("testBlockDevicesInPath", testBlockDevicesInPath),
        ("testBlockDevicesRecursiveInPath", testBlockDevicesRecursiveInPath),
        ("testPathRepresentableBlockDevicesInPath", testPathRepresentableBlockDevicesInPath),
        ("testPathRepresentableBlockDevicesRecursiveInPath", testPathRepresentableBlockDevicesRecursiveInPath),
        ("testSocketsInPath", testSocketsInPath),
        ("testSocketsRecursiveInPath", testSocketsRecursiveInPath),
        ("testPathRepresentableSocketsInPath", testPathRepresentableSocketsInPath),
        ("testPathRepresentableSocketsRecursiveInPath", testPathRepresentableSocketsRecursiveInPath),
    ]
}
extension ExistsTest {
    static var allTests = [
        ("testExistingFiles", testExistingFiles),
        ("testNonExistingFiles", testNonExistingFiles),
        ("testExistingFilesFollowingSymbol", testExistingFilesFollowingSymbol),
        ("testExistingFilesNotFollowingSymbol", testExistingFilesNotFollowingSymbol),
        ("testGoodSymbolicLink", testGoodSymbolicLink),
        ("testGoodSymbolicDirectoryLink", testGoodSymbolicDirectoryLink),
        ("testBadSymbolicLink", testBadSymbolicLink),
        ("testGoodSymbolicLinkFollowingSymbol", testGoodSymbolicLinkFollowingSymbol),
        ("testGoodSymbolicDirectoryLinkFollowingSymbol", testGoodSymbolicDirectoryLinkFollowingSymbol),
        ("testBadSymbolicLinkFollowingSymbol", testBadSymbolicLinkFollowingSymbol),
        ("testGoodSymbolicLinkNotFollowingSymbol", testGoodSymbolicLinkNotFollowingSymbol),
        ("testGoodSymbolicDirectoryLinkNotFollowingSymbol", testGoodSymbolicDirectoryLinkNotFollowingSymbol),
        ("testBadSymbolicLinkNotFollowingSymbol", testBadSymbolicLinkNotFollowingSymbol),
        ("testPathRepresentableExistingFiles", testPathRepresentableExistingFiles),
        ("testPathRepresentableNonExistingFiles", testPathRepresentableNonExistingFiles),
        ("testPathRepresentableExistingFileFollowingSymbol", testPathRepresentableExistingFileFollowingSymbol),
        ("testPathRepresentableExistingFileNotFollowingSymbol", testPathRepresentableExistingFileNotFollowingSymbol),
        ("testPathRepresentableGoodSymbolicLink", testPathRepresentableGoodSymbolicLink),
        ("testPathRepresentableGoodSymbolicDirectoryLink", testPathRepresentableGoodSymbolicDirectoryLink),
        ("testPathRepresentableBadSymbolicLink", testPathRepresentableBadSymbolicLink),
        ("testPathRepresentableGoodSymbolicLinkFollowingSymbol", testPathRepresentableGoodSymbolicLinkFollowingSymbol),
        ("testPathRepresentableGoodSymbolicDirectorcyLinkFollowingSymbol", testPathRepresentableGoodSymbolicDirectorcyLinkFollowingSymbol),
        ("testPathRepresentableBadSymbolicLinkFollowingSymbol", testPathRepresentableBadSymbolicLinkFollowingSymbol),
        ("testPathRepresentableGoodSymbolicLinkNotFollowingSymbol", testPathRepresentableGoodSymbolicLinkNotFollowingSymbol),
        ("testPathRepresentableGoodDirectorySymbolicLinkNotFollowingSymbol", testPathRepresentableGoodDirectorySymbolicLinkNotFollowingSymbol),
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
extension IsBlockDeviceTests {
    static var allTests = [
        ("testIsBlockDeviceOnExistingFile", testIsBlockDeviceOnExistingFile),
        ("testIsBlockDeviceOnExistingDirectory", testIsBlockDeviceOnExistingDirectory),
        ("testIsBlockDeviceOnNonExistingPath", testIsBlockDeviceOnNonExistingPath),
        ("testIsBlockDeviceOnSymbolicLink", testIsBlockDeviceOnSymbolicLink),
        ("testIsBlockDeviceOnSymbolicDirectoryLink", testIsBlockDeviceOnSymbolicDirectoryLink),
        ("testIsBlockDeviceOnBadSymbolicLink", testIsBlockDeviceOnBadSymbolicLink),
        ("testFileRepresentableIsBlockDeviceOnExistingFile", testFileRepresentableIsBlockDeviceOnExistingFile),
        ("testFileRepresentableIsBlockDeviceOnExistingDirectory", testFileRepresentableIsBlockDeviceOnExistingDirectory),
        ("testFileRepresentableIsBlockDeviceOnNonExistingFile", testFileRepresentableIsBlockDeviceOnNonExistingFile),
        ("testPathRerpesentableIsBlockDeviceOnSymbolicLink", testPathRerpesentableIsBlockDeviceOnSymbolicLink),
        ("testPathRepresentableIsBlockDeviceOnSymbolicDirectoryLink", testPathRepresentableIsBlockDeviceOnSymbolicDirectoryLink),
        ("testPathRerpesentableIsBlockDeviceOnBadSymbolicLink", testPathRerpesentableIsBlockDeviceOnBadSymbolicLink),
    ]
}
extension IsCharacterDeviceTests {
    static var allTests = [
        ("testIsCharacterDeviceOnExistingFile", testIsCharacterDeviceOnExistingFile),
        ("testIsCharacterDeviceOnExistingDirectory", testIsCharacterDeviceOnExistingDirectory),
        ("testIsCharacterDeviceOnNonExistingPath", testIsCharacterDeviceOnNonExistingPath),
        ("testIsCharacterDeviceOnSymbolicLink", testIsCharacterDeviceOnSymbolicLink),
        ("testIsCharacterDeviceOnSymbolicDirectoryLink", testIsCharacterDeviceOnSymbolicDirectoryLink),
        ("testIsCharacterDeviceOnBadSymbolicLink", testIsCharacterDeviceOnBadSymbolicLink),
        ("testFileRepresentableIsCharacterDeviceOnExistingFile", testFileRepresentableIsCharacterDeviceOnExistingFile),
        ("testFileRepresentableIsCharacterDeviceOnExistingDirectory", testFileRepresentableIsCharacterDeviceOnExistingDirectory),
        ("testFileRepresentableIsCharacterDeviceOnNonExistingFile", testFileRepresentableIsCharacterDeviceOnNonExistingFile),
        ("testPathRerpesentableIsCharacterDeviceOnSymbolicLink", testPathRerpesentableIsCharacterDeviceOnSymbolicLink),
        ("testPathRepresentableIsCharacterDeviceOnSymbolicDirectoryLink", testPathRepresentableIsCharacterDeviceOnSymbolicDirectoryLink),
        ("testPathRerpesentableIsCharacterDeviceOnBadSymbolicLink", testPathRerpesentableIsCharacterDeviceOnBadSymbolicLink),
    ]
}
extension IsDirectoryTests {
    static var allTests = [
        ("testIsDirectoryOnExistingFile", testIsDirectoryOnExistingFile),
        ("testIsDirectoryOnExistingDirectory", testIsDirectoryOnExistingDirectory),
        ("testIsDirectoryOnNonExistingPath", testIsDirectoryOnNonExistingPath),
        ("testIsDirectoryOnSymbolicLink", testIsDirectoryOnSymbolicLink),
        ("testIsDirectoryOnSymbolicDirectoryLink", testIsDirectoryOnSymbolicDirectoryLink),
        ("testIsDirectoryOnBadSymbolicLink", testIsDirectoryOnBadSymbolicLink),
        ("testDirectoryRepresentableIsFileOnExistingFile", testDirectoryRepresentableIsFileOnExistingFile),
        ("testDirectoryRepresentableIsFileOnExistingDirectory", testDirectoryRepresentableIsFileOnExistingDirectory),
        ("testDirectoryRepresentableIsFileOnNonExistingFile", testDirectoryRepresentableIsFileOnNonExistingFile),
        ("testPathRepresentableIsDirectoryOnSymbolicLink", testPathRepresentableIsDirectoryOnSymbolicLink),
        ("testPathRepresentableIsDirectoryOnSymbolicDirectoryLink", testPathRepresentableIsDirectoryOnSymbolicDirectoryLink),
        ("testPathRepresentableIsDirectoryOnBadSymbolicLink", testPathRepresentableIsDirectoryOnBadSymbolicLink),
    ]
}
extension IsFileTests {
    static var allTests = [
        ("testIsFileOnExistingFile", testIsFileOnExistingFile),
        ("testIsFileOnExistingDirectory", testIsFileOnExistingDirectory),
        ("testIsFileOnNonExistingPath", testIsFileOnNonExistingPath),
        ("testIsFileOnSymbolicLink", testIsFileOnSymbolicLink),
        ("testIsFileOnSymbolicDirectoryLink", testIsFileOnSymbolicDirectoryLink),
        ("testIsFileOnBadSymbolicLink", testIsFileOnBadSymbolicLink),
        ("testFileRepresentableIsFileOnExistingFile", testFileRepresentableIsFileOnExistingFile),
        ("testFileRepresentableIsFileOnExistingDirectory", testFileRepresentableIsFileOnExistingDirectory),
        ("testFileRepresentableIsFileOnNonExistingFile", testFileRepresentableIsFileOnNonExistingFile),
        ("testPathRerpesentableIsFileOnSymbolicLink", testPathRerpesentableIsFileOnSymbolicLink),
        ("testPathRepresentableIsFileOnSymbolicDirectoryLink", testPathRepresentableIsFileOnSymbolicDirectoryLink),
        ("testPathRerpesentableIsFileOnBadSymbolicLink", testPathRerpesentableIsFileOnBadSymbolicLink),
    ]
}
extension IsPipeTests {
    static var allTests = [
        ("testIsPipeOnExistingFile", testIsPipeOnExistingFile),
        ("testIsPipeOnExistingDirectory", testIsPipeOnExistingDirectory),
        ("testIsPipeOnNonExistingPath", testIsPipeOnNonExistingPath),
        ("testIsPipeOnSymbolicLink", testIsPipeOnSymbolicLink),
        ("testIsPipeOnSymbolicDirectoryLink", testIsPipeOnSymbolicDirectoryLink),
        ("testIsPipeOnBadSymbolicLink", testIsPipeOnBadSymbolicLink),
        ("testFileRepresentableIsPipeOnExistingFile", testFileRepresentableIsPipeOnExistingFile),
        ("testFileRepresentableIsPipeOnExistingDirectory", testFileRepresentableIsPipeOnExistingDirectory),
        ("testFileRepresentableIsPipeOnNonExistingFile", testFileRepresentableIsPipeOnNonExistingFile),
        ("testPathRerpesentableIsPipeOnSymbolicLink", testPathRerpesentableIsPipeOnSymbolicLink),
        ("testPathRepresentableIsPipeOnSymbolicDirectoryLink", testPathRepresentableIsPipeOnSymbolicDirectoryLink),
        ("testPathRerpesentableIsPipeOnBadSymbolicLink", testPathRerpesentableIsPipeOnBadSymbolicLink),
    ]
}
extension IsSocketTests {
    static var allTests = [
        ("testIsSocketOnExistingFile", testIsSocketOnExistingFile),
        ("testIsSocketOnExistingDirectory", testIsSocketOnExistingDirectory),
        ("testIsSocketOnNonExistingPath", testIsSocketOnNonExistingPath),
        ("testIsSocketOnSymbolicLink", testIsSocketOnSymbolicLink),
        ("testIsSocketOnSymbolicDirectoryLink", testIsSocketOnSymbolicDirectoryLink),
        ("testIsSocketOnBadSymbolicLink", testIsSocketOnBadSymbolicLink),
        ("testFileRepresentableIsSocketOnExistingFile", testFileRepresentableIsSocketOnExistingFile),
        ("testFileRepresentableIsSocketOnExistingDirectory", testFileRepresentableIsSocketOnExistingDirectory),
        ("testFileRepresentableIsSocketOnNonExistingFile", testFileRepresentableIsSocketOnNonExistingFile),
        ("testPathRerpesentableIsSocketOnSymbolicLink", testPathRerpesentableIsSocketOnSymbolicLink),
        ("testPathRepresentableIsSocketOnSymbolicDirectoryLink", testPathRepresentableIsSocketOnSymbolicDirectoryLink),
        ("testPathRerpesentableIsSocketOnBadSymbolicLink", testPathRerpesentableIsSocketOnBadSymbolicLink),
    ]
}
extension IsSymbolicLinkTests {
    static var allTests = [
        ("testIsSymbolicLinkOnFile", testIsSymbolicLinkOnFile),
        ("testIsSymbolicLinkOnDirectory", testIsSymbolicLinkOnDirectory),
        ("testIsSymbolicLinkOnNonExistingPath", testIsSymbolicLinkOnNonExistingPath),
        ("testIsSymbolicLinkOnGoodFileSymbol", testIsSymbolicLinkOnGoodFileSymbol),
        ("testIsSymbolicLinkOnGoodDirectorySymbol", testIsSymbolicLinkOnGoodDirectorySymbol),
        ("testIsSymbolicLinkOnBadSymbol", testIsSymbolicLinkOnBadSymbol),
        ("testPathRepresentableIsSymbolicLinkOnFile", testPathRepresentableIsSymbolicLinkOnFile),
        ("testPathRepresentableIsSymbolicLinkOnDirectory", testPathRepresentableIsSymbolicLinkOnDirectory),
        ("testPathRepresentableIsSymbolicLinkOnNonExistingPath", testPathRepresentableIsSymbolicLinkOnNonExistingPath),
        ("testPathRepresentableIsSymbolicLinkOnGoodFileSymbol", testPathRepresentableIsSymbolicLinkOnGoodFileSymbol),
        ("testPathRepresentableIsSymbolicLinkOnGoodDirectorySymbol", testPathRepresentableIsSymbolicLinkOnGoodDirectorySymbol),
        ("testPathRepresentableIsSymbolicLinkOnBadSymbol", testPathRepresentableIsSymbolicLinkOnBadSymbol),
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
extension ReadingTests {
    static var allTests = [
        ("testReadString", testReadString),
        ("testReadBytes", testReadBytes),
        ("testReadStringFromDirectory", testReadStringFromDirectory),
        ("testReadStringFromNoWhere", testReadStringFromNoWhere),
        ("testReadSymbolicLink", testReadSymbolicLink),
        ("testPathRepresentableReadString", testPathRepresentableReadString),
        ("testPathRepresentableReadBytes", testPathRepresentableReadBytes),
        ("testPathRepresentableReadStringFromDirectory", testPathRepresentableReadStringFromDirectory),
        ("testPathRepresentableReadStringFromNoWhere", testPathRepresentableReadStringFromNoWhere),
        ("testPathRepresentableReadSymbolicLink", testPathRepresentableReadSymbolicLink),
    ]
}
extension SameFileTests {
    static var allTests = [
        ("testSameFileAsSymbolicLink", testSameFileAsSymbolicLink),
        ("testNotSameFile", testNotSameFile),
        ("testPathRepresentableSameFileAsSymbolicLink", testPathRepresentableSameFileAsSymbolicLink),
        ("testPathRepresentableNotSameFile", testPathRepresentableNotSameFile),
    ]
}
extension SizeTests {
    static var allTests = [
        ("testSizeOfRegularFile", testSizeOfRegularFile),
        ("testSizeOfSymbolToRegularFile", testSizeOfSymbolToRegularFile),
        ("testSizeOfDirectory", testSizeOfDirectory),
        ("testSizeOfSymbolToDirectory", testSizeOfSymbolToDirectory),
        ("testSizeOfNonExistingPath", testSizeOfNonExistingPath),
        ("testPathRepresentableSizeOfRegularFile", testPathRepresentableSizeOfRegularFile),
        ("testPathRepresentableSizeOfSymbolToRegularFile", testPathRepresentableSizeOfSymbolToRegularFile),
        ("testPathRepresentableSizeOfDirectory", testPathRepresentableSizeOfDirectory),
        ("testPathRepresentableSizeOfSymbolToDirectory", testPathRepresentableSizeOfSymbolToDirectory),
        ("testPathRepresentableSizeOfNonExistingPath", testPathRepresentableSizeOfNonExistingPath),
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
    testCase(ChildrenTests.allTests),
    testCase(ExistsTest.allTests),
    testCase(ExpandUserDirectoryTests.allTests),
    testCase(FileExtensionTests.allTests),
    testCase(FixtureTestCase.allTests),
    testCase(IsAbsoluteTests.allTests),
    testCase(IsBlockDeviceTests.allTests),
    testCase(IsCharacterDeviceTests.allTests),
    testCase(IsDirectoryTests.allTests),
    testCase(IsFileTests.allTests),
    testCase(IsPipeTests.allTests),
    testCase(IsSocketTests.allTests),
    testCase(IsSymbolicLinkTests.allTests),
    testCase(JoinPathTests.allTests),
    testCase(MakeAbsoluteTests.allTests),
    testCase(NormalizePathTests.allTests),
    testCase(PathBaseNameTests.allTests),
    testCase(PathDirectoryTests.allTests),
    testCase(ReadingTests.allTests),
    testCase(SameFileTests.allTests),
    testCase(SizeTests.allTests),
    testCase(SplitExtensionTests.allTests),
    testCase(SplitPathTests.allTests),
])
