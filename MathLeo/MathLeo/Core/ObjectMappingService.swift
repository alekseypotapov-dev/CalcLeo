import Foundation

protocol ObjectMappingServiceProtocol {
    associatedtype Object: Decodable

    func performMapping(with url: URL, callback: @escaping (Result<Object, Error>) -> Void)
}

struct PlistObjectMappingService<Object: Decodable>: ObjectMappingServiceProtocol {

    func performMapping(with url: URL, callback: @escaping (Result<Object, Error>) -> Void) {
        let decoder = PropertyListDecoder()

        do {
            let data = try Data(contentsOf: url)
            do {
                let result = try decoder.decode(Object.self, from: data)
                callback(.success(result))
            } catch {
                print(error.localizedDescription)
                callback(.failure(error))
            }
        } catch {
            callback(.failure(error))
        }
    }
}
