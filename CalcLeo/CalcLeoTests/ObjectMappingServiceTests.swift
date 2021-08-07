@testable import CalcLeo
import XCTest

final class ObjectMappingServiceTests: XCTestCase {

    func test_performMappingPlist_success() throws {
        let sut = ObjectMappingService<[ButtonSymbol]>()

        var actual: ButtonSymbol?

        guard let url = Bundle(for: type(of: self)).url(forResource: "Features-success", withExtension: "plist") else {
            XCTFail("file not found")
            return
        }

        sut.performMappingPlist(with: url) { result in
            switch result {
            case .success(let objects): actual = objects.first
            case .failure(let error): XCTFail("\(error)")
            }
        }

        XCTAssertNotNil(actual, "parsing error")
    }
}
