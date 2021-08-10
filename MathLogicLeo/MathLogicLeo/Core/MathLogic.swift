import Foundation

public enum MathLogicError: Error, CustomStringConvertible {
    case invalidOperation

    public var description: String {
        switch self {
        case .invalidOperation: return "Operation is not supported!"
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

private enum Operation {
    case unaryOperation((Double) -> Double)
    case binaryOperation((Double, Double) -> Double)
    case result
    case clear
}

public class MathLogic {

    private var accumulator: Double?
    private var pendingBinaryOperation: PendingBinaryOperation?
    private var currentDisplayValue: String = "0"
    private var inputInProgress: Bool = false
    private let maxDisplayValueLength: Int

    private var operations: Dictionary<String, Operation> = [
        "+" : .binaryOperation({ $0 + $1 }),
        "-" : .binaryOperation({ $0 - $1 }),
        "*" : .binaryOperation({ $0 * $1 }),
        "/" : .binaryOperation({ $0 / $1 }),
        "sin" : .unaryOperation(sinDeg),
        "cos" : .unaryOperation(cosDeg),
        "=" : .result,
        "AC": .clear
    ]

    static private func sinDeg(_ degrees: Double) -> Double { sin(degrees * .pi / 180.0) }
    static private func cosDeg(_ degrees: Double) -> Double { cos(degrees * .pi / 180.0) }

    public init(maxDisplayValueLength: Int = 10) {
        self.maxDisplayValueLength = maxDisplayValueLength
    }

    public func processInput(_ input: String) throws -> String {
        if let _ = operations.first(where: { $0.key == input }) {
            if inputInProgress {
                accumulator = Double(currentDisplayValue)
                inputInProgress = false
            }
            performOperation(input)
            if let acc = accumulator {
                currentDisplayValue = String(acc)
            }

            return currentDisplayValue.setMaxLength(of: maxDisplayValueLength).removeAfterPointIfZero()
        } else if input == "." {
            if !inputInProgress {
                currentDisplayValue = "0."
                inputInProgress = true
            } else if currentDisplayValue.range(of: ".") == nil {
                currentDisplayValue.append(".")
            }

            return currentDisplayValue.setMaxLength(of: maxDisplayValueLength).removeAfterPointIfZero()
        } else if let _ = Int(input)  {
            performDigitInput(with: input)

            return currentDisplayValue.setMaxLength(of: maxDisplayValueLength).removeAfterPointIfZero()
        } else if let _ = Float(input) {
            performDigitInput(with: input)

            return currentDisplayValue.setMaxLength(of: maxDisplayValueLength).removeAfterPointIfZero()
        }
        
        throw MathLogicError.invalidOperation
    }

    private func performDigitInput(with input: String) {
        if !inputInProgress {
            currentDisplayValue = input
            inputInProgress = true
        } else if let zero = currentDisplayValue.first, currentDisplayValue.count == 1 && zero == "0" {
            currentDisplayValue = input
        } else if inputInProgress {
            currentDisplayValue += input
        }
    }

    private func performOperation(_ operation: String) {
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
            case .clear:
                accumulator = 0
                currentDisplayValue = "0"
            }
        }
    }

    private func performPendingBinaryOperation() {
        if let _ = pendingBinaryOperation, let acc = accumulator {
            accumulator = pendingBinaryOperation?.perform(with: acc)
            pendingBinaryOperation = nil
        }
    }
}
