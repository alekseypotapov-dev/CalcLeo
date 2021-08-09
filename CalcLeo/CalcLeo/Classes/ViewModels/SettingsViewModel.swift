import Foundation
import MathLeo

protocol SettingsViewModelDelegate: AnyObject {
    func dataUpdated(models: [Feature])
    func publishError(_ message: String)
}

final class SettingsViewModel {

    weak var delegate: SettingsViewModelDelegate?
    private var buttons: [Feature]? {
        didSet {
            guard let buttons = buttons else { return }
            delegate?.dataUpdated(models: buttons)
        }
    }

    private lazy var featureProvider: FeatureProvider = {
        let featureProvider = FeatureProvider()
        return featureProvider
    }()

    init(delegate: SettingsViewModelDelegate?) {
        self.delegate = delegate
    }

    func prepareObjects() {
        featureProvider.provideFeatures { [weak self] result in
            switch result {
            case .success(let objects): self?.buttons = objects.reduce([], +).sorted { $0.value < $1.value }
            case .failure(let error): self?.delegate?.publishError(error.localizedDescription)
            }
        }
    }

    func updateFeature(with id: Int, visible: Bool) {

    }
}
