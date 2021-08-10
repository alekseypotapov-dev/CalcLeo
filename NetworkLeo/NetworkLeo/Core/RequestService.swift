import Foundation

public enum RequestServiceError: Error, CustomStringConvertible {
    case urlNotValid
    case responseError
    case dataNotExists

    public var description: String {
        switch self {
        case .dataNotExists: return "Data not exsists"
        case .responseError: return "ResponseError"
        case .urlNotValid: return "Url not valid"
        }
    }
}

public protocol RequestServiceProtocol {

    func requestData(with stringUrl: String, callback: @escaping (Result<Data, RequestServiceError>) -> Void)
}

public struct RequestService: RequestServiceProtocol {

    public func requestData(with stringUrl: String, callback: @escaping (Result<Data, RequestServiceError>) -> Void) {
        guard let url =  URL(string: stringUrl) else {
            callback(.failure(.urlNotValid))
            return
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
