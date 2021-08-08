import Foundation

enum FeatureProviderError: Error, CustomStringConvertible {
    case notFound
    public var description: String {
        switch self {
        case .notFound:
            return "File with features wasn't found!"
        }
    }
}

public class FeatureProvider {

    public init() {}

    private let plistObjectMappingService = PlistObjectMappingService<[[Feature]]>()
    private lazy var plistURL: URL? = {
        Bundle(for: type(of: self)).url(forResource: "Features", withExtension: "plist")
    }()

    public func performMapping(callback: @escaping (Result<[[Feature]], Error>) -> Void) {
        guard let url = plistURL else {
            callback(.failure(FeatureProviderError.notFound))
            return
        }
        
        plistObjectMappingService.performMapping(with: url, callback: callback)
    }
}
