import Foundation

enum ObjectMappingServiceError: Error {
    case invalidData
}

protocol ObjectMappingServiceProtocol {
    associatedtype Object: Decodable

    func performMappingPlist(with url: URL, callback: @escaping (Result<Object, Error>) -> Void)
}

struct ObjectMappingService<Object: Decodable>: ObjectMappingServiceProtocol {

    func performMappingPlist(with url: URL, callback: @escaping (Result<Object, Error>) -> Void) {
        let decoder = PropertyListDecoder()
        
        do {
            let data = try Data(contentsOf: url)
            do {
                let result: Object = try decoder.decode(Object.self, from: data)
                callback(.success(result))
            } catch {
                callback(.failure(error))
            }
        } catch {
            callback(.failure(error))
        }
    }
}
