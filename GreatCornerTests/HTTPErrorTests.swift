//
//  HTTPErrorTests.swift
//  GreatCornerTests
//
//  Created by Mathieu Chelim on 25/07/2021.
//

import XCTest
@testable import GreatCorner

class HTTPErrorTests: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}
    
    private func makeHTTPURLResponse(with statusCode: Int) -> HTTPURLResponse? {
            let badRequest = HTTPURLResponse(
                url: URL(string: "www.leboncoin.fr")!,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil
            )
            return badRequest
        }
    
    func test_fromHTTPURLResponse_should_return_badRequest_statusCode_400() throws {
            guard let badRequest = makeHTTPURLResponse(with: 400) else {
                XCTFail("makeHTTPURLResponse returns nil")
                return
            }
            
            let httpError = HTTPError.fromHTTPURLResponse(badRequest)
            XCTAssertEqual(httpError, .badRequest)
        }

        func test_fromHTTPURLResponse_should_return_unauthorized_statusCode_401() throws {
            guard let badRequest = makeHTTPURLResponse(with: 401) else {
                XCTFail("makeHTTPURLResponse returns nil")
                return
            }
            
            let httpError = HTTPError.fromHTTPURLResponse(badRequest)
            XCTAssertEqual(httpError, .unauthorized)
        }
        
        func test_fromHTTPURLResponse_should_return_notFound_statusCode_404() throws {
            guard let badRequest = makeHTTPURLResponse(with: 404) else {
                XCTFail("makeHTTPURLResponse returns nil")
                return
            }
            
            let httpError = HTTPError.fromHTTPURLResponse(badRequest)
            XCTAssertEqual(httpError, .notFound)
        }
        
        func test_fromHTTPURLResponse_should_return_internalServerError_statusCode_500() throws {
            guard let badRequest = makeHTTPURLResponse(with: 500) else {
                XCTFail("makeHTTPURLResponse returns nil")
                return
            }
            
            let httpError = HTTPError.fromHTTPURLResponse(badRequest)
            XCTAssertEqual(httpError, .internalServerError)
        }

}
