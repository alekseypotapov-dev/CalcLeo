struct OnlineResponse: Codable {
    var bpi: BPI
}

struct BPI: Codable {
    var USD: USD
}

struct USD: Codable {
    let rate: String
    let rate_float: Float
}
