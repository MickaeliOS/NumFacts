//
//  NumFactsTests.swift
//  NumFactsTests
//
//  Created by Mickaël Horn on 05/03/2024.
//

@testable import NumFacts
import XCTest
import Combine

class FactViewModelTests: XCTestCase {
    // MARK: - PROPERTIES
    private var cancellables: Set<AnyCancellable>!
    private var expectFact: XCTestExpectation!
    private var expectError: XCTestExpectation!
    private var sut: FactView.ViewModel!

    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }()

    private lazy var apiService: APIService = {
        APIService(session: session)
    }()

    // MARK: - SETUP
    override func setUp() {
        super.setUp()

        MockURLProtocol.requestHandler = nil
        sut = FactView.ViewModel(apiService: apiService)
        cancellables = []
        expectFact = XCTestExpectation(description: "fact is updated")
        expectError = XCTestExpectation(description: "errorMessage remains nil")
    }

    // MARK: - TESTS
    func testFetchFactSuccess() {
        MockURLProtocol.requestHandler = { _ in
            return (DataResponse.responseOK, DataResponse.mockData)
        }

        sut.$fact
            .dropFirst()
            .sink { fact in
                if let fact = fact {
                    let expectedData = "1 is the number of dimensions of a line."
                    XCTAssertEqual(fact.text, expectedData)
                } else {
                    XCTFail("Error, fact should not be nil.")
                }

                self.expectFact.fulfill()
            }
            .store(in: &cancellables)

        sut.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                if errorMessage != nil {
                    XCTFail("Error, errorMessage should be nil.")
                }

                self.expectError.fulfill()
            }
            .store(in: &cancellables)

        sut.number = "1"
        wait(for: [expectFact, expectError], timeout: 5.0)
    }

    func testFetchFactThrowsInvalidResponseError() {
        MockURLProtocol.requestHandler = { _ in
            return (DataResponse.responseKO, DataResponse.mockData)
        }

        sut.$fact
            .dropFirst()
            .sink { fact in
                if fact != nil {
                    XCTFail("Error, fact should be nil.")
                }

                self.expectFact.fulfill()
            }
            .store(in: &cancellables)

        sut.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                if let errorMessage = errorMessage {
                    XCTAssertEqual(errorMessage, "We couldn't get the fact, please select another number.")
                } else {
                    XCTFail("Error, errorMessage should not be nil.")
                }

                self.expectError.fulfill()
            }
            .store(in: &cancellables)

        sut.number = "1"
        wait(for: [expectFact, expectError], timeout: 5.0)
    }

    func testFetchFactThrowsDecodingError() {
        MockURLProtocol.requestHandler = { _ in
            return (DataResponse.responseOK, DataResponse.incorrectData)
        }

        sut.$fact
            .dropFirst()
            .sink { fact in
                if fact != nil {
                    XCTFail("Error, fact should be nil.")
                }

                self.expectFact.fulfill()
            }
            .store(in: &cancellables)

        sut.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                if let errorMessage = errorMessage {
                    XCTAssertEqual(errorMessage, "An error occured, please enter another number.")
                } else {
                    XCTFail("Error, errorMessage should not be nil.")
                }

                self.expectError.fulfill()
            }
            .store(in: &cancellables)

        sut.number = "1"
        wait(for: [expectFact, expectError], timeout: 5.0)
    }
}
