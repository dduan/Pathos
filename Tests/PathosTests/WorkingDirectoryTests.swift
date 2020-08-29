import Pathos
import XCTest

final class WorkingDirectoryTests: XCTestCase {
    func testGettingWorkingDirecotry() throws {
        XCTAssertNoThrow(try Path.workingDirectory())
    }
}
