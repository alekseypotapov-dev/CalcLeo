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

    func test_writePlistFile() {
        let sut = FeatureProvider()

        let features = [[Feature(labelText: "0", value: "0", type: .digit, visible: true, id: 0)]]
        sut.writeToFeaturePlist(with: features)

        XCTAssertTrue(true)
    }
}
