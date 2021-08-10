enum MockFeatureType: String, Codable {
    case digit, unary, binary, online, clear, comma, equals
}

struct MockFeature: Codable, Hashable {
    public var labelText: String
    public var value: String
    public var type: MockFeatureType
    public var visible: Bool
    public var id: Int
}
