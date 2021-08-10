import Foundation
import CodableLeo
import DatabaseLeo

protocol SettingsViewModelDelegate: AnyObject {
    func dataUpdated(models: [Feature])
}

final class SettingsViewModel: BaseViewModelProtocol {

    weak var delegate: SettingsViewModelDelegate?
    private var models: [[Feature]]? {
        didSet {
            guard let models = models else { return }
            let sortedModels = models.reduce([], +).sorted { $0.value < $1.value }
            delegate?.dataUpdated(models: sortedModels)
        }
    }

    private lazy var databaseManager: DatabaseManager = {
        return DatabaseManager(fileName: "Features", fileExtension: "plist", bundlePath: Bundle(for: type(of: self)).bundlePath)
    }()

    private lazy var plistObjectMappingManager = PlistObjectMappingManager<[[Feature]]>()

    init(delegate: SettingsViewModelDelegate?) {
        self.delegate = delegate
    }

    func prepareObjects() throws {
        let data = try databaseManager.readData()
        self.models = try plistObjectMappingManager.decode(data)
    }

    func updateFeature(with id: Int, visible: Bool) {
        guard let models = models else { return }

        let newArray = models.map { $0.map { feature -> Feature in
            if feature.id == id {
                var updatedFeature = feature
                updatedFeature.updateVisibility(isVisible: visible)
                return updatedFeature
            } else {
                return feature
            }
        }}

        self.models = newArray
    }

    func updateFeaturesList() throws {
        guard let features = models else { return }

        let data = try plistObjectMappingManager.encode(features)
        try databaseManager.writeData(data)
    }
}
