@testable import MathLeo
import XCTest

final class FeatureProviderTests: XCTestCase {

    func test_readPlistFile() {
        let sut = FeatureProvider()

        sut.provideFeatures { result in
            switch result {
            case .success(let features): XCTAssertTrue(features.count > 0)
            case .failure(let error): XCTFail("\(error.localizedDescription)")
            }
        }
    }
}
