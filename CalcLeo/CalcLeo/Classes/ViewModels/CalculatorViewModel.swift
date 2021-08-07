import Foundation

protocol CalculatorViewModelDelegate: AnyObject {
    func dataUpdated(models: [[ButtonSymbol]])
    func publishError(_ message: String)
}

final class CalculatorViewModel {

    weak var delegate: CalculatorViewModelDelegate?
    private var plistObjectMappingService = PlistObjectMappingService<[[ButtonSymbol]]>()
    private var buttons: [[ButtonSymbol]]? {
        didSet {
            guard let buttons = buttons else { return }
            delegate?.dataUpdated(models: buttons)
        }
    }

    init(delegate: CalculatorViewModelDelegate?) {
        self.delegate = delegate
    }

    func prepareObjects() {
        guard let url = Bundle.main.url(forResource: "Features", withExtension: "plist") else {
            delegate?.publishError("File not found!")
            return
        }
        plistObjectMappingService.performMapping(with: url) { [weak self] result in
            switch result {
            case .success(let objects): self?.buttons = objects
            case .failure(let error): self?.delegate?.publishError(error.localizedDescription)
            }
        }
    }
}
