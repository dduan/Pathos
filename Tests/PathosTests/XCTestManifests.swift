#if !canImport(ObjectiveC)
import XCTest

extension POSIXBinaryStringTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__POSIXBinaryStringTests = [
        ("testDecodingAndEncodingIsCommunitive", testDecodingAndEncodingIsCommunitive),
    ]
}

extension POSIXPartsParsingTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__POSIXPartsParsingTests = [
        ("test2SlashRoot", test2SlashRoot),
        ("test3SlashRoot", test3SlashRoot),
        ("testIntermediateCurrentDirectoryIsRemoved", testIntermediateCurrentDirectoryIsRemoved),
        ("testNoRootIsParsedCorrectly", testNoRootIsParsedCorrectly),
        ("testParsingDriveOnPOSIX", testParsingDriveOnPOSIX),
        ("testParsingParts", testParsingParts),
        ("testRootIsParsed", testRootIsParsed),
    ]
}

extension POSIXPathInitializationTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__POSIXPathInitializationTests = [
        ("testInitializationFromString", testInitializationFromString),
        ("testInitializingFromCString", testInitializingFromCString),
    ]
}

extension POSIXPathJoiningTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__POSIXPathJoiningTests = [
        ("testJoiningMixedTypes", testJoiningMixedTypes),
        ("testJoiningWithExsitingSeparator", testJoiningWithExsitingSeparator),
        ("testSimpleJoining", testSimpleJoining),
        ("testSimpleJoiningEndingWithAbsolutePath", testSimpleJoiningEndingWithAbsolutePath),
        ("testSimpleJoiningStartingAndEndingWithAbsolutePath", testSimpleJoiningStartingAndEndingWithAbsolutePath),
        ("testSimpleJoiningStartingWithAbsolutePath", testSimpleJoiningStartingWithAbsolutePath),
        ("testSimpleJoiningWithMulilpePaths", testSimpleJoiningWithMulilpePaths),
        ("testSimpleJoiningWithMultipleAbsolutePath", testSimpleJoiningWithMultipleAbsolutePath),
    ]
}

extension POSIXPurePathTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__POSIXPurePathTests = [
        ("testNameFromPath", testNameFromPath),
        ("testNameWithASuffix", testNameWithASuffix),
        ("testNameWithMultipleSuffixes", testNameWithMultipleSuffixes),
        ("testNameWithNoSuffix", testNameWithNoSuffix),
        ("testNameWithOnlyRoot", testNameWithOnlyRoot),
    ]
}

extension WindowsBinaryStringTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__WindowsBinaryStringTests = [
        ("testDecodingAndEncodingIsCommunitive", testDecodingAndEncodingIsCommunitive),
    ]
}

extension WindowsPartsParsingTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__WindowsPartsParsingTests = [
        ("test2SlashRoot", test2SlashRoot),
        ("test3SlashRoot", test3SlashRoot),
        ("testIntermediateCurrentDirectoryIsRemoved", testIntermediateCurrentDirectoryIsRemoved),
        ("testNoRootIsParsedCorrectly", testNoRootIsParsedCorrectly),
        ("testParsingDriveOnWindows", testParsingDriveOnWindows),
        ("testParsingDriveOnWindows2", testParsingDriveOnWindows2),
        ("testParsingParts", testParsingParts),
        ("testParsingUNCDriveOnWindows", testParsingUNCDriveOnWindows),
        ("testRootIsParsed", testRootIsParsed),
    ]
}

extension WindowsPathJoiningTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__WindowsPathJoiningTests = [
        ("testJoiningDriveOnlyWithPath", testJoiningDriveOnlyWithPath),
        ("testJoiningDriveOnlyWithRoot", testJoiningDriveOnlyWithRoot),
        ("testJoiningMixedTypes", testJoiningMixedTypes),
        ("testJoiningStartingWithDriveAndEndingWithRoot", testJoiningStartingWithDriveAndEndingWithRoot),
        ("testJoiningStartingWithRootAndEndingWithDrive", testJoiningStartingWithRootAndEndingWithDrive),
        ("testJoiningWithExsitingSeparator", testJoiningWithExsitingSeparator),
        ("testSimpleJoining", testSimpleJoining),
        ("testSimpleJoiningEndingWithAbsolutePath", testSimpleJoiningEndingWithAbsolutePath),
        ("testSimpleJoiningEndingWithDrive", testSimpleJoiningEndingWithDrive),
        ("testSimpleJoiningEndingWithDriveAndRoot", testSimpleJoiningEndingWithDriveAndRoot),
        ("testSimpleJoiningStartingAndEndingWithDifferentDrive", testSimpleJoiningStartingAndEndingWithDifferentDrive),
        ("testSimpleJoiningStartingAndEndingWithRoot", testSimpleJoiningStartingAndEndingWithRoot),
        ("testSimpleJoiningStartingAndEndingWithSameDrive", testSimpleJoiningStartingAndEndingWithSameDrive),
        ("testSimpleJoiningStartingWithAbsolutePath", testSimpleJoiningStartingWithAbsolutePath),
        ("testSimpleJoiningStartingWithDrive", testSimpleJoiningStartingWithDrive),
        ("testSimpleJoiningStartingWithDriveAndRoot", testSimpleJoiningStartingWithDriveAndRoot),
        ("testSimpleJoiningWithMulilpePaths", testSimpleJoiningWithMulilpePaths),
        ("testSimpleJoiningWithMultipleAbsolutePath", testSimpleJoiningWithMultipleAbsolutePath),
    ]
}

extension WindowsPurePathTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__WindowsPurePathTests = [
        ("testNameFromPath", testNameFromPath),
        ("testNameWithASuffix", testNameWithASuffix),
        ("testNameWithMultipleSuffixes", testNameWithMultipleSuffixes),
        ("testNameWithNoSuffix", testNameWithNoSuffix),
        ("testNameWithOnlyDriveAndRoot", testNameWithOnlyDriveAndRoot),
        ("testNameWithOnlyRoot", testNameWithOnlyRoot),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(POSIXBinaryStringTests.__allTests__POSIXBinaryStringTests),
        testCase(POSIXPartsParsingTests.__allTests__POSIXPartsParsingTests),
        testCase(POSIXPathInitializationTests.__allTests__POSIXPathInitializationTests),
        testCase(POSIXPathJoiningTests.__allTests__POSIXPathJoiningTests),
        testCase(POSIXPurePathTests.__allTests__POSIXPurePathTests),
        testCase(WindowsBinaryStringTests.__allTests__WindowsBinaryStringTests),
        testCase(WindowsPartsParsingTests.__allTests__WindowsPartsParsingTests),
        testCase(WindowsPathJoiningTests.__allTests__WindowsPathJoiningTests),
        testCase(WindowsPurePathTests.__allTests__WindowsPurePathTests),
    ]
}
#endif
