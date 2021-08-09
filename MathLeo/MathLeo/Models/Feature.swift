public enum FeatureType: String, Decodable {
    case digit, unary, binary, online, clear, comma, equals
}

public struct Feature: Decodable, Hashable {
    public var labelText: String
    public var value: String
    public var type: FeatureType
    public var visible: Bool
    public var id: Int
}
