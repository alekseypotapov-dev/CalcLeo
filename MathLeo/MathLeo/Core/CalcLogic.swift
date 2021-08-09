import Foundation

public struct CalcLogic {

    private var accumulator: Double?
    private var pendingBinaryOperation: PendingBinaryOperation?
    private var currentDisplayValue: String = "0"
    private var inputInProgress: Bool = false
    private let maxDisplayValueLength: Int

    public init(maxDisplayValueLength: Int) {
        self.maxDisplayValueLength = maxDisplayValueLength
    }

    private enum Operation {
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case result
    }

    private var operations: Dictionary<String, Operation> = [
        "+" : .binaryOperation({ $0 + $1 }),
        "-" : .binaryOperation({ $0 - $1 }),
        "*" : .binaryOperation({ $0 * $1 }),
        "/" : .binaryOperation({ $0 / $1 }),
        "sin" : .unaryOperation(sinDeg),
        "cos" : .unaryOperation(cosDeg),
        "=" : .result
    ]

    static private func sinDeg(_ degrees: Double) -> Double { sin(degrees * .pi / 180.0) }
    static private func cosDeg(_ degrees: Double) -> Double { cos(degrees * .pi / 180.0) }

    public mutating func sendElement(_ element: Feature) -> String {
        switch element.type {
        case .comma:
            if !inputInProgress {
                currentDisplayValue = "0."
                inputInProgress = true
            } else if currentDisplayValue.range(of: ".") == nil {
                currentDisplayValue.append(".")
            }
        case .digit:
            if !inputInProgress {
                currentDisplayValue = element.value
                inputInProgress = true
            } else if let zero = currentDisplayValue.first, currentDisplayValue.count == 1 && zero == "0" {
                currentDisplayValue = element.value
            } else if inputInProgress {
                currentDisplayValue += element.value
            }
        case .binary, .unary, .equals:
            if inputInProgress {
                accumulator = Double(currentDisplayValue)
                inputInProgress = false
            }
            performOperation(element.value)
            if let acc = accumulator {
                currentDisplayValue = String(acc)
            }
        case .clear:
            accumulator = 0
            currentDisplayValue = "0"
        case .online:
            accumulator = 0
            currentDisplayValue = "0"
        }

        return currentDisplayValue.setMaxLength(of: maxDisplayValueLength).removeAfterPointIfZero()
    }

    private mutating func performOperation(_ operation: String) {
        if let operation = operations[operation] {
            switch operation {
            case .unaryOperation(let function):
                if let acc = accumulator {
                    accumulator = function(acc)
                }
            case .binaryOperation(let function):
                performPendingBinaryOperation()

                if let acc = accumulator {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: acc)
                    accumulator = nil
                }
            case .result:
                performPendingBinaryOperation()
            }
        }
    }

    private mutating func performPendingBinaryOperation() {
        if let _ = pendingBinaryOperation, let acc = accumulator {
            accumulator = pendingBinaryOperation?.perform(with: acc)
            pendingBinaryOperation = nil
        }
    }
}

private struct PendingBinaryOperation {
    let function: (Double, Double) -> Double
    let firstOperand: Double

    func perform(with secondOperand: Double) -> Double {
        return function(firstOperand, secondOperand)
    }
}
