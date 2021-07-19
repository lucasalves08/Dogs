//
//  DogServiceTests.swift
//  DogsTests
//
//  Created by Lucas Alves Dos Santos on 19/07/21.
//

import XCTest
@testable import Dogs

class DogServiceTests: XCTestCase {
    let service = DogService.sharedInstance
    let timeout: TimeInterval = 5.0

    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        service.urlSession = urlSession
    }

    func testGetBreedList() throws {
        let serviceExpectation = expectation(description: "Service response should be returned")
        let url = DogService.Endpoint.listAllBreeds.url

        let jsonString = """
                    {
                        "message": {
                            "affenpinscher": [],
                            "african": [],
                            "airedale": [],
                            "akita": [],
                            "appenzeller": [],
                            "australian": [
                                "shepherd"
                            ]
                        }
                    }
                    """

        let data = jsonString.data(using: .utf8)
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data, nil)
        }

        service.getBreedsList { breeds, error in
            XCTAssertNotNil(breeds)
            XCTAssertEqual(breeds?.count, 6)
            XCTAssertNil(error)
            serviceExpectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }

    func testGetBreedListFailure() throws {
        let serviceExpectation = expectation(description: "Service response should be returned")
        let url = DogService.Endpoint.listAllBreeds.url
        let errorMessage = ["error": "dummy error"]
        let expectedError = NSError(domain: "", code: 1, userInfo: errorMessage)

        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: url, statusCode: 400, httpVersion: nil, headerFields: nil)!
            return (response, Data(), expectedError)
        }

        service.getBreedsList { breeds, error in
            XCTAssertNil(breeds)
            XCTAssertNotNil(error)
            serviceExpectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }    
}
