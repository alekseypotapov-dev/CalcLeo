@testable import MathLeo
import XCTest

final class CalcLogicTests: XCTestCase {

    func expectationsWait() {
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }

    func test_zeroDigitInput_success() {
        let sut = CalcLogic(maxDisplayValueLength: 10)

        let expectation = expectation(description: "maintain callback")
        let expected = "0"

        sut.maintain(Feature(labelText: "0", value: "0", type: .digit, visible: true, id: 0)) { actual in
            XCTAssertEqual(actual, expected)
            expectation.fulfill()
        }

        expectationsWait()
    }

    func test_commaInput_success() {
        let sut = CalcLogic(maxDisplayValueLength: 10)

        let expectation = expectation(description: "maintain callback")
        let expected = "0."

        sut.maintain(Feature(labelText: ".", value: ".", type: .comma, visible: true, id: 0)) { actual in
            XCTAssertEqual(actual, expected)
            expectation.fulfill()
        }

        expectationsWait()
    }

    func test_commaOneInput_success() {
        let sut = CalcLogic(maxDisplayValueLength: 10)

        let expectation = expectation(description: "maintain callback")
        let expected = "0.1"

        sut.maintain(Feature(labelText: ".", value: ".", type: .comma, visible: true, id: 0)) { _ in }
        sut.maintain(Feature(labelText: "1", value: "1", type: .digit, visible: true, id: 1)) { actual in
            XCTAssertEqual(actual, expected)
            expectation.fulfill()
        }

        expectationsWait()
    }

    func test_binary_2Plus3_4() {
        let sut = CalcLogic(maxDisplayValueLength: 10)

        let expectation = expectation(description: "maintain callback")
        let expected = "5"

        sut.maintain(Feature(labelText: "2", value: "2", type: .digit, visible: true, id: 0)) { _ in }
        sut.maintain(Feature(labelText: "+", value: "+", type: .binary, visible: true, id: 1)) { _ in }
        sut.maintain(Feature(labelText: "3", value: "3", type: .digit, visible: true, id: 2)) { _ in }
        sut.maintain(Feature(labelText: "=", value: "=", type: .equals, visible: true, id: 3)) { actual in
            XCTAssertEqual(actual, expected)
            expectation.fulfill()
        }

        expectationsWait()
    }

    func test_binary_3minus1_2() {
        let sut = CalcLogic(maxDisplayValueLength: 10)

        let expectation = expectation(description: "maintain callback")
        let expected = "2"

        sut.maintain(Feature(labelText: "3", value: "3", type: .digit, visible: true, id: 0)) { _ in }
        sut.maintain(Feature(labelText: "-", value: "-", type: .binary, visible: true, id: 1)) { _ in }
        sut.maintain(Feature(labelText: "1", value: "1", type: .digit, visible: true, id: 2)) { _ in }
        sut.maintain(Feature(labelText: "=", value: "=", type: .equals, visible: true, id: 3)) { actual in
            XCTAssertEqual(actual, expected)
            expectation.fulfill()
        }

        expectationsWait()
    }

    func test_binary_3multiply4_12() {
        let sut = CalcLogic(maxDisplayValueLength: 10)

        let expectation = expectation(description: "maintain callback")
        let expected = "12"

        sut.maintain(Feature(labelText: "3", value: "3", type: .digit, visible: true, id: 0)) { _ in }
        sut.maintain(Feature(labelText: "X", value: "*", type: .binary, visible: true, id: 1)) { _ in }
        sut.maintain(Feature(labelText: "4", value: "4", type: .digit, visible: true, id: 2)) { _ in }
        sut.maintain(Feature(labelText: "=", value: "=", type: .equals, visible: true, id: 3)) { actual in
            XCTAssertEqual(actual, expected)
            expectation.fulfill()
        }

        expectationsWait()
    }

    func test_binary_8dividedBy2_4() {
        let sut = CalcLogic(maxDisplayValueLength: 10)

        let expectation = expectation(description: "maintain callback")
        let expected = "4"

        sut.maintain(Feature(labelText: "8", value: "8", type: .digit, visible: true, id: 0)) { _ in }
        sut.maintain(Feature(labelText: "/", value: "/", type: .binary, visible: true, id: 1)) { _ in }
        sut.maintain(Feature(labelText: "2", value: "2", type: .digit, visible: true, id: 2)) { _ in }
        sut.maintain(Feature(labelText: "=", value: "=", type: .equals, visible: true, id: 3))  { actual in
            XCTAssertEqual(actual, expected)
            expectation.fulfill()
        }

        expectationsWait()
    }

    func test_binary_cos360_1() {
        let sut = CalcLogic(maxDisplayValueLength: 10)

        let expectation = expectation(description: "maintain callback")
        let expected = "1"

        sut.maintain(Feature(labelText: "3", value: "3", type: .digit, visible: true, id: 0)) { _ in }
        sut.maintain(Feature(labelText: "6", value: "6", type: .digit, visible: true, id: 1)) { _ in }
        sut.maintain(Feature(labelText: "0", value: "0", type: .digit, visible: true, id: 2)) { _ in }
        sut.maintain(Feature(labelText: "cos()", value: "cos", type: .unary, visible: true, id: 3)) { _ in }
        sut.maintain(Feature(labelText: "=", value: "=", type: .equals, visible: true, id: 4))  { actual in
            XCTAssertEqual(actual, expected)
            expectation.fulfill()
        }

        expectationsWait()
    }

    func test_binary_sin270_minus1() {
        let sut = CalcLogic(maxDisplayValueLength: 10)

        let expectation = expectation(description: "maintain callback")
        let expected = "-1"

        sut.maintain(Feature(labelText: "2", value: "2", type: .digit, visible: true, id: 0)) { _ in }
        sut.maintain(Feature(labelText: "7", value: "7", type: .digit, visible: true, id: 1)) { _ in }
        sut.maintain(Feature(labelText: "0", value: "0", type: .digit, visible: true, id: 2)) { _ in }
        sut.maintain(Feature(labelText: "sin()", value: "sin", type: .unary, visible: true, id: 3)) { _ in }
        sut.maintain(Feature(labelText: "=", value: "=", type: .equals, visible: true, id: 4))  { actual in
            XCTAssertEqual(actual, expected)
            expectation.fulfill()
        }

        expectationsWait()
    }

    func test_clear_1AC_0() {
        let sut = CalcLogic(maxDisplayValueLength: 10)

        let expectation = expectation(description: "maintain callback")
        let expected = "0"

        sut.maintain(Feature(labelText: "1", value: "1", type: .digit, visible: true, id: 0)) { _ in }
        sut.maintain(Feature(labelText: "AC", value: "AC", type: .clear, visible: true, id: 1))  { actual in
            XCTAssertEqual(actual, expected)
            expectation.fulfill()
        }

        expectationsWait()
    }

    func test_concatenation_2plus3multiply2_10() {
        let sut = CalcLogic(maxDisplayValueLength: 10)

        let expectation = expectation(description: "maintain callback")
        let expected = "10"

        sut.maintain(Feature(labelText: "2", value: "2", type: .digit, visible: true, id: 0)) { _ in }
        sut.maintain(Feature(labelText: "+", value: "+", type: .binary, visible: true, id: 1)) { _ in }
        sut.maintain(Feature(labelText: "3", value: "3", type: .digit, visible: true, id: 2)) { _ in }
        sut.maintain(Feature(labelText: "X", value: "*", type: .binary, visible: true, id: 3)) { _ in }
        sut.maintain(Feature(labelText: "2", value: "2", type: .digit, visible: true, id: 4)) { _ in }
        sut.maintain(Feature(labelText: "=", value: "=", type: .equals, visible: true, id: 5))  { actual in
            XCTAssertEqual(actual, expected)
            expectation.fulfill()
        }

        expectationsWait()
    }

    func test_online_1BTC_USDValue() {
        let sut = CalcLogic(maxDisplayValueLength: 10)

        let expectation = expectation(description: "maintain callback")
        let expected = 0 // notNil

        sut.maintain(Feature(labelText: "1", value: "1", type: .digit, visible: true, id: 0)) { _ in }
        sut.maintain(Feature(labelText: "BTC", value: "BTC", type: .online, visible: true, id: 1)) { actual in
            let btcValue = Double(actual)
            XCTAssertNotNil(btcValue)
            expectation.fulfill()
        }

        expectationsWait()
    }

}
