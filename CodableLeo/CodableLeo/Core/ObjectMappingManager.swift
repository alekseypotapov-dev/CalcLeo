import Foundation

public enum ObjectMappingManagerError: Error, CustomStringConvertible {
    case notImplemented

    public var description: String {
        switch self {
        case .notImplemented: return "Function not implemented"
        }
    }
}

public protocol ObjectMappingManagerProtocol {
    associatedtype Object: Codable

    func decode(_ data: Data) throws -> Object
    func encode(_ object: Object) throws -> Data
}

public struct PlistObjectMappingManager<Object: Codable>: ObjectMappingManagerProtocol {

    public init() {}

    public func decode(_ data: Data) throws -> Object {
        let decoder = PropertyListDecoder()

        let result = try decoder.decode(Object.self, from: data)

        return result
    }

    public func encode(_ object: Object) throws -> Data {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml

        let data = try encoder.encode(object)

        return data
    }
}

public struct JsonObjectMappingManager<Object: Codable>: ObjectMappingManagerProtocol {

    public init() {}

    public func decode(_ data: Data) throws -> Object {
        let decoder = JSONDecoder()

        let result = try decoder.decode(Object.self, from: data)
        return result
    }

    public func encode(_ object: Object) throws -> Data {
        throw ObjectMappingManagerError.notImplemented
    }
}
