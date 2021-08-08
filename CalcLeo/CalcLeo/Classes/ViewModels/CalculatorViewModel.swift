import Foundation
import MathLeo

protocol CalculatorViewModelDelegate: AnyObject {
    func dataUpdated(models: [[Feature]])
    func publishError(_ message: String)
    func updateResult(with text: String)
}

final class CalculatorViewModel {

    weak var delegate: CalculatorViewModelDelegate?
    private var buttons: [[Feature]]? {
        didSet {
            guard let buttons = buttons else { return }
            delegate?.dataUpdated(models: buttons)
        }
    }

    private lazy var mathLogic: CalcLogic = {
        let mathLogic = CalcLogic(maxDisplayValueLength: 10)
        return mathLogic
    }()

    private lazy var featureProvider: FeatureProvider = {
        let featureProvider = FeatureProvider()
        return featureProvider
    }()

    init(delegate: CalculatorViewModelDelegate?) {
        self.delegate = delegate
    }

    func prepareObjects() {
        featureProvider.performMapping { [weak self] result in
            switch result {
            case .success(let objects): self?.buttons = objects
            case .failure(let error): self?.delegate?.publishError(error.localizedDescription)
            }
        }
    }

    func buttonTap(with id: Int) {
        guard let buttons = buttons else { return }

        if let element = (buttons.joined().first { $0.id == id }) {
            let value = mathLogic.sendElement(element)
            delegate?.updateResult(with: value)
        }
    }
}
