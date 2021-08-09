import Foundation
import MathLeo

protocol SettingsViewModelDelegate: AnyObject {
    func dataUpdated(models: [Feature])
    func publishError(_ message: String)
}

final class SettingsViewModel {

    weak var delegate: SettingsViewModelDelegate?
    private var features: [[Feature]]? {
        didSet {
            guard let features = features else { return }
            let sortedFeatures = features.reduce([], +).sorted { $0.value < $1.value }
            delegate?.dataUpdated(models: sortedFeatures)
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
            case .success(let objects): self?.features = objects
            case .failure(let error): self?.delegate?.publishError(error.localizedDescription)
            }
        }
    }

    func updateFeature(with id: Int, visible: Bool) {
        guard let features = features else { return }

        let newArr = features.map { $0.map { feature -> Feature in
            if feature.id == id {
                var updatedFeature = feature
                updatedFeature.updateVisibility(isVisible: visible)
                return updatedFeature
            } else {
                return feature
            }
        }}

        self.features = newArr
    }

    func updateFeaturesList() {
        guard let features = features else { return }

        featureProvider.writeToFeaturePlist(with: features)
    }
}
