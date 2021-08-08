@testable import MathLeo
import XCTest

final class ObjectMappingServiceTests: XCTestCase {

    func test_performMappingPlist_success() {
        let sut = PlistObjectMappingService<[[Feature]]>()

        var actual: Feature?

        guard let url = Bundle(for: type(of: self)).url(forResource: "Features-success", withExtension: "plist") else {
            XCTFail("file not found")
            return
        }

        sut.performMapping(with: url) { result in
            switch result {
            case .success(let objects): actual = objects.first?.first
            case .failure(let error): XCTFail("mapping failed: \(error.localizedDescription)")
            }
        }

        XCTAssertNotNil(actual, "parsing error")
    }
}
