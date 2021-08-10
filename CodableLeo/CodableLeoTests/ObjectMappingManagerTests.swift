import XCTest
@testable import CodableLeo

final class ObjectMappingManagerTests: XCTestCase {

    func test_decodePlist() {
        let sut = PlistObjectMappingManager<[[MockFeature]]>()

        guard let url = Bundle(for: type(of: self)).url(forResource: "MockFeaturesFile", withExtension: "plist") else {
            XCTFail("File not found!")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            XCTAssertNoThrow(try sut.decode(data))
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func test_encodePist() {
        let sut = PlistObjectMappingManager<[[MockFeature]]>()

        let object = [[MockFeature(labelText: "0", value: "0", type: .digit, visible: true, id: 0)]]
        XCTAssertNoThrow(try sut.encode(object))

    }

    func test_decodeJSON() {
        let sut = JsonObjectMappingManager<MockOnlineResponse>()

        guard let url = Bundle(for: type(of: self)).url(forResource: "MockOnlineResponseFile", withExtension: "json") else {
            XCTFail("file not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            XCTAssertNoThrow(try sut.decode(data))
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func test_encodeJSON() {
        let sut = JsonObjectMappingManager<MockOnlineResponse>()
        let object = MockOnlineResponse(bpi: MockBPI(USD: MockUSD(rate: "1", rate_float: 1.0)))

        XCTAssertThrowsError(try sut.encode(object))
    }
}
