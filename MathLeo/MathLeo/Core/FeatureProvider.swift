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
    private lazy var plistPath: String? = {
        guard let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return nil }
        return paths.appending("/\(plistNameWithExtension)")
    }()

    private func copyPlistFileToDocumentsDirectoryIfNeeded() throws {
        guard let plistPath = plistPath else {
            throw(FeatureProviderError.noSearchPathsForDirectories)
        }

        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: plistPath) {
            guard let bundlePath = Bundle(for: type(of: self)).path(forResource: plistName, ofType: plistExtension) else {
                throw FeatureProviderError.fileNotFound
            }
            try fileManager.copyItem(atPath: bundlePath, toPath: plistPath)
        }
    }

    public func provideFeatures(callback: @escaping (Result<[[Feature]], Error>) -> Void) {
        do {
            try copyPlistFileToDocumentsDirectoryIfNeeded()
        } catch {
            callback(.failure(error))
        }

        guard let plistPath = plistPath else {
            callback(.failure(FeatureProviderError.noSearchPathsForDirectories))
            return
        }

        do {
            let url = URL(fileURLWithPath: plistPath)
            let data = try Data(contentsOf: url)
            plistObjectMappingService.performMapping(with: data, callback: callback)
        } catch {
            callback(.failure(error))
        }
    }

    public func writeToFeaturePlist(with features: [[Feature]]) {
        guard let plistPath = plistPath else {
            return
        }

        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        do {
            let data = try encoder.encode(features)
            let url = URL(fileURLWithPath: plistPath)
            try data.write(to: url)
        } catch {
            // Handle error
            print(error)
        }

        //        var plist = NSMutableDictionary(contentsOfFile: plistPath)
        //        switch operation {
        //           case chipsOperation.add:
        //                plistDict.setValue("Value", forKey: "Key")
        //                break
        //           case chipsOperation.edit:
        //                plistDict["Key"] = "Value1"
        //                break
        //           case chipsOperation.delete:
        //                plistDict.removeObject(forKey: "Key")
        //                break
        //        }
        //        plistDict.write(toFile: path, atomically: true)

    }
}
