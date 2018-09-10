import XCTest

extension ChildrenTests {
    static let __allTests = [
        ("testBlockDevicesInPath", testBlockDevicesInPath),
        ("testBlockDevicesRecursiveInPath", testBlockDevicesRecursiveInPath),
        ("testCharacterDevicesInPath", testCharacterDevicesInPath),
        ("testCharacterDevicesRecursiveInPath", testCharacterDevicesRecursiveInPath),
        ("testChildrenInPath", testChildrenInPath),
        ("testChildrenRecursiveInPath", testChildrenRecursiveInPath),
        ("testDirectoriesInPath", testDirectoriesInPath),
        ("testDirectoriesRecursiveInPath", testDirectoriesRecursiveInPath),
        ("testFilesInPath", testFilesInPath),
        ("testFilesRecursiveInPath", testFilesRecursiveInPath),
        ("testPathRepresentableBlockDevicesInPath", testPathRepresentableBlockDevicesInPath),
        ("testPathRepresentableBlockDevicesRecursiveInPath", testPathRepresentableBlockDevicesRecursiveInPath),
        ("testPathRepresentableCharacterDevicesInPath", testPathRepresentableCharacterDevicesInPath),
        ("testPathRepresentableCharacterDevicesRecursiveInPath", testPathRepresentableCharacterDevicesRecursiveInPath),
        ("testPathRepresentableChildrenInPath", testPathRepresentableChildrenInPath),
        ("testPathRepresentableChildrenRecursiveInPath", testPathRepresentableChildrenRecursiveInPath),
        ("testPathRepresentableDirectoriesInPath", testPathRepresentableDirectoriesInPath),
        ("testPathRepresentableDirectoriesRecursiveInPath", testPathRepresentableDirectoriesRecursiveInPath),
        ("testPathRepresentableFilesInPath", testPathRepresentableFilesInPath),
        ("testPathRepresentableFilesRecursiveInPath", testPathRepresentableFilesRecursiveInPath),
        ("testPathRepresentablePipesInPath", testPathRepresentablePipesInPath),
        ("testPathRepresentablePipesRecursiveInPath", testPathRepresentablePipesRecursiveInPath),
        ("testPathRepresentableSocketsInPath", testPathRepresentableSocketsInPath),
        ("testPathRepresentableSocketsRecursiveInPath", testPathRepresentableSocketsRecursiveInPath),
        ("testPathRepresentableSymbolicLinksInPath", testPathRepresentableSymbolicLinksInPath),
        ("testPathRepresentableSymbolicLinksRecursiveInPath", testPathRepresentableSymbolicLinksRecursiveInPath),
        ("testPathRepresentableUnknownTypeFilesInPath", testPathRepresentableUnknownTypeFilesInPath),
        ("testPathRepresentableUnknownTypeFilesRecursiveInPath", testPathRepresentableUnknownTypeFilesRecursiveInPath),
        ("testPipesInPath", testPipesInPath),
        ("testPipesRecursiveInPath", testPipesRecursiveInPath),
        ("testSocketsInPath", testSocketsInPath),
        ("testSocketsRecursiveInPath", testSocketsRecursiveInPath),
        ("testSymbolicLinksInPath", testSymbolicLinksInPath),
        ("testSymbolicLinksRecursiveInPath", testSymbolicLinksRecursiveInPath),
        ("testUnknownTypeFilesInPath", testUnknownTypeFilesInPath),
        ("testUnknownTypeFilesRecursiveInPath", testUnknownTypeFilesRecursiveInPath),
    ]
}

extension ExistsTests {
    static let __allTests = [
        ("testBadSymbolicLink", testBadSymbolicLink),
        ("testBadSymbolicLinkFollowingSymbol", testBadSymbolicLinkFollowingSymbol),
        ("testBadSymbolicLinkNotFollowingSymbol", testBadSymbolicLinkNotFollowingSymbol),
        ("testExistingFiles", testExistingFiles),
        ("testExistingFilesFollowingSymbol", testExistingFilesFollowingSymbol),
        ("testExistingFilesNotFollowingSymbol", testExistingFilesNotFollowingSymbol),
        ("testGoodSymbolicDirectoryLink", testGoodSymbolicDirectoryLink),
        ("testGoodSymbolicDirectoryLinkFollowingSymbol", testGoodSymbolicDirectoryLinkFollowingSymbol),
        ("testGoodSymbolicDirectoryLinkNotFollowingSymbol", testGoodSymbolicDirectoryLinkNotFollowingSymbol),
        ("testGoodSymbolicLink", testGoodSymbolicLink),
        ("testGoodSymbolicLinkFollowingSymbol", testGoodSymbolicLinkFollowingSymbol),
        ("testGoodSymbolicLinkNotFollowingSymbol", testGoodSymbolicLinkNotFollowingSymbol),
        ("testNonExistingFiles", testNonExistingFiles),
        ("testPathRepresentableBadSymbolicLink", testPathRepresentableBadSymbolicLink),
        ("testPathRepresentableBadSymbolicLinkFollowingSymbol", testPathRepresentableBadSymbolicLinkFollowingSymbol),
        ("testPathRepresentableBadSymbolicLinkNotFollowingSymbol", testPathRepresentableBadSymbolicLinkNotFollowingSymbol),
        ("testPathRepresentableExistingFileFollowingSymbol", testPathRepresentableExistingFileFollowingSymbol),
        ("testPathRepresentableExistingFileNotFollowingSymbol", testPathRepresentableExistingFileNotFollowingSymbol),
        ("testPathRepresentableExistingFiles", testPathRepresentableExistingFiles),
        ("testPathRepresentableGoodDirectorySymbolicLinkNotFollowingSymbol", testPathRepresentableGoodDirectorySymbolicLinkNotFollowingSymbol),
        ("testPathRepresentableGoodSymbolicDirectorcyLinkFollowingSymbol", testPathRepresentableGoodSymbolicDirectorcyLinkFollowingSymbol),
        ("testPathRepresentableGoodSymbolicDirectoryLink", testPathRepresentableGoodSymbolicDirectoryLink),
        ("testPathRepresentableGoodSymbolicLink", testPathRepresentableGoodSymbolicLink),
        ("testPathRepresentableGoodSymbolicLinkFollowingSymbol", testPathRepresentableGoodSymbolicLinkFollowingSymbol),
        ("testPathRepresentableGoodSymbolicLinkNotFollowingSymbol", testPathRepresentableGoodSymbolicLinkNotFollowingSymbol),
        ("testPathRepresentableNonExistingFiles", testPathRepresentableNonExistingFiles),
    ]
}

extension ExpandUserDirectoryTests {
    static let __allTests = [
        ("testExpandPathWithNoUser", testExpandPathWithNoUser),
        ("testFallbackToPasswdDatabase", testFallbackToPasswdDatabase),
        ("testPathRepresentableExpandPathWithNoUser", testPathRepresentableExpandPathWithNoUser),
        ("testPathRepresentableFallbackToPasswdDatabase", testPathRepresentableFallbackToPasswdDatabase),
        ("testPathRepresentableSpecialHomeValue", testPathRepresentableSpecialHomeValue),
        ("testPathRepresentableUserDirectoryExpandsToHomeEnvironment", testPathRepresentableUserDirectoryExpandsToHomeEnvironment),
        ("testSpecialHomeValue", testSpecialHomeValue),
        ("testUserDirectoryExpandsToHomeEnvironment", testUserDirectoryExpandsToHomeEnvironment),
    ]
}

extension FileExtensionTests {
    static let __allTests = [
        ("testFileExtensionOnEmptyPath", testFileExtensionOnEmptyPath),
        ("testFileExtensionOnPathWithLeadingDot", testFileExtensionOnPathWithLeadingDot),
        ("testFileExtensionOnPathWithLeadingDotButNoExtension", testFileExtensionOnPathWithLeadingDotButNoExtension),
        ("testFileExtensionOnPathWithLeadingDots", testFileExtensionOnPathWithLeadingDots),
        ("testFileExtensionOnPathWithLeadingDotsButNoExtension", testFileExtensionOnPathWithLeadingDotsButNoExtension),
        ("testFileExtensionOnPathWithManyLeadingDotsButNoExtension", testFileExtensionOnPathWithManyLeadingDotsButNoExtension),
        ("testFileExtensionOnPathWithMultipleDots", testFileExtensionOnPathWithMultipleDots),
        ("testFileExtensionOnPathWithNoDots", testFileExtensionOnPathWithNoDots),
        ("testFileExtensionOnPathWithOnlyDots", testFileExtensionOnPathWithOnlyDots),
        ("testFileExtensionOnSimplePath", testFileExtensionOnSimplePath),
        ("testPathRepresentableFileExtensionOnEmptyPath", testPathRepresentableFileExtensionOnEmptyPath),
        ("testPathRepresentableFileExtensionOnPathWithLeadingDot", testPathRepresentableFileExtensionOnPathWithLeadingDot),
        ("testPathRepresentableFileExtensionOnPathWithLeadingDotButNoExtension", testPathRepresentableFileExtensionOnPathWithLeadingDotButNoExtension),
        ("testPathRepresentableFileExtensionOnPathWithLeadingDots", testPathRepresentableFileExtensionOnPathWithLeadingDots),
        ("testPathRepresentableFileExtensionOnPathWithLeadingDotsButNoExtension", testPathRepresentableFileExtensionOnPathWithLeadingDotsButNoExtension),
        ("testPathRepresentableFileExtensionOnPathWithManyLeadingDotsButNoExtension", testPathRepresentableFileExtensionOnPathWithManyLeadingDotsButNoExtension),
        ("testPathRepresentableFileExtensionOnPathWithMultipleDots", testPathRepresentableFileExtensionOnPathWithMultipleDots),
        ("testPathRepresentableFileExtensionOnPathWithNoDots", testPathRepresentableFileExtensionOnPathWithNoDots),
        ("testPathRepresentableFileExtensionOnPathWithOnlyDots", testPathRepresentableFileExtensionOnPathWithOnlyDots),
        ("testPathRepresentableFileExtensionOnSimplePath", testPathRepresentableFileExtensionOnSimplePath),
    ]
}

extension IsAbsoluteTests {
    static let __allTests = [
        ("testIsAbsolutePath", testIsAbsolutePath),
        ("testPathRepresentableIsAbsolute", testPathRepresentableIsAbsolute),
    ]
}

extension IsBlockDeviceTests {
    static let __allTests = [
        ("testFileRepresentableIsBlockDeviceOnExistingDirectory", testFileRepresentableIsBlockDeviceOnExistingDirectory),
        ("testFileRepresentableIsBlockDeviceOnExistingFile", testFileRepresentableIsBlockDeviceOnExistingFile),
        ("testFileRepresentableIsBlockDeviceOnNonExistingFile", testFileRepresentableIsBlockDeviceOnNonExistingFile),
        ("testIsBlockDeviceOnBadSymbolicLink", testIsBlockDeviceOnBadSymbolicLink),
        ("testIsBlockDeviceOnExistingDirectory", testIsBlockDeviceOnExistingDirectory),
        ("testIsBlockDeviceOnExistingFile", testIsBlockDeviceOnExistingFile),
        ("testIsBlockDeviceOnNonExistingPath", testIsBlockDeviceOnNonExistingPath),
        ("testIsBlockDeviceOnSymbolicDirectoryLink", testIsBlockDeviceOnSymbolicDirectoryLink),
        ("testIsBlockDeviceOnSymbolicLink", testIsBlockDeviceOnSymbolicLink),
        ("testPathRepresentableIsBlockDeviceOnSymbolicDirectoryLink", testPathRepresentableIsBlockDeviceOnSymbolicDirectoryLink),
        ("testPathRerpesentableIsBlockDeviceOnBadSymbolicLink", testPathRerpesentableIsBlockDeviceOnBadSymbolicLink),
        ("testPathRerpesentableIsBlockDeviceOnSymbolicLink", testPathRerpesentableIsBlockDeviceOnSymbolicLink),
    ]
}

extension IsCharacterDeviceTests {
    static let __allTests = [
        ("testFileRepresentableIsCharacterDeviceOnExistingDirectory", testFileRepresentableIsCharacterDeviceOnExistingDirectory),
        ("testFileRepresentableIsCharacterDeviceOnExistingFile", testFileRepresentableIsCharacterDeviceOnExistingFile),
        ("testFileRepresentableIsCharacterDeviceOnNonExistingFile", testFileRepresentableIsCharacterDeviceOnNonExistingFile),
        ("testIsCharacterDeviceOnBadSymbolicLink", testIsCharacterDeviceOnBadSymbolicLink),
        ("testIsCharacterDeviceOnExistingDirectory", testIsCharacterDeviceOnExistingDirectory),
        ("testIsCharacterDeviceOnExistingFile", testIsCharacterDeviceOnExistingFile),
        ("testIsCharacterDeviceOnNonExistingPath", testIsCharacterDeviceOnNonExistingPath),
        ("testIsCharacterDeviceOnSymbolicDirectoryLink", testIsCharacterDeviceOnSymbolicDirectoryLink),
        ("testIsCharacterDeviceOnSymbolicLink", testIsCharacterDeviceOnSymbolicLink),
        ("testPathRepresentableIsCharacterDeviceOnSymbolicDirectoryLink", testPathRepresentableIsCharacterDeviceOnSymbolicDirectoryLink),
        ("testPathRerpesentableIsCharacterDeviceOnBadSymbolicLink", testPathRerpesentableIsCharacterDeviceOnBadSymbolicLink),
        ("testPathRerpesentableIsCharacterDeviceOnSymbolicLink", testPathRerpesentableIsCharacterDeviceOnSymbolicLink),
    ]
}

extension IsDirectoryTests {
    static let __allTests = [
        ("testDirectoryRepresentableIsFileOnExistingDirectory", testDirectoryRepresentableIsFileOnExistingDirectory),
        ("testDirectoryRepresentableIsFileOnExistingFile", testDirectoryRepresentableIsFileOnExistingFile),
        ("testDirectoryRepresentableIsFileOnNonExistingFile", testDirectoryRepresentableIsFileOnNonExistingFile),
        ("testIsDirectoryOnBadSymbolicLink", testIsDirectoryOnBadSymbolicLink),
        ("testIsDirectoryOnExistingDirectory", testIsDirectoryOnExistingDirectory),
        ("testIsDirectoryOnExistingFile", testIsDirectoryOnExistingFile),
        ("testIsDirectoryOnNonExistingPath", testIsDirectoryOnNonExistingPath),
        ("testIsDirectoryOnSymbolicDirectoryLink", testIsDirectoryOnSymbolicDirectoryLink),
        ("testIsDirectoryOnSymbolicLink", testIsDirectoryOnSymbolicLink),
        ("testPathRepresentableIsDirectoryOnBadSymbolicLink", testPathRepresentableIsDirectoryOnBadSymbolicLink),
        ("testPathRepresentableIsDirectoryOnSymbolicDirectoryLink", testPathRepresentableIsDirectoryOnSymbolicDirectoryLink),
        ("testPathRepresentableIsDirectoryOnSymbolicLink", testPathRepresentableIsDirectoryOnSymbolicLink),
    ]
}

extension IsFileTests {
    static let __allTests = [
        ("testFileRepresentableIsFileOnExistingDirectory", testFileRepresentableIsFileOnExistingDirectory),
        ("testFileRepresentableIsFileOnExistingFile", testFileRepresentableIsFileOnExistingFile),
        ("testFileRepresentableIsFileOnNonExistingFile", testFileRepresentableIsFileOnNonExistingFile),
        ("testIsFileOnBadSymbolicLink", testIsFileOnBadSymbolicLink),
        ("testIsFileOnExistingDirectory", testIsFileOnExistingDirectory),
        ("testIsFileOnExistingFile", testIsFileOnExistingFile),
        ("testIsFileOnNonExistingPath", testIsFileOnNonExistingPath),
        ("testIsFileOnSymbolicDirectoryLink", testIsFileOnSymbolicDirectoryLink),
        ("testIsFileOnSymbolicLink", testIsFileOnSymbolicLink),
        ("testPathRepresentableIsFileOnSymbolicDirectoryLink", testPathRepresentableIsFileOnSymbolicDirectoryLink),
        ("testPathRerpesentableIsFileOnBadSymbolicLink", testPathRerpesentableIsFileOnBadSymbolicLink),
        ("testPathRerpesentableIsFileOnSymbolicLink", testPathRerpesentableIsFileOnSymbolicLink),
    ]
}

extension IsPipeTests {
    static let __allTests = [
        ("testFileRepresentableIsPipeOnExistingDirectory", testFileRepresentableIsPipeOnExistingDirectory),
        ("testFileRepresentableIsPipeOnExistingFile", testFileRepresentableIsPipeOnExistingFile),
        ("testFileRepresentableIsPipeOnNonExistingFile", testFileRepresentableIsPipeOnNonExistingFile),
        ("testIsPipeOnBadSymbolicLink", testIsPipeOnBadSymbolicLink),
        ("testIsPipeOnExistingDirectory", testIsPipeOnExistingDirectory),
        ("testIsPipeOnExistingFile", testIsPipeOnExistingFile),
        ("testIsPipeOnNonExistingPath", testIsPipeOnNonExistingPath),
        ("testIsPipeOnSymbolicDirectoryLink", testIsPipeOnSymbolicDirectoryLink),
        ("testIsPipeOnSymbolicLink", testIsPipeOnSymbolicLink),
        ("testPathRepresentableIsPipeOnSymbolicDirectoryLink", testPathRepresentableIsPipeOnSymbolicDirectoryLink),
        ("testPathRerpesentableIsPipeOnBadSymbolicLink", testPathRerpesentableIsPipeOnBadSymbolicLink),
        ("testPathRerpesentableIsPipeOnSymbolicLink", testPathRerpesentableIsPipeOnSymbolicLink),
    ]
}

extension IsSocketTests {
    static let __allTests = [
        ("testFileRepresentableIsSocketOnExistingDirectory", testFileRepresentableIsSocketOnExistingDirectory),
        ("testFileRepresentableIsSocketOnExistingFile", testFileRepresentableIsSocketOnExistingFile),
        ("testFileRepresentableIsSocketOnNonExistingFile", testFileRepresentableIsSocketOnNonExistingFile),
        ("testIsSocketOnBadSymbolicLink", testIsSocketOnBadSymbolicLink),
        ("testIsSocketOnExistingDirectory", testIsSocketOnExistingDirectory),
        ("testIsSocketOnExistingFile", testIsSocketOnExistingFile),
        ("testIsSocketOnNonExistingPath", testIsSocketOnNonExistingPath),
        ("testIsSocketOnSymbolicDirectoryLink", testIsSocketOnSymbolicDirectoryLink),
        ("testIsSocketOnSymbolicLink", testIsSocketOnSymbolicLink),
        ("testPathRepresentableIsSocketOnSymbolicDirectoryLink", testPathRepresentableIsSocketOnSymbolicDirectoryLink),
        ("testPathRerpesentableIsSocketOnBadSymbolicLink", testPathRerpesentableIsSocketOnBadSymbolicLink),
        ("testPathRerpesentableIsSocketOnSymbolicLink", testPathRerpesentableIsSocketOnSymbolicLink),
    ]
}

extension IsSymbolicLinkTests {
    static let __allTests = [
        ("testIsSymbolicLinkOnBadSymbol", testIsSymbolicLinkOnBadSymbol),
        ("testIsSymbolicLinkOnDirectory", testIsSymbolicLinkOnDirectory),
        ("testIsSymbolicLinkOnFile", testIsSymbolicLinkOnFile),
        ("testIsSymbolicLinkOnGoodDirectorySymbol", testIsSymbolicLinkOnGoodDirectorySymbol),
        ("testIsSymbolicLinkOnGoodFileSymbol", testIsSymbolicLinkOnGoodFileSymbol),
        ("testIsSymbolicLinkOnNonExistingPath", testIsSymbolicLinkOnNonExistingPath),
        ("testPathRepresentableIsSymbolicLinkOnBadSymbol", testPathRepresentableIsSymbolicLinkOnBadSymbol),
        ("testPathRepresentableIsSymbolicLinkOnDirectory", testPathRepresentableIsSymbolicLinkOnDirectory),
        ("testPathRepresentableIsSymbolicLinkOnFile", testPathRepresentableIsSymbolicLinkOnFile),
        ("testPathRepresentableIsSymbolicLinkOnGoodDirectorySymbol", testPathRepresentableIsSymbolicLinkOnGoodDirectorySymbol),
        ("testPathRepresentableIsSymbolicLinkOnGoodFileSymbol", testPathRepresentableIsSymbolicLinkOnGoodFileSymbol),
        ("testPathRepresentableIsSymbolicLinkOnNonExistingPath", testPathRepresentableIsSymbolicLinkOnNonExistingPath),
    ]
}

extension JoinPathTests {
    static let __allTests = [
        ("testJoiningWithAbsolutePath", testJoiningWithAbsolutePath),
        ("testMultipleJoining", testMultipleJoining),
        ("testMultipleJoiningWithTrailingSeparators", testMultipleJoiningWithTrailingSeparators),
        ("testPathRepresentableJoiningWithAbsolutePath", testPathRepresentableJoiningWithAbsolutePath),
        ("testPathRepresentableMultipleJoining", testPathRepresentableMultipleJoining),
        ("testPathRepresentableMultipleJoiningWithTrailingSeparators", testPathRepresentableMultipleJoiningWithTrailingSeparators),
        ("testPathRepresentableSimpleSingleJoining", testPathRepresentableSimpleSingleJoining),
        ("testSimpleSingleJoining", testSimpleSingleJoining),
    ]
}

extension MakeAbsoluteTests {
    static let __allTests = [
        ("testMakeAbsolutePath", testMakeAbsolutePath),
        ("testPathRepresentableMakeAbsolutePath", testPathRepresentableMakeAbsolutePath),
    ]
}

extension NormalizePathTests {
    static let __allTests = [
        ("testAssertEmptyPathBecomesCurrent", testAssertEmptyPathBecomesCurrent),
        ("testConanicalizePath", testConanicalizePath),
        ("testPathRepresentableConanicalizePath", testPathRepresentableConanicalizePath),
        ("testPathRepresentableEmptyPathBecomesCurrent", testPathRepresentableEmptyPathBecomesCurrent),
        ("testPathRepresentableSlashPrefixes", testPathRepresentableSlashPrefixes),
        ("testSlashPrefixes", testSlashPrefixes),
    ]
}

extension PathBaseNameTests {
    static let __allTests = [
        ("testBaseNameOfPath", testBaseNameOfPath),
        ("testPathRepresentableBaseNameOfPath", testPathRepresentableBaseNameOfPath),
    ]
}

extension PathDirectoryTests {
    static let __allTests = [
        ("testPathDirectory", testPathDirectory),
        ("testPathRepresentableDirectory", testPathRepresentableDirectory),
    ]
}

extension PathTests {
    static let __allTests = [
        ("testPathValueDoesNotChange", testPathValueDoesNotChange),
    ]
}

extension ReadingTests {
    static let __allTests = [
        ("testPathRepresentableReadBytes", testPathRepresentableReadBytes),
        ("testPathRepresentableReadString", testPathRepresentableReadString),
        ("testPathRepresentableReadStringFromDirectory", testPathRepresentableReadStringFromDirectory),
        ("testPathRepresentableReadStringFromNoWhere", testPathRepresentableReadStringFromNoWhere),
        ("testPathRepresentableReadSymbolicLink", testPathRepresentableReadSymbolicLink),
        ("testReadBytes", testReadBytes),
        ("testReadString", testReadString),
        ("testReadStringFromDirectory", testReadStringFromDirectory),
        ("testReadStringFromNoWhere", testReadStringFromNoWhere),
        ("testReadSymbolicLink", testReadSymbolicLink),
    ]
}

extension SameFileTests {
    static let __allTests = [
        ("testNotSameFile", testNotSameFile),
        ("testPathRepresentableNotSameFile", testPathRepresentableNotSameFile),
        ("testPathRepresentableSameFileAsSymbolicLink", testPathRepresentableSameFileAsSymbolicLink),
        ("testSameFileAsSymbolicLink", testSameFileAsSymbolicLink),
    ]
}

extension SizeTests {
    static let __allTests = [
        ("testPathRepresentableSizeOfDirectory", testPathRepresentableSizeOfDirectory),
        ("testPathRepresentableSizeOfNonExistingPath", testPathRepresentableSizeOfNonExistingPath),
        ("testPathRepresentableSizeOfRegularFile", testPathRepresentableSizeOfRegularFile),
        ("testPathRepresentableSizeOfSymbolToDirectory", testPathRepresentableSizeOfSymbolToDirectory),
        ("testPathRepresentableSizeOfSymbolToRegularFile", testPathRepresentableSizeOfSymbolToRegularFile),
        ("testSizeOfDirectory", testSizeOfDirectory),
        ("testSizeOfNonExistingPath", testSizeOfNonExistingPath),
        ("testSizeOfRegularFile", testSizeOfRegularFile),
        ("testSizeOfSymbolToDirectory", testSizeOfSymbolToDirectory),
        ("testSizeOfSymbolToRegularFile", testSizeOfSymbolToRegularFile),
    ]
}

extension SplitExtensionTests {
    static let __allTests = [
        ("testPathRepresentableSplitExtensionOnEmptyPath", testPathRepresentableSplitExtensionOnEmptyPath),
        ("testPathRepresentableSplitExtensionOnPathWithLeadingDot", testPathRepresentableSplitExtensionOnPathWithLeadingDot),
        ("testPathRepresentableSplitExtensionOnPathWithLeadingDotButNoExtension", testPathRepresentableSplitExtensionOnPathWithLeadingDotButNoExtension),
        ("testPathRepresentableSplitExtensionOnPathWithLeadingDots", testPathRepresentableSplitExtensionOnPathWithLeadingDots),
        ("testPathRepresentableSplitExtensionOnPathWithLeadingDotsButNoExtension", testPathRepresentableSplitExtensionOnPathWithLeadingDotsButNoExtension),
        ("testPathRepresentableSplitExtensionOnPathWithManyLeadingDotsButNoExtension", testPathRepresentableSplitExtensionOnPathWithManyLeadingDotsButNoExtension),
        ("testPathRepresentableSplitExtensionOnPathWithMultipleDots", testPathRepresentableSplitExtensionOnPathWithMultipleDots),
        ("testPathRepresentableSplitExtensionOnPathWithNoDots", testPathRepresentableSplitExtensionOnPathWithNoDots),
        ("testPathRepresentableSplitExtensionOnPathWithOnlyDots", testPathRepresentableSplitExtensionOnPathWithOnlyDots),
        ("testPathRepresentableSplitExtensionOnSimplePath", testPathRepresentableSplitExtensionOnSimplePath),
        ("testSplitExtensionOnEmptyPath", testSplitExtensionOnEmptyPath),
        ("testSplitExtensionOnPathWithLeadingDot", testSplitExtensionOnPathWithLeadingDot),
        ("testSplitExtensionOnPathWithLeadingDotButNoExtension", testSplitExtensionOnPathWithLeadingDotButNoExtension),
        ("testSplitExtensionOnPathWithLeadingDots", testSplitExtensionOnPathWithLeadingDots),
        ("testSplitExtensionOnPathWithLeadingDotsButNoExtension", testSplitExtensionOnPathWithLeadingDotsButNoExtension),
        ("testSplitExtensionOnPathWithManyLeadingDotsButNoExtension", testSplitExtensionOnPathWithManyLeadingDotsButNoExtension),
        ("testSplitExtensionOnPathWithMultipleDots", testSplitExtensionOnPathWithMultipleDots),
        ("testSplitExtensionOnPathWithNoDots", testSplitExtensionOnPathWithNoDots),
        ("testSplitExtensionOnPathWithOnlyDots", testSplitExtensionOnPathWithOnlyDots),
        ("testSplitExtensionOnSimplePath", testSplitExtensionOnSimplePath),
    ]
}

extension SplitPathTests {
    static let __allTests = [
        ("testPathRepresentableSplitRootPath", testPathRepresentableSplitRootPath),
        ("testPathRepresentableSplitSimplePath", testPathRepresentableSplitSimplePath),
        ("testPathRepresentableSplitSingleCompomentPath", testPathRepresentableSplitSingleCompomentPath),
        ("testPathRepresentableSplitWithABunchOfPrefixSlashes", testPathRepresentableSplitWithABunchOfPrefixSlashes),
        ("testPathRepresentableSplitWithRedundantSeparator", testPathRepresentableSplitWithRedundantSeparator),
        ("testSplitRootPath", testSplitRootPath),
        ("testSplitSimplePath", testSplitSimplePath),
        ("testSplitSingleCompomentPath", testSplitSingleCompomentPath),
        ("testSplitWithABunchOfPrefixSlashes", testSplitWithABunchOfPrefixSlashes),
        ("testSplitWithRedundantSeparator", testSplitWithRedundantSeparator),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ChildrenTests.__allTests),
        testCase(ExistsTests.__allTests),
        testCase(ExpandUserDirectoryTests.__allTests),
        testCase(FileExtensionTests.__allTests),
        testCase(IsAbsoluteTests.__allTests),
        testCase(IsBlockDeviceTests.__allTests),
        testCase(IsCharacterDeviceTests.__allTests),
        testCase(IsDirectoryTests.__allTests),
        testCase(IsFileTests.__allTests),
        testCase(IsPipeTests.__allTests),
        testCase(IsSocketTests.__allTests),
        testCase(IsSymbolicLinkTests.__allTests),
        testCase(JoinPathTests.__allTests),
        testCase(MakeAbsoluteTests.__allTests),
        testCase(NormalizePathTests.__allTests),
        testCase(PathBaseNameTests.__allTests),
        testCase(PathDirectoryTests.__allTests),
        testCase(PathTests.__allTests),
        testCase(ReadingTests.__allTests),
        testCase(SameFileTests.__allTests),
        testCase(SizeTests.__allTests),
        testCase(SplitExtensionTests.__allTests),
        testCase(SplitPathTests.__allTests),
    ]
}
#endif
