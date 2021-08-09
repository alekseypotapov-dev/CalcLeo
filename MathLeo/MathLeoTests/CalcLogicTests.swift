@testable import MathLeo
import XCTest

final class CalcLogicTests: XCTestCase {

    func test_zeroDigitInput_success() {
        var sut = CalcLogic(maxDisplayValueLength: 10)

        let expected = "0"
        let actual = sut.sendElement(Feature(labelText: "0", value: "0", type: .digit, visible: true, id: 0))

        XCTAssertEqual(actual, expected)
    }

    func test_commaInput_success() {
        var sut = CalcLogic(maxDisplayValueLength: 10)

        let expected = "0."
        let actual = sut.sendElement(Feature(labelText: ".", value: ".", type: .comma, visible: true, id: 0))

        XCTAssertEqual(actual, expected)
    }

    func test_commaOneInput_success() {
        var sut = CalcLogic(maxDisplayValueLength: 10)

        let expected = "0.1"

        let _ = sut.sendElement(Feature(labelText: ".", value: ".", type: .comma, visible: true, id: 0))
        let actual = sut.sendElement(Feature(labelText: "1", value: "1", type: .digit, visible: true, id: 1))

        XCTAssertEqual(actual, expected)
    }

    func test_binary_2Plus3_4() {
        var sut = CalcLogic(maxDisplayValueLength: 10)

        let expected = "5"

        let _ = sut.sendElement(Feature(labelText: "2", value: "2", type: .digit, visible: true, id: 0))
        let _ = sut.sendElement(Feature(labelText: "+", value: "+", type: .binary, visible: true, id: 1))
        let _ = sut.sendElement(Feature(labelText: "3", value: "3", type: .digit, visible: true, id: 2))
        let actual = sut.sendElement(Feature(labelText: "=", value: "=", type: .equals, visible: true, id: 3))

        XCTAssertEqual(actual, expected)
    }

    func test_binary_3minus1_2() {
        var sut = CalcLogic(maxDisplayValueLength: 10)

        let expected = "2"

        let _ = sut.sendElement(Feature(labelText: "3", value: "3", type: .digit, visible: true, id: 0))
        let _ = sut.sendElement(Feature(labelText: "-", value: "-", type: .binary, visible: true, id: 1))
        let _ = sut.sendElement(Feature(labelText: "1", value: "1", type: .digit, visible: true, id: 2))
        let actual = sut.sendElement(Feature(labelText: "=", value: "=", type: .equals, visible: true, id: 3))

        XCTAssertEqual(actual, expected)
    }

    func test_binary_3multiply4_12() {
        var sut = CalcLogic(maxDisplayValueLength: 10)

        let expected = "12"

        let _ = sut.sendElement(Feature(labelText: "3", value: "3", type: .digit, visible: true, id: 0))
        let _ = sut.sendElement(Feature(labelText: "X", value: "*", type: .binary, visible: true, id: 1))
        let _ = sut.sendElement(Feature(labelText: "4", value: "4", type: .digit, visible: true, id: 2))
        let actual = sut.sendElement(Feature(labelText: "=", value: "=", type: .equals, visible: true, id: 3))

        XCTAssertEqual(actual, expected)
    }

    func test_binary_8dividedBy2_4() {
        var sut = CalcLogic(maxDisplayValueLength: 10)

        let expected = "4"

        let _ = sut.sendElement(Feature(labelText: "8", value: "8", type: .digit, visible: true, id: 0))
        let _ = sut.sendElement(Feature(labelText: "/", value: "/", type: .binary, visible: true, id: 1))
        let _ = sut.sendElement(Feature(labelText: "2", value: "2", type: .digit, visible: true, id: 2))
        let actual = sut.sendElement(Feature(labelText: "=", value: "=", type: .equals, visible: true, id: 3))

        XCTAssertEqual(actual, expected)
    }

    func test_binary_cos360_1() {
        var sut = CalcLogic(maxDisplayValueLength: 10)

        let expected = "1"

        let _ = sut.sendElement(Feature(labelText: "3", value: "3", type: .digit, visible: true, id: 0))
        let _ = sut.sendElement(Feature(labelText: "6", value: "6", type: .digit, visible: true, id: 1))
        let _ = sut.sendElement(Feature(labelText: "0", value: "0", type: .digit, visible: true, id: 2))
        let _ = sut.sendElement(Feature(labelText: "cos()", value: "cos", type: .unary, visible: true, id: 3))
        let actual = sut.sendElement(Feature(labelText: "=", value: "=", type: .equals, visible: true, id: 4))

        XCTAssertEqual(actual, expected)
    }

    func test_binary_sin270_minus1() {
        var sut = CalcLogic(maxDisplayValueLength: 10)

        let expected = "-1"

        let _ = sut.sendElement(Feature(labelText: "2", value: "2", type: .digit, visible: true, id: 0))
        let _ = sut.sendElement(Feature(labelText: "7", value: "7", type: .digit, visible: true, id: 1))
        let _ = sut.sendElement(Feature(labelText: "0", value: "0", type: .digit, visible: true, id: 2))
        let _ = sut.sendElement(Feature(labelText: "sin()", value: "sin", type: .unary, visible: true, id: 3))
        let actual = sut.sendElement(Feature(labelText: "=", value: "=", type: .equals, visible: true, id: 4))

        XCTAssertEqual(actual, expected)
    }

    func test_clear_1AC_0() {
        var sut = CalcLogic(maxDisplayValueLength: 10)

        let expected = "0"

        let _ = sut.sendElement(Feature(labelText: "1", value: "1", type: .digit, visible: true, id: 0))
        let actual = sut.sendElement(Feature(labelText: "AC", value: "AC", type: .clear, visible: true, id: 1))

        XCTAssertEqual(actual, expected)
    }

    func test_concatenation_2plus3multiply2_10() {
        var sut = CalcLogic(maxDisplayValueLength: 10)

        let expected = "10"

        let _ = sut.sendElement(Feature(labelText: "2", value: "2", type: .digit, visible: true, id: 0))
        let _ = sut.sendElement(Feature(labelText: "+", value: "+", type: .binary, visible: true, id: 1))
        let _ = sut.sendElement(Feature(labelText: "3", value: "3", type: .digit, visible: true, id: 2))
        let _ = sut.sendElement(Feature(labelText: "X", value: "*", type: .binary, visible: true, id: 3))
        let _ = sut.sendElement(Feature(labelText: "2", value: "2", type: .digit, visible: true, id: 4))
        let actual = sut.sendElement(Feature(labelText: "=", value: "=", type: .equals, visible: true, id: 5))

        XCTAssertEqual(actual, expected)
    }

}
