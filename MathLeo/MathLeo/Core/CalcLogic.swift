import Foundation

public class CalcLogic {

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

    public func maintain(_ element: Feature, with completionHandler: @escaping (String) -> Void) {
        switch element.type {
        case .comma:
            if !inputInProgress {
                currentDisplayValue = "0."
                inputInProgress = true
            } else if currentDisplayValue.range(of: ".") == nil {
                currentDisplayValue.append(".")
            }
            completionHandler(currentDisplayValue.setMaxLength(of: maxDisplayValueLength).removeAfterPointIfZero())
        case .digit:
            if !inputInProgress {
                currentDisplayValue = element.value
                inputInProgress = true
            } else if let zero = currentDisplayValue.first, currentDisplayValue.count == 1 && zero == "0" {
                currentDisplayValue = element.value
            } else if inputInProgress {
                currentDisplayValue += element.value
            }
            completionHandler(currentDisplayValue.setMaxLength(of: maxDisplayValueLength).removeAfterPointIfZero())
        case .binary, .unary, .equals:
            if inputInProgress {
                accumulator = Double(currentDisplayValue)
                inputInProgress = false
            }
            performOperation(element.value)
            if let acc = accumulator {
                currentDisplayValue = String(acc)
            }
            completionHandler(currentDisplayValue.setMaxLength(of: maxDisplayValueLength).removeAfterPointIfZero())
        case .clear:
            accumulator = 0
            currentDisplayValue = "0"
            completionHandler(currentDisplayValue.setMaxLength(of: maxDisplayValueLength).removeAfterPointIfZero())
        case .online:
            performOnlineOperation(with: element.value) { [weak self] value, errorString in
                guard let self = self else {
                    completionHandler("0")
                    return
                }
                if let errorString = errorString {
                    self.inputInProgress = false
                    self.accumulator = 0
                    self.currentDisplayValue = errorString
                    completionHandler(self.currentDisplayValue)
                    return
                }

                self.accumulator = (Double(self.currentDisplayValue) ?? 1) * Double(value)
                self.inputInProgress = false
                if let acc = self.accumulator {
                    self.currentDisplayValue = String(acc)
                }
                completionHandler(self.currentDisplayValue.setMaxLength(of: self.maxDisplayValueLength).removeAfterPointIfZero())
            }
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
            }
        }
    }

    // todo: this needs an upgrade
    func performOnlineOperation(with cryptoCurrency: String, completionHandler: @escaping (Float, String?) -> Void) {
        guard NetworkService.isAvailable else {
            return completionHandler(0, "no network")
        }

        let stringUrl = "https://api.coindesk.com/v1/bpi/currentprice/" + cryptoCurrency

        let request = RequestService()
        request.requestData(with: stringUrl) { result in
            switch result {
            case .success(let data):
                let service = JsonObjectMappingService<OnlineResponse>()
                service.performMapping(with: data) { result in
                    switch result {
                    case .success(let onlineResponse): return completionHandler(onlineResponse.bpi.USD.rate_float, nil)
                    case .failure(let error): return completionHandler(0, error.localizedDescription)
                    }
                }
            case .failure(let error): completionHandler(0, error.localizedDescription)
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

private struct PendingBinaryOperation {
    let function: (Double, Double) -> Double
    let firstOperand: Double

    func perform(with secondOperand: Double) -> Double {
        return function(firstOperand, secondOperand)
    }
}
