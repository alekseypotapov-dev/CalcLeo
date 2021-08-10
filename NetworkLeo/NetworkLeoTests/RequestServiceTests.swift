import XCTest
@testable import NetworkLeo

final class RequestServiceTests: XCTestCase {

    func test_request_succeess() {
        let sut = RequestService()
        let expectation = expectation(description: "request test")

        do {
            try sut.requestData(with: "https://apple.com") { result in
                switch result {
                case .success( _ ): XCTAssertTrue(true)
                case .failure(let error): XCTFail(error.localizedDescription)
                }

                expectation.fulfill()
            }
        } catch {
            XCTFail(error.localizedDescription)
        }

        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }

    func test_request_fail() {
        let sut = RequestService()
        let expectation = expectation(description: "request test")
        
        do {
            try sut.requestData(with: "esuaeis") { result in
                switch result {
                case .success( _ ): XCTFail("shouldn't be success")
                case .failure( _ ): XCTAssertTrue(true)
                }
                
                expectation.fulfill()
            }
        } catch {
            XCTFail(error.localizedDescription)
        }

        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }

}
