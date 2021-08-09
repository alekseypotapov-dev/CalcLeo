struct OnlineResponse: Decodable {
    var bpi: BPI
}

struct BPI: Decodable {
    var USD: USD
}

struct USD: Decodable {
    let rate: String
    let rate_float: Float
}
