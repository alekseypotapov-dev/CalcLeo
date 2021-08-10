struct MockOnlineResponse: Codable {
    var bpi: MockBPI
}

struct MockBPI: Codable {
    var USD: MockUSD
}

struct MockUSD: Codable {
    let rate: String
    let rate_float: Float
}
