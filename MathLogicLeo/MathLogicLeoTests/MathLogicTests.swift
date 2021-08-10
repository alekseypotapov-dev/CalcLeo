import XCTest
@testable import MathLogicLeo

final class MathLogicTests: XCTestCase {

    func test_zeroDigitInput_success() {
        let sut = MathLogic()

        let expected = "0"

        do {
            let actual = try sut.processInput("0")
            XCTAssertEqual(actual, expected)
        } catch {
            if let e = error as? MathLogicError {
                XCTFail(e.description)
            }
        }
    }

    func test_commaInput_success() {
        let sut = MathLogic()

        let expected = "0."

        do {
            let actual = try sut.processInput(".")
            XCTAssertEqual(actual, expected)
        } catch {
            if let e = error as? MathLogicError {
                XCTFail(e.description)
            }
        }
    }

    func test_commaOneInput_success() {
        let sut = MathLogic()

        let expected = "0.1"

        do {
            let _ = try sut.processInput(".")
            let actual = try sut.processInput("1")
            XCTAssertEqual(actual, expected)
        } catch {
            if let e = error as? MathLogicError {
                XCTFail(e.description)
            }
        }
    }

    func test_binary_2Plus3_5() {
        let sut = MathLogic()

        let expected = "5"

        do {
            let _ = try sut.processInput("2")
            let _ = try sut.processInput("+")
            let _ = try sut.processInput("3")
            let actual = try sut.processInput("=")
            XCTAssertEqual(actual, expected)
        } catch {
            if let e = error as? MathLogicError {
                XCTFail(e.description)
            }
        }
    }

    func test_binary_3minus1_2() {
        let sut = MathLogic()

        let expected = "2"

        do {
            let _ = try sut.processInput("3")
            let _ = try sut.processInput("-")
            let _ = try sut.processInput("1")
            let actual = try sut.processInput("=")
            XCTAssertEqual(actual, expected)
        } catch {
            if let e = error as? MathLogicError {
                XCTFail(e.description)
            }
        }
    }

    func test_binary_3multiply4_12() {
        let sut = MathLogic()

        let expected = "12"

        do {
            let _ = try sut.processInput("3")
            let _ = try sut.processInput("*")
            let _ = try sut.processInput("4")
            let actual = try sut.processInput("=")
            XCTAssertEqual(actual, expected)
        } catch {
            if let e = error as? MathLogicError {
                XCTFail(e.description)
            }
        }
    }

    func test_binary_8dividedBy2_4() {
        let sut = MathLogic()

        let expected = "4"

        do {
            let _ = try sut.processInput("8")
            let _ = try sut.processInput("/")
            let _ = try sut.processInput("2")
            let actual = try sut.processInput("=")
            XCTAssertEqual(actual, expected)
        } catch {
            if let e = error as? MathLogicError {
                XCTFail(e.description)
            }
        }
    }

    func test_binary_cos360_1() {
        let sut = MathLogic()

        let expected = "1"

        do {
            let _ = try sut.processInput("3")
            let _ = try sut.processInput("6")
            let _ = try sut.processInput("0")
            let _ = try sut.processInput("cos")
            let actual = try sut.processInput("=")
            XCTAssertEqual(actual, expected)
        } catch {
            if let e = error as? MathLogicError {
                XCTFail(e.description)
            }
        }
    }

    func test_binary_sin270_minus1() {
        let sut = MathLogic()

        let expected = "-1"

        do {
            let _ = try sut.processInput("2")
            let _ = try sut.processInput("7")
            let _ = try sut.processInput("0")
            let _ = try sut.processInput("sin")
            let actual = try sut.processInput("=")
            XCTAssertEqual(actual, expected)
        } catch {
            if let e = error as? MathLogicError {
                XCTFail(e.description)
            }
        }
    }

    func test_clear_1AC_0() {
        let sut = MathLogic()

        let expected = "0"

        do {
            let _ = try sut.processInput("1")
            let actual = try sut.processInput("AC")
            XCTAssertEqual(actual, expected)
        } catch {
            if let e = error as? MathLogicError {
                XCTFail(e.description)
            }
        }
    }

    func test_concatenation_2plus3multiply2_10() {
        let sut = MathLogic()

        let expected = "10"

        do {
            let _ = try sut.processInput("2")
            let _ = try sut.processInput("+")
            let _ = try sut.processInput("3")
            let _ = try sut.processInput("*")
            let _ = try sut.processInput("2")
            let actual = try sut.processInput("=")
            XCTAssertEqual(actual, expected)
        } catch {
            if let e = error as? MathLogicError {
                XCTFail(e.description)
            }
        }
    }

    func test_cryptoCurrencyConverter_1btc_success() {
        let sut = MathLogic()

        let expected = "45111.12"

        do {
            let _ = try sut.processInput("1")
            let _ = try sut.processInput("*")
            let _ = try sut.processInput("45111.12")
            let actual = try sut.processInput("=")
            XCTAssertEqual(actual, expected)
        } catch {
            if let e = error as? MathLogicError {
                XCTFail(e.description)
            }
        }
    }
}
