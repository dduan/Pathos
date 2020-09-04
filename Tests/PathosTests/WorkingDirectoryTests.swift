import Pathos
import XCTest

final class WorkingDirectoryTests: XCTestCase {
    func testGettingWorkingDirecotry() throws {
        XCTAssertNoThrow(try Path.workingDirectory())
    }

    func testSettingWorkingDirecotry() throws {
        let path = try Path.workingDirectory()
        XCTAssertNoThrow(try Path.setWorkingDirectory(path))
    }

    func testAsWorkingDirectory() throws {
        let path = try Path.workingDirectory()
        var actionExecuted = false
        try path.asWorkingDirectory {
            actionExecuted = true
        }
        XCTAssert(actionExecuted)
    }
}
