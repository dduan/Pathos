// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import PathosTests

extension ChildrenTests {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testChildrenInPath", ChildrenTests.testChildrenInPath),
            ("testChildrenRecursiveInPath", ChildrenTests.testChildrenRecursiveInPath),
            ("testFilesInPath", ChildrenTests.testFilesInPath),
            ("testFilesRecursiveInPath", ChildrenTests.testFilesRecursiveInPath),
            ("testDirectoriesInPath", ChildrenTests.testDirectoriesInPath),
            ("testDirectoriesRecursiveInPath", ChildrenTests.testDirectoriesRecursiveInPath),
            ("testSymbolicLinksInPath", ChildrenTests.testSymbolicLinksInPath),
            ("testSymbolicLinksRecursiveInPath", ChildrenTests.testSymbolicLinksRecursiveInPath),
            ("testPathRepresentableChildrenInPath", ChildrenTests.testPathRepresentableChildrenInPath),
            ("testPathRepresentableChildrenRecursiveInPath", ChildrenTests.testPathRepresentableChildrenRecursiveInPath),
            ("testPathRepresentableFilesInPath", ChildrenTests.testPathRepresentableFilesInPath),
            ("testPathRepresentableFilesRecursiveInPath", ChildrenTests.testPathRepresentableFilesRecursiveInPath),
            ("testPathRepresentableDirectoriesInPath", ChildrenTests.testPathRepresentableDirectoriesInPath),
            ("testPathRepresentableDirectoriesRecursiveInPath", ChildrenTests.testPathRepresentableDirectoriesRecursiveInPath),
            ("testPathRepresentableSymbolicLinksInPath", ChildrenTests.testPathRepresentableSymbolicLinksInPath),
            ("testPathRepresentableSymbolicLinksRecursiveInPath", ChildrenTests.testPathRepresentableSymbolicLinksRecursiveInPath),
            ("testUnknownTypeFilesInPath", ChildrenTests.testUnknownTypeFilesInPath),
            ("testUnknownTypeFilesRecursiveInPath", ChildrenTests.testUnknownTypeFilesRecursiveInPath),
            ("testPathRepresentableUnknownTypeFilesInPath", ChildrenTests.testPathRepresentableUnknownTypeFilesInPath),
            ("testPathRepresentableUnknownTypeFilesRecursiveInPath", ChildrenTests.testPathRepresentableUnknownTypeFilesRecursiveInPath),
            ("testPipesInPath", ChildrenTests.testPipesInPath),
            ("testPipesRecursiveInPath", ChildrenTests.testPipesRecursiveInPath),
            ("testPathRepresentablePipesInPath", ChildrenTests.testPathRepresentablePipesInPath),
            ("testPathRepresentablePipesRecursiveInPath", ChildrenTests.testPathRepresentablePipesRecursiveInPath),
            ("testCharacterDevicesInPath", ChildrenTests.testCharacterDevicesInPath),
            ("testCharacterDevicesRecursiveInPath", ChildrenTests.testCharacterDevicesRecursiveInPath),
            ("testPathRepresentableCharacterDevicesInPath", ChildrenTests.testPathRepresentableCharacterDevicesInPath),
            ("testPathRepresentableCharacterDevicesRecursiveInPath", ChildrenTests.testPathRepresentableCharacterDevicesRecursiveInPath),
            ("testBlockDevicesInPath", ChildrenTests.testBlockDevicesInPath),
            ("testBlockDevicesRecursiveInPath", ChildrenTests.testBlockDevicesRecursiveInPath),
            ("testPathRepresentableBlockDevicesInPath", ChildrenTests.testPathRepresentableBlockDevicesInPath),
            ("testPathRepresentableBlockDevicesRecursiveInPath", ChildrenTests.testPathRepresentableBlockDevicesRecursiveInPath),
            ("testSocketsInPath", ChildrenTests.testSocketsInPath),
            ("testSocketsRecursiveInPath", ChildrenTests.testSocketsRecursiveInPath),
            ("testPathRepresentableSocketsInPath", ChildrenTests.testPathRepresentableSocketsInPath),
            ("testPathRepresentableSocketsRecursiveInPath", ChildrenTests.testPathRepresentableSocketsRecursiveInPath),
        ]
    }
}
extension ExistsTest {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testExistingFiles", ExistsTest.testExistingFiles),
            ("testNonExistingFiles", ExistsTest.testNonExistingFiles),
            ("testExistingFilesFollowingSymbol", ExistsTest.testExistingFilesFollowingSymbol),
            ("testExistingFilesNotFollowingSymbol", ExistsTest.testExistingFilesNotFollowingSymbol),
            ("testGoodSymbolicLink", ExistsTest.testGoodSymbolicLink),
            ("testGoodSymbolicDirectoryLink", ExistsTest.testGoodSymbolicDirectoryLink),
            ("testBadSymbolicLink", ExistsTest.testBadSymbolicLink),
            ("testGoodSymbolicLinkFollowingSymbol", ExistsTest.testGoodSymbolicLinkFollowingSymbol),
            ("testGoodSymbolicDirectoryLinkFollowingSymbol", ExistsTest.testGoodSymbolicDirectoryLinkFollowingSymbol),
            ("testBadSymbolicLinkFollowingSymbol", ExistsTest.testBadSymbolicLinkFollowingSymbol),
            ("testGoodSymbolicLinkNotFollowingSymbol", ExistsTest.testGoodSymbolicLinkNotFollowingSymbol),
            ("testGoodSymbolicDirectoryLinkNotFollowingSymbol", ExistsTest.testGoodSymbolicDirectoryLinkNotFollowingSymbol),
            ("testBadSymbolicLinkNotFollowingSymbol", ExistsTest.testBadSymbolicLinkNotFollowingSymbol),
            ("testPathRepresentableExistingFiles", ExistsTest.testPathRepresentableExistingFiles),
            ("testPathRepresentableNonExistingFiles", ExistsTest.testPathRepresentableNonExistingFiles),
            ("testPathRepresentableExistingFileFollowingSymbol", ExistsTest.testPathRepresentableExistingFileFollowingSymbol),
            ("testPathRepresentableExistingFileNotFollowingSymbol", ExistsTest.testPathRepresentableExistingFileNotFollowingSymbol),
            ("testPathRepresentableGoodSymbolicLink", ExistsTest.testPathRepresentableGoodSymbolicLink),
            ("testPathRepresentableGoodSymbolicDirectoryLink", ExistsTest.testPathRepresentableGoodSymbolicDirectoryLink),
            ("testPathRepresentableBadSymbolicLink", ExistsTest.testPathRepresentableBadSymbolicLink),
            ("testPathRepresentableGoodSymbolicLinkFollowingSymbol", ExistsTest.testPathRepresentableGoodSymbolicLinkFollowingSymbol),
            ("testPathRepresentableGoodSymbolicDirectorcyLinkFollowingSymbol", ExistsTest.testPathRepresentableGoodSymbolicDirectorcyLinkFollowingSymbol),
            ("testPathRepresentableBadSymbolicLinkFollowingSymbol", ExistsTest.testPathRepresentableBadSymbolicLinkFollowingSymbol),
            ("testPathRepresentableGoodSymbolicLinkNotFollowingSymbol", ExistsTest.testPathRepresentableGoodSymbolicLinkNotFollowingSymbol),
            ("testPathRepresentableGoodDirectorySymbolicLinkNotFollowingSymbol", ExistsTest.testPathRepresentableGoodDirectorySymbolicLinkNotFollowingSymbol),
            ("testPathRepresentableBadSymbolicLinkNotFollowingSymbol", ExistsTest.testPathRepresentableBadSymbolicLinkNotFollowingSymbol),
        ]
    }
}
extension ExpandUserDirectoryTests {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testExpandPathWithNoUser", ExpandUserDirectoryTests.testExpandPathWithNoUser),
            ("testUserDirectoryExpandsToHomeEnvironment", ExpandUserDirectoryTests.testUserDirectoryExpandsToHomeEnvironment),
            ("testSpecialHomeValue", ExpandUserDirectoryTests.testSpecialHomeValue),
            ("testFallbackToPasswdDatabase", ExpandUserDirectoryTests.testFallbackToPasswdDatabase),
            ("testPathRepresentableExpandPathWithNoUser", ExpandUserDirectoryTests.testPathRepresentableExpandPathWithNoUser),
            ("testPathRepresentableUserDirectoryExpandsToHomeEnvironment", ExpandUserDirectoryTests.testPathRepresentableUserDirectoryExpandsToHomeEnvironment),
            ("testPathRepresentableSpecialHomeValue", ExpandUserDirectoryTests.testPathRepresentableSpecialHomeValue),
            ("testPathRepresentableFallbackToPasswdDatabase", ExpandUserDirectoryTests.testPathRepresentableFallbackToPasswdDatabase),
        ]
    }
}
extension FileExtensionTests {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testFileExtensionOnSimplePath", FileExtensionTests.testFileExtensionOnSimplePath),
            ("testFileExtensionOnPathWithMultipleDots", FileExtensionTests.testFileExtensionOnPathWithMultipleDots),
            ("testFileExtensionOnPathWithLeadingDot", FileExtensionTests.testFileExtensionOnPathWithLeadingDot),
            ("testFileExtensionOnPathWithNoDots", FileExtensionTests.testFileExtensionOnPathWithNoDots),
            ("testFileExtensionOnPathWithLeadingDotButNoExtension", FileExtensionTests.testFileExtensionOnPathWithLeadingDotButNoExtension),
            ("testFileExtensionOnPathWithManyLeadingDotsButNoExtension", FileExtensionTests.testFileExtensionOnPathWithManyLeadingDotsButNoExtension),
            ("testFileExtensionOnPathWithLeadingDotsButNoExtension", FileExtensionTests.testFileExtensionOnPathWithLeadingDotsButNoExtension),
            ("testFileExtensionOnPathWithLeadingDots", FileExtensionTests.testFileExtensionOnPathWithLeadingDots),
            ("testFileExtensionOnPathWithOnlyDots", FileExtensionTests.testFileExtensionOnPathWithOnlyDots),
            ("testFileExtensionOnEmptyPath", FileExtensionTests.testFileExtensionOnEmptyPath),
            ("testPathRepresentableFileExtensionOnSimplePath", FileExtensionTests.testPathRepresentableFileExtensionOnSimplePath),
            ("testPathRepresentableFileExtensionOnPathWithMultipleDots", FileExtensionTests.testPathRepresentableFileExtensionOnPathWithMultipleDots),
            ("testPathRepresentableFileExtensionOnPathWithLeadingDot", FileExtensionTests.testPathRepresentableFileExtensionOnPathWithLeadingDot),
            ("testPathRepresentableFileExtensionOnPathWithNoDots", FileExtensionTests.testPathRepresentableFileExtensionOnPathWithNoDots),
            ("testPathRepresentableFileExtensionOnPathWithLeadingDotButNoExtension", FileExtensionTests.testPathRepresentableFileExtensionOnPathWithLeadingDotButNoExtension),
            ("testPathRepresentableFileExtensionOnPathWithManyLeadingDotsButNoExtension", FileExtensionTests.testPathRepresentableFileExtensionOnPathWithManyLeadingDotsButNoExtension),
            ("testPathRepresentableFileExtensionOnPathWithLeadingDotsButNoExtension", FileExtensionTests.testPathRepresentableFileExtensionOnPathWithLeadingDotsButNoExtension),
            ("testPathRepresentableFileExtensionOnPathWithLeadingDots", FileExtensionTests.testPathRepresentableFileExtensionOnPathWithLeadingDots),
            ("testPathRepresentableFileExtensionOnPathWithOnlyDots", FileExtensionTests.testPathRepresentableFileExtensionOnPathWithOnlyDots),
            ("testPathRepresentableFileExtensionOnEmptyPath", FileExtensionTests.testPathRepresentableFileExtensionOnEmptyPath),
        ]
    }
}
extension FixtureTestCase {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
        ]
    }
}
extension IsAbsoluteTests {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testIsAbsolutePath", IsAbsoluteTests.testIsAbsolutePath),
            ("testPathRepresentableIsAbsolute", IsAbsoluteTests.testPathRepresentableIsAbsolute),
        ]
    }
}
extension IsBlockDeviceTests {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testIsBlockDeviceOnExistingFile", IsBlockDeviceTests.testIsBlockDeviceOnExistingFile),
            ("testIsBlockDeviceOnExistingDirectory", IsBlockDeviceTests.testIsBlockDeviceOnExistingDirectory),
            ("testIsBlockDeviceOnNonExistingPath", IsBlockDeviceTests.testIsBlockDeviceOnNonExistingPath),
            ("testIsBlockDeviceOnSymbolicLink", IsBlockDeviceTests.testIsBlockDeviceOnSymbolicLink),
            ("testIsBlockDeviceOnSymbolicDirectoryLink", IsBlockDeviceTests.testIsBlockDeviceOnSymbolicDirectoryLink),
            ("testIsBlockDeviceOnBadSymbolicLink", IsBlockDeviceTests.testIsBlockDeviceOnBadSymbolicLink),
            ("testFileRepresentableIsBlockDeviceOnExistingFile", IsBlockDeviceTests.testFileRepresentableIsBlockDeviceOnExistingFile),
            ("testFileRepresentableIsBlockDeviceOnExistingDirectory", IsBlockDeviceTests.testFileRepresentableIsBlockDeviceOnExistingDirectory),
            ("testFileRepresentableIsBlockDeviceOnNonExistingFile", IsBlockDeviceTests.testFileRepresentableIsBlockDeviceOnNonExistingFile),
            ("testPathRerpesentableIsBlockDeviceOnSymbolicLink", IsBlockDeviceTests.testPathRerpesentableIsBlockDeviceOnSymbolicLink),
            ("testPathRepresentableIsBlockDeviceOnSymbolicDirectoryLink", IsBlockDeviceTests.testPathRepresentableIsBlockDeviceOnSymbolicDirectoryLink),
            ("testPathRerpesentableIsBlockDeviceOnBadSymbolicLink", IsBlockDeviceTests.testPathRerpesentableIsBlockDeviceOnBadSymbolicLink),
        ]
    }
}
extension IsCharacterDeviceTests {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testIsCharacterDeviceOnExistingFile", IsCharacterDeviceTests.testIsCharacterDeviceOnExistingFile),
            ("testIsCharacterDeviceOnExistingDirectory", IsCharacterDeviceTests.testIsCharacterDeviceOnExistingDirectory),
            ("testIsCharacterDeviceOnNonExistingPath", IsCharacterDeviceTests.testIsCharacterDeviceOnNonExistingPath),
            ("testIsCharacterDeviceOnSymbolicLink", IsCharacterDeviceTests.testIsCharacterDeviceOnSymbolicLink),
            ("testIsCharacterDeviceOnSymbolicDirectoryLink", IsCharacterDeviceTests.testIsCharacterDeviceOnSymbolicDirectoryLink),
            ("testIsCharacterDeviceOnBadSymbolicLink", IsCharacterDeviceTests.testIsCharacterDeviceOnBadSymbolicLink),
            ("testFileRepresentableIsCharacterDeviceOnExistingFile", IsCharacterDeviceTests.testFileRepresentableIsCharacterDeviceOnExistingFile),
            ("testFileRepresentableIsCharacterDeviceOnExistingDirectory", IsCharacterDeviceTests.testFileRepresentableIsCharacterDeviceOnExistingDirectory),
            ("testFileRepresentableIsCharacterDeviceOnNonExistingFile", IsCharacterDeviceTests.testFileRepresentableIsCharacterDeviceOnNonExistingFile),
            ("testPathRerpesentableIsCharacterDeviceOnSymbolicLink", IsCharacterDeviceTests.testPathRerpesentableIsCharacterDeviceOnSymbolicLink),
            ("testPathRepresentableIsCharacterDeviceOnSymbolicDirectoryLink", IsCharacterDeviceTests.testPathRepresentableIsCharacterDeviceOnSymbolicDirectoryLink),
            ("testPathRerpesentableIsCharacterDeviceOnBadSymbolicLink", IsCharacterDeviceTests.testPathRerpesentableIsCharacterDeviceOnBadSymbolicLink),
        ]
    }
}
extension IsDirectoryTests {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testIsDirectoryOnExistingFile", IsDirectoryTests.testIsDirectoryOnExistingFile),
            ("testIsDirectoryOnExistingDirectory", IsDirectoryTests.testIsDirectoryOnExistingDirectory),
            ("testIsDirectoryOnNonExistingPath", IsDirectoryTests.testIsDirectoryOnNonExistingPath),
            ("testIsDirectoryOnSymbolicLink", IsDirectoryTests.testIsDirectoryOnSymbolicLink),
            ("testIsDirectoryOnSymbolicDirectoryLink", IsDirectoryTests.testIsDirectoryOnSymbolicDirectoryLink),
            ("testIsDirectoryOnBadSymbolicLink", IsDirectoryTests.testIsDirectoryOnBadSymbolicLink),
            ("testDirectoryRepresentableIsFileOnExistingFile", IsDirectoryTests.testDirectoryRepresentableIsFileOnExistingFile),
            ("testDirectoryRepresentableIsFileOnExistingDirectory", IsDirectoryTests.testDirectoryRepresentableIsFileOnExistingDirectory),
            ("testDirectoryRepresentableIsFileOnNonExistingFile", IsDirectoryTests.testDirectoryRepresentableIsFileOnNonExistingFile),
            ("testPathRepresentableIsDirectoryOnSymbolicLink", IsDirectoryTests.testPathRepresentableIsDirectoryOnSymbolicLink),
            ("testPathRepresentableIsDirectoryOnSymbolicDirectoryLink", IsDirectoryTests.testPathRepresentableIsDirectoryOnSymbolicDirectoryLink),
            ("testPathRepresentableIsDirectoryOnBadSymbolicLink", IsDirectoryTests.testPathRepresentableIsDirectoryOnBadSymbolicLink),
        ]
    }
}
extension IsFileTests {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testIsFileOnExistingFile", IsFileTests.testIsFileOnExistingFile),
            ("testIsFileOnExistingDirectory", IsFileTests.testIsFileOnExistingDirectory),
            ("testIsFileOnNonExistingPath", IsFileTests.testIsFileOnNonExistingPath),
            ("testIsFileOnSymbolicLink", IsFileTests.testIsFileOnSymbolicLink),
            ("testIsFileOnSymbolicDirectoryLink", IsFileTests.testIsFileOnSymbolicDirectoryLink),
            ("testIsFileOnBadSymbolicLink", IsFileTests.testIsFileOnBadSymbolicLink),
            ("testFileRepresentableIsFileOnExistingFile", IsFileTests.testFileRepresentableIsFileOnExistingFile),
            ("testFileRepresentableIsFileOnExistingDirectory", IsFileTests.testFileRepresentableIsFileOnExistingDirectory),
            ("testFileRepresentableIsFileOnNonExistingFile", IsFileTests.testFileRepresentableIsFileOnNonExistingFile),
            ("testPathRerpesentableIsFileOnSymbolicLink", IsFileTests.testPathRerpesentableIsFileOnSymbolicLink),
            ("testPathRepresentableIsFileOnSymbolicDirectoryLink", IsFileTests.testPathRepresentableIsFileOnSymbolicDirectoryLink),
            ("testPathRerpesentableIsFileOnBadSymbolicLink", IsFileTests.testPathRerpesentableIsFileOnBadSymbolicLink),
        ]
    }
}
extension IsPipeTests {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testIsPipeOnExistingFile", IsPipeTests.testIsPipeOnExistingFile),
            ("testIsPipeOnExistingDirectory", IsPipeTests.testIsPipeOnExistingDirectory),
            ("testIsPipeOnNonExistingPath", IsPipeTests.testIsPipeOnNonExistingPath),
            ("testIsPipeOnSymbolicLink", IsPipeTests.testIsPipeOnSymbolicLink),
            ("testIsPipeOnSymbolicDirectoryLink", IsPipeTests.testIsPipeOnSymbolicDirectoryLink),
            ("testIsPipeOnBadSymbolicLink", IsPipeTests.testIsPipeOnBadSymbolicLink),
            ("testFileRepresentableIsPipeOnExistingFile", IsPipeTests.testFileRepresentableIsPipeOnExistingFile),
            ("testFileRepresentableIsPipeOnExistingDirectory", IsPipeTests.testFileRepresentableIsPipeOnExistingDirectory),
            ("testFileRepresentableIsPipeOnNonExistingFile", IsPipeTests.testFileRepresentableIsPipeOnNonExistingFile),
            ("testPathRerpesentableIsPipeOnSymbolicLink", IsPipeTests.testPathRerpesentableIsPipeOnSymbolicLink),
            ("testPathRepresentableIsPipeOnSymbolicDirectoryLink", IsPipeTests.testPathRepresentableIsPipeOnSymbolicDirectoryLink),
            ("testPathRerpesentableIsPipeOnBadSymbolicLink", IsPipeTests.testPathRerpesentableIsPipeOnBadSymbolicLink),
        ]
    }
}
extension IsSocketTests {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testIsSocketOnExistingFile", IsSocketTests.testIsSocketOnExistingFile),
            ("testIsSocketOnExistingDirectory", IsSocketTests.testIsSocketOnExistingDirectory),
            ("testIsSocketOnNonExistingPath", IsSocketTests.testIsSocketOnNonExistingPath),
            ("testIsSocketOnSymbolicLink", IsSocketTests.testIsSocketOnSymbolicLink),
            ("testIsSocketOnSymbolicDirectoryLink", IsSocketTests.testIsSocketOnSymbolicDirectoryLink),
            ("testIsSocketOnBadSymbolicLink", IsSocketTests.testIsSocketOnBadSymbolicLink),
            ("testFileRepresentableIsSocketOnExistingFile", IsSocketTests.testFileRepresentableIsSocketOnExistingFile),
            ("testFileRepresentableIsSocketOnExistingDirectory", IsSocketTests.testFileRepresentableIsSocketOnExistingDirectory),
            ("testFileRepresentableIsSocketOnNonExistingFile", IsSocketTests.testFileRepresentableIsSocketOnNonExistingFile),
            ("testPathRerpesentableIsSocketOnSymbolicLink", IsSocketTests.testPathRerpesentableIsSocketOnSymbolicLink),
            ("testPathRepresentableIsSocketOnSymbolicDirectoryLink", IsSocketTests.testPathRepresentableIsSocketOnSymbolicDirectoryLink),
            ("testPathRerpesentableIsSocketOnBadSymbolicLink", IsSocketTests.testPathRerpesentableIsSocketOnBadSymbolicLink),
        ]
    }
}
extension IsSymbolicLinkTests {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testIsSymbolicLinkOnFile", IsSymbolicLinkTests.testIsSymbolicLinkOnFile),
            ("testIsSymbolicLinkOnDirectory", IsSymbolicLinkTests.testIsSymbolicLinkOnDirectory),
            ("testIsSymbolicLinkOnNonExistingPath", IsSymbolicLinkTests.testIsSymbolicLinkOnNonExistingPath),
            ("testIsSymbolicLinkOnGoodFileSymbol", IsSymbolicLinkTests.testIsSymbolicLinkOnGoodFileSymbol),
            ("testIsSymbolicLinkOnGoodDirectorySymbol", IsSymbolicLinkTests.testIsSymbolicLinkOnGoodDirectorySymbol),
            ("testIsSymbolicLinkOnBadSymbol", IsSymbolicLinkTests.testIsSymbolicLinkOnBadSymbol),
            ("testPathRepresentableIsSymbolicLinkOnFile", IsSymbolicLinkTests.testPathRepresentableIsSymbolicLinkOnFile),
            ("testPathRepresentableIsSymbolicLinkOnDirectory", IsSymbolicLinkTests.testPathRepresentableIsSymbolicLinkOnDirectory),
            ("testPathRepresentableIsSymbolicLinkOnNonExistingPath", IsSymbolicLinkTests.testPathRepresentableIsSymbolicLinkOnNonExistingPath),
            ("testPathRepresentableIsSymbolicLinkOnGoodFileSymbol", IsSymbolicLinkTests.testPathRepresentableIsSymbolicLinkOnGoodFileSymbol),
            ("testPathRepresentableIsSymbolicLinkOnGoodDirectorySymbol", IsSymbolicLinkTests.testPathRepresentableIsSymbolicLinkOnGoodDirectorySymbol),
            ("testPathRepresentableIsSymbolicLinkOnBadSymbol", IsSymbolicLinkTests.testPathRepresentableIsSymbolicLinkOnBadSymbol),
        ]
    }
}
extension JoinPathTests {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testSimpleSingleJoining", JoinPathTests.testSimpleSingleJoining),
            ("testMultipleJoining", JoinPathTests.testMultipleJoining),
            ("testMultipleJoiningWithTrailingSeparators", JoinPathTests.testMultipleJoiningWithTrailingSeparators),
            ("testJoiningWithAbsolutePath", JoinPathTests.testJoiningWithAbsolutePath),
            ("testPathRepresentableSimpleSingleJoining", JoinPathTests.testPathRepresentableSimpleSingleJoining),
            ("testPathRepresentableMultipleJoining", JoinPathTests.testPathRepresentableMultipleJoining),
            ("testPathRepresentableMultipleJoiningWithTrailingSeparators", JoinPathTests.testPathRepresentableMultipleJoiningWithTrailingSeparators),
            ("testPathRepresentableJoiningWithAbsolutePath", JoinPathTests.testPathRepresentableJoiningWithAbsolutePath),
        ]
    }
}
extension MakeAbsoluteTests {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testMakeAbsolutePath", MakeAbsoluteTests.testMakeAbsolutePath),
            ("testPathRepresentableMakeAbsolutePath", MakeAbsoluteTests.testPathRepresentableMakeAbsolutePath),
        ]
    }
}
extension NormalizePathTests {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testAssertEmptyPathBecomesCurrent", NormalizePathTests.testAssertEmptyPathBecomesCurrent),
            ("testSlashPrefixes", NormalizePathTests.testSlashPrefixes),
            ("testConanicalizePath", NormalizePathTests.testConanicalizePath),
            ("testPathRepresentableEmptyPathBecomesCurrent", NormalizePathTests.testPathRepresentableEmptyPathBecomesCurrent),
            ("testPathRepresentableSlashPrefixes", NormalizePathTests.testPathRepresentableSlashPrefixes),
            ("testPathRepresentableConanicalizePath", NormalizePathTests.testPathRepresentableConanicalizePath),
        ]
    }
}
extension PathBaseNameTests {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testBaseNameOfPath", PathBaseNameTests.testBaseNameOfPath),
            ("testPathRepresentableBaseNameOfPath", PathBaseNameTests.testPathRepresentableBaseNameOfPath),
        ]
    }
}
extension PathDirectoryTests {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testPathDirectory", PathDirectoryTests.testPathDirectory),
            ("testPathRepresentableDirectory", PathDirectoryTests.testPathRepresentableDirectory),
        ]
    }
}
extension PathTests {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testPathValueDoesNotChange", PathTests.testPathValueDoesNotChange),
        ]
    }
}
extension ReadingTests {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testReadString", ReadingTests.testReadString),
            ("testReadBytes", ReadingTests.testReadBytes),
            ("testReadStringFromDirectory", ReadingTests.testReadStringFromDirectory),
            ("testReadStringFromNoWhere", ReadingTests.testReadStringFromNoWhere),
            ("testReadSymbolicLink", ReadingTests.testReadSymbolicLink),
            ("testPathRepresentableReadString", ReadingTests.testPathRepresentableReadString),
            ("testPathRepresentableReadBytes", ReadingTests.testPathRepresentableReadBytes),
            ("testPathRepresentableReadStringFromDirectory", ReadingTests.testPathRepresentableReadStringFromDirectory),
            ("testPathRepresentableReadStringFromNoWhere", ReadingTests.testPathRepresentableReadStringFromNoWhere),
            ("testPathRepresentableReadSymbolicLink", ReadingTests.testPathRepresentableReadSymbolicLink),
        ]
    }
}
extension SameFileTests {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testSameFileAsSymbolicLink", SameFileTests.testSameFileAsSymbolicLink),
            ("testNotSameFile", SameFileTests.testNotSameFile),
            ("testPathRepresentableSameFileAsSymbolicLink", SameFileTests.testPathRepresentableSameFileAsSymbolicLink),
            ("testPathRepresentableNotSameFile", SameFileTests.testPathRepresentableNotSameFile),
        ]
    }
}
extension SizeTests {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testSizeOfRegularFile", SizeTests.testSizeOfRegularFile),
            ("testSizeOfSymbolToRegularFile", SizeTests.testSizeOfSymbolToRegularFile),
            ("testSizeOfDirectory", SizeTests.testSizeOfDirectory),
            ("testSizeOfSymbolToDirectory", SizeTests.testSizeOfSymbolToDirectory),
            ("testSizeOfNonExistingPath", SizeTests.testSizeOfNonExistingPath),
            ("testPathRepresentableSizeOfRegularFile", SizeTests.testPathRepresentableSizeOfRegularFile),
            ("testPathRepresentableSizeOfSymbolToRegularFile", SizeTests.testPathRepresentableSizeOfSymbolToRegularFile),
            ("testPathRepresentableSizeOfDirectory", SizeTests.testPathRepresentableSizeOfDirectory),
            ("testPathRepresentableSizeOfSymbolToDirectory", SizeTests.testPathRepresentableSizeOfSymbolToDirectory),
            ("testPathRepresentableSizeOfNonExistingPath", SizeTests.testPathRepresentableSizeOfNonExistingPath),
        ]
    }
}
extension SplitExtensionTests {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testSplitExtensionOnSimplePath", SplitExtensionTests.testSplitExtensionOnSimplePath),
            ("testSplitExtensionOnPathWithMultipleDots", SplitExtensionTests.testSplitExtensionOnPathWithMultipleDots),
            ("testSplitExtensionOnPathWithLeadingDot", SplitExtensionTests.testSplitExtensionOnPathWithLeadingDot),
            ("testSplitExtensionOnPathWithNoDots", SplitExtensionTests.testSplitExtensionOnPathWithNoDots),
            ("testSplitExtensionOnPathWithLeadingDotButNoExtension", SplitExtensionTests.testSplitExtensionOnPathWithLeadingDotButNoExtension),
            ("testSplitExtensionOnPathWithManyLeadingDotsButNoExtension", SplitExtensionTests.testSplitExtensionOnPathWithManyLeadingDotsButNoExtension),
            ("testSplitExtensionOnPathWithLeadingDotsButNoExtension", SplitExtensionTests.testSplitExtensionOnPathWithLeadingDotsButNoExtension),
            ("testSplitExtensionOnPathWithLeadingDots", SplitExtensionTests.testSplitExtensionOnPathWithLeadingDots),
            ("testSplitExtensionOnPathWithOnlyDots", SplitExtensionTests.testSplitExtensionOnPathWithOnlyDots),
            ("testSplitExtensionOnEmptyPath", SplitExtensionTests.testSplitExtensionOnEmptyPath),
            ("testPathRepresentableSplitExtensionOnSimplePath", SplitExtensionTests.testPathRepresentableSplitExtensionOnSimplePath),
            ("testPathRepresentableSplitExtensionOnPathWithMultipleDots", SplitExtensionTests.testPathRepresentableSplitExtensionOnPathWithMultipleDots),
            ("testPathRepresentableSplitExtensionOnPathWithLeadingDot", SplitExtensionTests.testPathRepresentableSplitExtensionOnPathWithLeadingDot),
            ("testPathRepresentableSplitExtensionOnPathWithNoDots", SplitExtensionTests.testPathRepresentableSplitExtensionOnPathWithNoDots),
            ("testPathRepresentableSplitExtensionOnPathWithLeadingDotButNoExtension", SplitExtensionTests.testPathRepresentableSplitExtensionOnPathWithLeadingDotButNoExtension),
            ("testPathRepresentableSplitExtensionOnPathWithManyLeadingDotsButNoExtension", SplitExtensionTests.testPathRepresentableSplitExtensionOnPathWithManyLeadingDotsButNoExtension),
            ("testPathRepresentableSplitExtensionOnPathWithLeadingDotsButNoExtension", SplitExtensionTests.testPathRepresentableSplitExtensionOnPathWithLeadingDotsButNoExtension),
            ("testPathRepresentableSplitExtensionOnPathWithLeadingDots", SplitExtensionTests.testPathRepresentableSplitExtensionOnPathWithLeadingDots),
            ("testPathRepresentableSplitExtensionOnPathWithOnlyDots", SplitExtensionTests.testPathRepresentableSplitExtensionOnPathWithOnlyDots),
            ("testPathRepresentableSplitExtensionOnEmptyPath", SplitExtensionTests.testPathRepresentableSplitExtensionOnEmptyPath),
        ]
    }
}
extension SplitPathTests {
    static var allx: [(String, XCTestCaseClosure)] {
        return [
            ("testSplitSimplePath", SplitPathTests.testSplitSimplePath),
            ("testSplitRootPath", SplitPathTests.testSplitRootPath),
            ("testSplitSingleCompomentPath", SplitPathTests.testSplitSingleCompomentPath),
            ("testSplitWithABunchOfPrefixSlashes", SplitPathTests.testSplitWithABunchOfPrefixSlashes),
            ("testSplitWithRedundantSeparator", SplitPathTests.testSplitWithRedundantSeparator),
            ("testPathRepresentableSplitSimplePath", SplitPathTests.testPathRepresentableSplitSimplePath),
            ("testPathRepresentableSplitRootPath", SplitPathTests.testPathRepresentableSplitRootPath),
            ("testPathRepresentableSplitSingleCompomentPath", SplitPathTests.testPathRepresentableSplitSingleCompomentPath),
            ("testPathRepresentableSplitWithABunchOfPrefixSlashes", SplitPathTests.testPathRepresentableSplitWithABunchOfPrefixSlashes),
            ("testPathRepresentableSplitWithRedundantSeparator", SplitPathTests.testPathRepresentableSplitWithRedundantSeparator),
        ]
    }
}

XCTMain([
    testCase(ChildrenTests.allx),
    testCase(ExistsTest.allx),
    testCase(ExpandUserDirectoryTests.allx),
    testCase(FileExtensionTests.allx),
    testCase(FixtureTestCase.allx),
    testCase(IsAbsoluteTests.allx),
    testCase(IsBlockDeviceTests.allx),
    testCase(IsCharacterDeviceTests.allx),
    testCase(IsDirectoryTests.allx),
    testCase(IsFileTests.allx),
    testCase(IsPipeTests.allx),
    testCase(IsSocketTests.allx),
    testCase(IsSymbolicLinkTests.allx),
    testCase(JoinPathTests.allx),
    testCase(MakeAbsoluteTests.allx),
    testCase(NormalizePathTests.allx),
    testCase(PathBaseNameTests.allx),
    testCase(PathDirectoryTests.allx),
    testCase(PathTests.allx),
    testCase(ReadingTests.allx),
    testCase(SameFileTests.allx),
    testCase(SizeTests.allx),
    testCase(SplitExtensionTests.allx),
    testCase(SplitPathTests.allx),
])
