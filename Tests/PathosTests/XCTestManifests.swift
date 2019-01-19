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
        ("testRelativeDirectoryRecursive", testRelativeDirectoryRecursive),
        ("testSocketsInPath", testSocketsInPath),
        ("testSocketsRecursiveInPath", testSocketsRecursiveInPath),
        ("testSymbolicLinksInPath", testSymbolicLinksInPath),
        ("testSymbolicLinksRecursiveInPath", testSymbolicLinksRecursiveInPath),
        ("testUnknownTypeFilesInPath", testUnknownTypeFilesInPath),
        ("testUnknownTypeFilesRecursiveInPath", testUnknownTypeFilesRecursiveInPath),
    ]
}

extension CommonPathTests {
    static let __allTests = [
        ("testAbsolutePath", testAbsolutePath),
        ("testAbsolutePathWithCurrentDirectorySegements", testAbsolutePathWithCurrentDirectorySegements),
        ("testAbsolutePathWithMixedExtraStartingSeparator", testAbsolutePathWithMixedExtraStartingSeparator),
        ("testAbsolutePathWithMixedTrailingSeparator", testAbsolutePathWithMixedTrailingSeparator),
        ("testAbsolutePathWithoutTrailingSeparator", testAbsolutePathWithoutTrailingSeparator),
        ("testAbsolutePathWithTrailingSeparator", testAbsolutePathWithTrailingSeparator),
        ("testMixedTrailingSeparatorInMixedOrders", testMixedTrailingSeparatorInMixedOrders),
        ("testMixingAbsoluteAndRelativePaths", testMixingAbsoluteAndRelativePaths),
        ("testPathRepresentableAbsolutePath", testPathRepresentableAbsolutePath),
        ("testPathRepresentableAbsolutePathWithCurrentDirectorySegements", testPathRepresentableAbsolutePathWithCurrentDirectorySegements),
        ("testPathRepresentableAbsolutePathWithMixedExtraStartingSeparator", testPathRepresentableAbsolutePathWithMixedExtraStartingSeparator),
        ("testPathRepresentableAbsolutePathWithMixedTrailingSeparator", testPathRepresentableAbsolutePathWithMixedTrailingSeparator),
        ("testPathRepresentableAbsolutePathWithoutTrailingSeparator", testPathRepresentableAbsolutePathWithoutTrailingSeparator),
        ("testPathRepresentableAbsolutePathWithTrailingSeparator", testPathRepresentableAbsolutePathWithTrailingSeparator),
        ("testPathRepresentableMixedTrailingSeparatorInMixedOrders", testPathRepresentableMixedTrailingSeparatorInMixedOrders),
        ("testPathRepresentableMixingAbsoluteAndRelativePaths", testPathRepresentableMixingAbsoluteAndRelativePaths),
        ("testPathRepresentableRelativePath", testPathRepresentableRelativePath),
        ("testPathRepresentableRelativePathWithExtraSeparators", testPathRepresentableRelativePathWithExtraSeparators),
        ("testPathRepresentableSegmentWithCommonPrefix", testPathRepresentableSegmentWithCommonPrefix),
        ("testRelativePath", testRelativePath),
        ("testRelativePathWithExtraSeparators", testRelativePathWithExtraSeparators),
        ("testSegmentWithCommonPrefix", testSegmentWithCommonPrefix),
    ]
}

extension DefaultTemporaryDirectorySearchingTests {
    static let __allTests = [
        ("testPathRepresentableSearchingTemporaryDirectoryFromTEMP", testPathRepresentableSearchingTemporaryDirectoryFromTEMP),
        ("testPathRepresentableSearchingTemporaryDirectoryFromTMP", testPathRepresentableSearchingTemporaryDirectoryFromTMP),
        ("testPathRepresentableSearchingTemporaryDirectoryFromTMPDIR", testPathRepresentableSearchingTemporaryDirectoryFromTMPDIR),
        ("testSearchingTemporaryDirectoryFromTEMP", testSearchingTemporaryDirectoryFromTEMP),
        ("testSearchingTemporaryDirectoryFromTMP", testSearchingTemporaryDirectoryFromTMP),
        ("testSearchingTemporaryDirectoryFromTMPDIR", testSearchingTemporaryDirectoryFromTMPDIR),
    ]
}

extension DefaultTemporaryDirectoryTests {
    static let __allTests = [
        ("testDefaultsTemporaryDirectory", testDefaultsTemporaryDirectory),
        ("testPathRepresentableDefaultsTemporaryDirectory", testPathRepresentableDefaultsTemporaryDirectory),
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
        ("testPathRepresentableGoodSymbolicDirectoryLink", testPathRepresentableGoodSymbolicDirectoryLink),
        ("testPathRepresentableGoodSymbolicDirectoryLinkFollowingSymbol", testPathRepresentableGoodSymbolicDirectoryLinkFollowingSymbol),
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

extension GlobTests {
    static let __allTests = [
        ("testGlobWithoutResult", testGlobWithoutResult),
        ("testGlobWithRecursivePattern", testGlobWithRecursivePattern),
        ("testGlobWithResult", testGlobWithResult),
        ("testPathRepresentableGlobWithoutResult", testPathRepresentableGlobWithoutResult),
        ("testPathRepresentableGlobWithRecursivePattern", testPathRepresentableGlobWithRecursivePattern),
        ("testPathRepresentableGlobWithResult", testPathRepresentableGlobWithResult),
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
        ("testPathRepresentableIsBlockDeviceOnBadSymbolicLink", testPathRepresentableIsBlockDeviceOnBadSymbolicLink),
        ("testPathRepresentableIsBlockDeviceOnSymbolicDirectoryLink", testPathRepresentableIsBlockDeviceOnSymbolicDirectoryLink),
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
        ("testPathRepresentableIsCharacterDeviceOnBadSymbolicLink", testPathRepresentableIsCharacterDeviceOnBadSymbolicLink),
        ("testPathRepresentableIsCharacterDeviceOnSymbolicDirectoryLink", testPathRepresentableIsCharacterDeviceOnSymbolicDirectoryLink),
        ("testPathRepresentableIsCharacterDeviceOnSymbolicLink", testPathRepresentableIsCharacterDeviceOnSymbolicLink),
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
        ("testPathRepresentableIsPipeOnBadSymbolicLink", testPathRepresentableIsPipeOnBadSymbolicLink),
        ("testPathRepresentableIsPipeOnSymbolicDirectoryLink", testPathRepresentableIsPipeOnSymbolicDirectoryLink),
        ("testPathRepresentableIsPipeOnSymbolicLink", testPathRepresentableIsPipeOnSymbolicLink),
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
        ("testPathRepresentableIsSocketOnBadSymbolicLink", testPathRepresentableIsSocketOnBadSymbolicLink),
        ("testPathRepresentableIsSocketOnSymbolicDirectoryLink", testPathRepresentableIsSocketOnSymbolicDirectoryLink),
        ("testPathRepresentableIsSocketOnSymbolicLink", testPathRepresentableIsSocketOnSymbolicLink),
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
        ("testJoiningNothing", testJoiningNothing),
        ("testJoiningWithAbsolutePath", testJoiningWithAbsolutePath),
        ("testMultipleJoining", testMultipleJoining),
        ("testMultipleJoiningWithTrailingSeparators", testMultipleJoiningWithTrailingSeparators),
        ("testPathRepresentableJoiningWithAbsolutePath", testPathRepresentableJoiningWithAbsolutePath),
        ("testPathRepresentableJoiningWithNothing", testPathRepresentableJoiningWithNothing),
        ("testPathRepresentableMultipleJoining", testPathRepresentableMultipleJoining),
        ("testPathRepresentableMultipleJoiningWithTrailingSeparators", testPathRepresentableMultipleJoiningWithTrailingSeparators),
        ("testPathRepresentableSimpleSingleJoining", testPathRepresentableSimpleSingleJoining),
        ("testSimpleSingleJoinings", testSimpleSingleJoinings),
    ]
}

extension MakeAbsoluteTests {
    static let __allTests = [
        ("testMakeAbsolutePath", testMakeAbsolutePath),
        ("testPathRepresentableMakeAbsolutePath", testPathRepresentableMakeAbsolutePath),
    ]
}

extension MakeDirectoryTests {
    static let __allTests = [
        ("testMakeDirectory", testMakeDirectory),
        ("testMakeDirectoryWithCreateParent", testMakeDirectoryWithCreateParent),
        ("testMakeDirectoryWithNonExistParentShouldFail", testMakeDirectoryWithNonExistParentShouldFail),
        ("testMakeDirectoryWithSpecificPermission", testMakeDirectoryWithSpecificPermission),
        ("testMakeExistingDirectory", testMakeExistingDirectory),
        ("testMakeExistingDirectoryExistOkay", testMakeExistingDirectoryExistOkay),
        ("testPathRepresentableMakeDirectoryWithCreateParent", testPathRepresentableMakeDirectoryWithCreateParent),
        ("testPathRepresentableMakeDirectoryWithNonExistParentShouldFail", testPathRepresentableMakeDirectoryWithNonExistParentShouldFail),
        ("testPathRepresentableMakeDirectoryWithSpecificPermission", testPathRepresentableMakeDirectoryWithSpecificPermission),
        ("testPathRepresentableMakeDiroctory", testPathRepresentableMakeDiroctory),
        ("testPathRepresentableMakeExistingDirectory", testPathRepresentableMakeExistingDirectory),
        ("testPathRepresentableMakeExistingDirectoryExistOkay", testPathRepresentableMakeExistingDirectoryExistOkay),
    ]
}

extension MakeSymbolicLinkTests {
    static let __allTests = [
        ("testMakingSymbolicLink", testMakingSymbolicLink),
        ("testPathRepresentableMakingSymbolicLink", testPathRepresentableMakingSymbolicLink),
    ]
}

extension NormalizePathTests {
    static let __allTests = [
        ("testAssertEmptyPathBecomesCurrent", testAssertEmptyPathBecomesCurrent),
        ("testCanonicalizePath", testCanonicalizePath),
        ("testPathRepresentableCanonicalizePath", testPathRepresentableCanonicalizePath),
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

extension RealPathTests {
    static let __allTests = [
        ("testEmpty", testEmpty),
        ("testIntermediatSymbols", testIntermediatSymbols),
        ("testPathRepresentableEmpty", testPathRepresentableEmpty),
        ("testPathRepresentableIntermediatSymbols", testPathRepresentableIntermediatSymbols),
        ("testPathRepresentablePathThatDoesNotExist", testPathRepresentablePathThatDoesNotExist),
        ("testPathRepresentableRoot", testPathRepresentableRoot),
        ("testPathRepresentableTerminalSymbolIsResolved", testPathRepresentableTerminalSymbolIsResolved),
        ("testPathThatDoesNotExist", testPathThatDoesNotExist),
        ("testRoot", testRoot),
        ("testTerminalSymbolIsResolved", testTerminalSymbolIsResolved),
    ]
}

extension RelativePathInferringCurrentDirectoryTests {
    static let __allTests = [
        ("testAbsoluteChild", testAbsoluteChild),
        ("testAbsoluteParent", testAbsoluteParent),
        ("testPathRepresentableAbsoluteChild", testPathRepresentableAbsoluteChild),
        ("testPathRepresentableAbsoluteParent", testPathRepresentableAbsoluteParent),
        ("testPathRepresentableRelativeChild", testPathRepresentableRelativeChild),
        ("testPathRepresentableRelativeParent", testPathRepresentableRelativeParent),
        ("testRelativeChild", testRelativeChild),
        ("testRelativeParent", testRelativeParent),
    ]
}

extension RelativePathTests {
    static let __allTests = [
        ("testAbsoluteChild", testAbsoluteChild),
        ("testAbsoluteParent", testAbsoluteParent),
        ("testAbsoluteRoot", testAbsoluteRoot),
        ("testAbsoluteSiblings", testAbsoluteSiblings),
        ("testPathRepresentableAbsoluteChild", testPathRepresentableAbsoluteChild),
        ("testPathRepresentableAbsoluteParent", testPathRepresentableAbsoluteParent),
        ("testPathRepresentableAbsoluteRoot", testPathRepresentableAbsoluteRoot),
        ("testPathRepresentableAbsoluteSiblings", testPathRepresentableAbsoluteSiblings),
        ("testPathRepresentableRelativeParentSibling", testPathRepresentableRelativeParentSibling),
        ("testPathRepresentableRelativeSelf", testPathRepresentableRelativeSelf),
        ("testRelativeParentSibling", testRelativeParentSibling),
        ("testRelativeSelf", testRelativeSelf),
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
        ("testPathRepresentableSplitSingleComponentPath", testPathRepresentableSplitSingleComponentPath),
        ("testPathRepresentableSplitWithABunchOfPrefixSlashes", testPathRepresentableSplitWithABunchOfPrefixSlashes),
        ("testPathRepresentableSplitWithRedundantSeparator", testPathRepresentableSplitWithRedundantSeparator),
        ("testSplitRootPath", testSplitRootPath),
        ("testSplitSimplePath", testSplitSimplePath),
        ("testSplitSingleCompomentPath", testSplitSingleCompomentPath),
        ("testSplitWithABunchOfPrefixSlashes", testSplitWithABunchOfPrefixSlashes),
        ("testSplitWithRedundantSeparator", testSplitWithRedundantSeparator),
    ]
}

extension TimeTests {
    static let __allTests = [
        ("testAccessTime", testAccessTime),
        ("testMetadataChangeTime", testMetadataChangeTime),
        ("testModificationTime", testModificationTime),
        ("testPathRepresentableAccessTime", testPathRepresentableAccessTime),
        ("testPathRepresentableMetadataChangeTime", testPathRepresentableMetadataChangeTime),
        ("testPathRepresentableModificationTime", testPathRepresentableModificationTime),
    ]
}

extension WritingTests {
    static let __allTests = [
        ("testBytesToExistingFile", testBytesToExistingFile),
        ("testBytesToNewFile", testBytesToNewFile),
        ("testBytesToUnwantedNewFile", testBytesToUnwantedNewFile),
        ("testPathRepresentableBytesToExistingFile", testPathRepresentableBytesToExistingFile),
        ("testPathRepresentableBytesToNewFile", testPathRepresentableBytesToNewFile),
        ("testPathRepresentableBytesToUnwantedNewFile", testPathRepresentableBytesToUnwantedNewFile),
        ("testPathRepresentableStringToExistingFile", testPathRepresentableStringToExistingFile),
        ("testPathRepresentableStringToNewFile", testPathRepresentableStringToNewFile),
        ("testPathRepresentableStringToUnwantedNewFile", testPathRepresentableStringToUnwantedNewFile),
        ("testStringToExistingFile", testStringToExistingFile),
        ("testStringToNewFile", testStringToNewFile),
        ("testStringToUnwantedNewFile", testStringToUnwantedNewFile),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ChildrenTests.__allTests),
        testCase(CommonPathTests.__allTests),
        testCase(DefaultTemporaryDirectorySearchingTests.__allTests),
        testCase(DefaultTemporaryDirectoryTests.__allTests),
        testCase(ExistsTests.__allTests),
        testCase(ExpandUserDirectoryTests.__allTests),
        testCase(FileExtensionTests.__allTests),
        testCase(GlobTests.__allTests),
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
        testCase(MakeDirectoryTests.__allTests),
        testCase(MakeSymbolicLinkTests.__allTests),
        testCase(NormalizePathTests.__allTests),
        testCase(PathBaseNameTests.__allTests),
        testCase(PathDirectoryTests.__allTests),
        testCase(PathTests.__allTests),
        testCase(ReadingTests.__allTests),
        testCase(RealPathTests.__allTests),
        testCase(RelativePathInferringCurrentDirectoryTests.__allTests),
        testCase(RelativePathTests.__allTests),
        testCase(SameFileTests.__allTests),
        testCase(SizeTests.__allTests),
        testCase(SplitExtensionTests.__allTests),
        testCase(SplitPathTests.__allTests),
        testCase(TimeTests.__allTests),
        testCase(WritingTests.__allTests),
    ]
}
#endif
