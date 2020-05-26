import XCTest
import Pathos

final class SplitDriveTests: XCTestCase {
    func testSimpleDriveSplit() {
#if os(Windows)
        let (drive, path) = splitDrive(path: #"c:\Library"#)
        XCTAssertEqual(drive, "c:")
        XCTAssertEqual(path, #"\Library"#)
#else
        let (drive, path) = splitDrive(path: #"c:\Library"#)
        XCTAssertEqual(drive, "")
        XCTAssertEqual(path, #"c:\Library"#)
#endif
    }

    func testSimpleDriveNoPathSplit() {
#if os(Windows)
        let (drive, path) = splitDrive(path: "c:")
        XCTAssertEqual(drive, "c:")
        XCTAssertEqual(path, "")
#else
        let (drive, path) = splitDrive(path: "c:")
        XCTAssertEqual(drive, "")
        XCTAssertEqual(path, "c:")
#endif
    }

    func testSimpleNoDrivePathSplit() {
#if os(Windows)
        let (drive, path) = splitDrive(path: #"\Library"#)
        XCTAssertEqual(drive, "")
        XCTAssertEqual(path, #"\Library"#)
#else
        let (drive, path) = splitDrive(path: "/Library")
        XCTAssertEqual(drive, "")
        XCTAssertEqual(path, "/Library")
#endif
    }

    func testSplitingUNCHost() {
#if os(Windows)
        let (drive, path) = splitDrive(path: #"\\hostname\mountname\path\name"#)
        XCTAssertEqual(drive, #"\\hostname\mountname"#)
        XCTAssertEqual(path, #"\path\name"#)
#else
        let (drive, path) = splitDrive(path: #"\\hostname\mountname\path\name"#)
        XCTAssertEqual(drive, "")
        XCTAssertEqual(path, #"\\hostname\mountname\path\name"#)
#endif
    }

    func testSplitingUNCHostWithNoPath() {
#if os(Windows)
        let (drive, path) = splitDrive(path: #"\\hostname\mountname"#)
        XCTAssertEqual(drive, #"\\hostname\mountname"#)
        XCTAssertEqual(path, "")
#else
        let (drive, path) = splitDrive(path: #"\\hostname\mountname"#)
        XCTAssertEqual(drive, "")
        XCTAssertEqual(path, #"\\hostname\mountname"#)
#endif
    }

    func testSplitingUNCHostLookAlike() {
        // this is actually not valid host because the 3rd \ must not be followed by another \
        let (drive, path) = splitDrive(path: #"\\hostname\\mountname\a"#)
        XCTAssertEqual(drive, "")
        XCTAssertEqual(path, #"\\hostname\\mountname\a"#)
    }

    func testPathRepresentableSimpleDriveSplit() {
#if os(Windows)
        let (drive, path) = Path(#"c:\Library"#).splitDrive()
        XCTAssertEqual(drive.pathString, "c:")
        XCTAssertEqual(path.pathString, #"\Library"#)
#else
        let (drive, path) = Path(#"c:\Library"#).splitDrive()
        XCTAssertEqual(drive.pathString, "")
        XCTAssertEqual(path.pathString, #"c:\Library"#)
#endif
    }

    func testPathRepresentableSimpleDriveNoPathSplit() {
#if os(Windows)
        let (drive, path) = Path("c:").splitDrive()
        XCTAssertEqual(drive.pathString, "c:")
        XCTAssertEqual(path.pathString, "")
#else
        let (drive, path) = Path("c:").splitDrive()
        XCTAssertEqual(drive.pathString, "")
        XCTAssertEqual(path.pathString, "c:")
#endif
    }

    func testPathRepresentableSimpleNoDrivePathSplit() {
#if os(Windows)
        let (drive, path) = Path(#"\Library"#).splitDrive()
        XCTAssertEqual(drive.pathString, "")
        XCTAssertEqual(path.pathString, #"\Library"#)
#else
        let (drive, path) = Path("/Library").splitDrive()
        XCTAssertEqual(drive.pathString, "")
        XCTAssertEqual(path.pathString, "/Library")
#endif
    }

    func testPathRepresentableSplitingUNCHost() {
#if os(Windows)
        let (drive, path) = Path(#"\\hostname\mountname\path\name"#).splitDrive()
        XCTAssertEqual(drive.pathString, #"\\hostname\mountname"#)
        XCTAssertEqual(path.pathString, #"\path\name"#)
#else
        let (drive, path) = Path(#"\\hostname\mountname\path\name"#).splitDrive()
        XCTAssertEqual(drive.pathString, "")
        XCTAssertEqual(path.pathString, #"\\hostname\mountname\path\name"#)
#endif
    }

    func testPathRepresentableSplitingUNCHostWithNoPath() {
#if os(Windows)
        let (drive, path) = Path(#"\\hostname\mountname"#).splitDrive()
        XCTAssertEqual(drive.pathString, #"\\hostname\mountname"#)
        XCTAssertEqual(path.pathString, "")
#else
        let (drive, path) = Path(#"\\hostname\mountname"#).splitDrive()
        XCTAssertEqual(drive.pathString, "")
        XCTAssertEqual(path.pathString, #"\\hostname\mountname"#)
#endif
    }

    func testPathRepresentableSplitingUNCHostLookAlike() {
        // this is actually not valid host because the 3rd \ must not be followed by another \
        let (drive, path) = Path(#"\\hostname\\mountname\a"#).splitDrive()
        XCTAssertEqual(drive.pathString, "")
        XCTAssertEqual(path.pathString, #"\\hostname\\mountname\a"#)
    }
}
