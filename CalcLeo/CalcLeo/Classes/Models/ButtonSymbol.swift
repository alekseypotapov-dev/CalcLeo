enum ButtonSymbolType: String, Decodable {
    case digit, unary, binary, online, clear, comma, equals
}

struct ButtonSymbol: Decodable {
    var labelText: String
    var value: String
    var type: ButtonSymbolType
    var visible: Bool
    var column: Int
    var row: Int
}
