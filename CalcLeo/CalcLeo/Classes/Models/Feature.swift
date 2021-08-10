public enum FeatureType: String, Codable {
    case digit, unary, binary, online, clear, comma, equals
}

public struct Feature: Codable, Hashable {
    public var labelText: String
    public var value: String
    public var type: FeatureType
    public var visible: Bool
    public var id: Int

    mutating public func updateVisibility(isVisible: Bool) {
        visible = isVisible
    }
}
