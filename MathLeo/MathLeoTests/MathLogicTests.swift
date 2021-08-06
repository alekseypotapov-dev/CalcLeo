@testable import MathLeo
import XCTest

final class MathLogicTests: XCTestCase {

    func test_add_success() throws {
        let sut = MathLogic()

        let expected = 4
        let actual = sut.addition(a: 2, b: 2)

        XCTAssertEqual(expected, actual)
    }
}
