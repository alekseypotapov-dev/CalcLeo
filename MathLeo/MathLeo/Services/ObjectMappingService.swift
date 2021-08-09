import Foundation

protocol ObjectMappingServiceProtocol {
    associatedtype Object: Decodable

    func performMapping(with data: Data, callback: @escaping (Result<Object, Error>) -> Void)
}

struct PlistObjectMappingService<Object: Decodable>: ObjectMappingServiceProtocol {

    func performMapping(with data: Data, callback: @escaping (Result<Object, Error>) -> Void) {
        let decoder = PropertyListDecoder()

        do {
            let result = try decoder.decode(Object.self, from: data)
            callback(.success(result))
        } catch {
            print(error.localizedDescription)
            callback(.failure(error))
        }
    }
}

struct JsonObjectMappingService<Object: Decodable>: ObjectMappingServiceProtocol {

    func performMapping(with data: Data, callback: @escaping (Result<Object, Error>) -> Void) {
        let decoder = JSONDecoder()

        do {
            let result = try decoder.decode(Object.self, from: data)
            callback(.success(result))
        } catch {
            print(error.localizedDescription)
            callback(.failure(error))
        }
    }
}
