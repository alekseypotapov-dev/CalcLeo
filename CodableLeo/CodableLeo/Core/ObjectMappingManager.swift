import Foundation

enum ObjectMappingManagerError: Error, CustomStringConvertible {
    case notImplemented

    var description: String {
        switch self {
        case .notImplemented: return "Function not implemented"
        }
    }
}

protocol ObjectMappingManagerProtocol {
    associatedtype Object: Codable

    func decode(_ data: Data) throws -> Object
    func encode(_ object: Object) throws -> Data
}

struct PlistObjectMappingManager<Object: Codable>: ObjectMappingManagerProtocol {

    func decode(_ data: Data) throws -> Object {
        let decoder = PropertyListDecoder()

        let result = try decoder.decode(Object.self, from: data)

        return result
    }

    func encode(_ object: Object) throws -> Data {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml

        let data = try encoder.encode(object)

        return data
    }
}

struct JsonObjectMappingManager<Object: Codable>: ObjectMappingManagerProtocol {

    func decode(_ data: Data) throws -> Object {
        let decoder = JSONDecoder()

        let result = try decoder.decode(Object.self, from: data)
        return result
    }

    func encode(_ object: Object) throws -> Data {
        throw ObjectMappingManagerError.notImplemented
    }
}
