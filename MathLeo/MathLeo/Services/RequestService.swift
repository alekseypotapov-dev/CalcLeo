import Foundation

enum RequestServiceError: Error {
    case urlNotValid
    case responseError
    case dataNotExists
}

protocol RequestServiceProtocol {

    func requestData(with stringUrl: String, callback: @escaping (Result<Data, RequestServiceError>) -> Void)
}

struct RequestService: RequestServiceProtocol {

    func requestData(with stringUrl: String, callback: @escaping (Result<Data, RequestServiceError>) -> Void) {
        guard let url =  URL(string: stringUrl) else {
            callback(.failure(.urlNotValid))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                callback(.failure(.responseError))
                return
            } else if let data = data {
                callback(.success(data))
                return
            }
            callback(.failure(.dataNotExists))
        }

        task.resume()
    }
}
