import Foundation

enum FeatureProviderError: Error, CustomStringConvertible {
    case fileNotFound
    case noSearchPathsForDirectories

    public var description: String {
        switch self {
        case .fileNotFound: return "File with features wasn't found!"
        case .noSearchPathsForDirectories: return "No SearchPathDirectories"
        }
    }
}

public class FeatureProvider {

    public init() {}

    private let plistObjectMappingService = PlistObjectMappingService<[[Feature]]>()
    private lazy var plistName: String = { "Features" }()
    private lazy var plistExtension: String = { "plist" }()
    private lazy var plistNameWithExtension: String = { "\(self.plistName).\(plistExtension)" }()

    private func copyPlistFileToDocumentsDirectoryIfNeeded() throws {
        guard let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            throw FeatureProviderError.noSearchPathsForDirectories
        }

        let path = paths.appending("/\(plistNameWithExtension)")
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: path) {
            guard let bundlePath = Bundle(for: type(of: self)).path(forResource: plistName, ofType: plistExtension) else {
                throw FeatureProviderError.fileNotFound
            }
            try fileManager.copyItem(atPath: bundlePath, toPath: path)
        }
    }

    public func provideFeatures(callback: @escaping (Result<[[Feature]], Error>) -> Void) {
        do {
            try copyPlistFileToDocumentsDirectoryIfNeeded()
        } catch {
            callback(.failure(error))
        }

        guard let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            callback(.failure(FeatureProviderError.fileNotFound))
            return
        }
        let path = paths.appending("/\(plistNameWithExtension)")

        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            plistObjectMappingService.performMapping(with: data, callback: callback)
        } catch {
            callback(.failure(error))
        }
    }
}
