import Foundation

public enum RequestServiceError: Error, CustomStringConvertible {
    case urlNotValid
    case responseError
    case dataNotExists
    case noInternetConnection

    public var description: String {
        switch self {
        case .dataNotExists: return "Data not exsists"
        case .responseError: return "ResponseError"
        case .urlNotValid: return "Url not valid"
        case .noInternetConnection: return "No internet connection"
        }
    }
}

public protocol RequestServiceProtocol {

    func requestData(with stringUrl: String, callback: @escaping (Result<Data, RequestServiceError>) -> Void) throws
}

public struct RequestService: RequestServiceProtocol {

    public init() {}
    
    public func requestData(with stringUrl: String, callback: @escaping (Result<Data, RequestServiceError>) -> Void) throws {
        guard NetworkService.isAvailable else {
            throw RequestServiceError.noInternetConnection
        }

        guard let url =  URL(string: stringUrl) else {
            throw RequestServiceError.urlNotValid
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                callback(.failure(.responseError))
            } else if let data = data {
                callback(.success(data))
            } else {
                callback(.failure(.dataNotExists))
            }
        }

        task.resume()
    }
}
