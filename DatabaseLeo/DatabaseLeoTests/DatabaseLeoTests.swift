@testable import DatabaseLeo
import XCTest

final class DatabaseManagerTests: XCTestCase {

    func test_readData() {
        let sut = DatabaseManager(fileName: "File", fileExtension: "plist", bundlePath: Bundle(for: type(of: self)).bundlePath)

        do {
            let actual = try sut.readData()
            XCTAssertTrue(true)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func test_writeData() {
        let sut = DatabaseManager(fileName: "File", fileExtension: "plist", bundlePath: Bundle(for: type(of: self)).bundlePath)

        do {
            let actual = try sut.writeData(Data())
            XCTAssertTrue(true)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
