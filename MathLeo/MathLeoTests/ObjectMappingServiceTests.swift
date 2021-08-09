@testable import MathLeo
import XCTest

final class ObjectMappingServiceTests: XCTestCase {

    func test_performMappingPlist_Feature() {
        let sut = PlistObjectMappingService<[[Feature]]>()

        var actual: Feature?

        guard let url = Bundle(for: type(of: self)).url(forResource: "Features-success", withExtension: "plist") else {
            XCTFail("file not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            sut.performMapping(with: data) { result in
                switch result {
                case .success(let objects): actual = objects.first?.first
                case .failure(let error): XCTFail("mapping failed: \(error.localizedDescription)")
                }
            }
        } catch {
            XCTFail(error.localizedDescription)
        }

        XCTAssertNotNil(actual, "parsing error")
    }

    func test_performMappingJSON_BPI() {
        let sut = JsonObjectMappingService<OnlineResponse>()

        var actual: String?

        guard let url = Bundle(for: type(of: self)).url(forResource: "Cryptocurrency", withExtension: "json") else {
            XCTFail("file not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            sut.performMapping(with: data) { result in
                switch result {
                case .success(let onlineResponse): actual = onlineResponse.bpi.USD.rate
                case .failure(let error): XCTFail("mapping failed: \(error.localizedDescription)")
                }
            }
        } catch {
            XCTFail(error.localizedDescription)
        }

        XCTAssertNotNil(actual, "parsing error")
    }
}
