//
//  ItemsTests.swift
//  GreatCornerTests
//
//  Created by Mathieu Chelim on 25/07/2021.
//

import XCTest
@testable import GreatCorner

fileprivate struct HTTPConfiguration: Configuration {
    var urlString: String = "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json"
}

fileprivate struct HTTPService: Network {
    let fetchHTTPServiceExpectation: XCTestExpectation?
    let fetchHTTPRequestExpectation: XCTestExpectation?
    
    func sendRequest<T>(_ request: Request, completion: @escaping NetworkCompletion<T>) where T : Decodable {
        
        fetchHTTPServiceExpectation?.fulfill()
        
        if let httpRequest = request as? HTTPRequest,
           httpRequest.endPoint == .itemsList,
           httpRequest.baseUrl == URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")! {
            fetchHTTPRequestExpectation?.fulfill()
        }
    }
}

final class HTTPItemsListDataAccessTests: XCTestCase {
    
    private var dataAccessor: HTTPListItemsData!
    private let configuration = HTTPConfiguration()
    
    override func setUpWithError() throws {}
    
    override func tearDownWithError() throws {}
    
    func test_fetchItemsList_call_network() {
        let fetchHTTPServiceExpectation = expectation(description: "Call Network fetchListItems method")
        let networkService = HTTPService(fetchHTTPServiceExpectation: fetchHTTPServiceExpectation, fetchHTTPRequestExpectation: nil)
        dataAccessor = HTTPListItemsData(httpService: networkService, httpConfiguration: configuration)
        
        dataAccessor.fetchListItems { _ in }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func test_fetchItemsList_send_HTTPRequest() {
        let fetchHTTPRequestExpectation = expectation(description: "Send correct HTTPRequest object")
        let networkService = HTTPService(fetchHTTPServiceExpectation: nil, fetchHTTPRequestExpectation: fetchHTTPRequestExpectation)
        dataAccessor = HTTPListItemsData(httpService: networkService, httpConfiguration: configuration)
        
        dataAccessor.fetchListItems { _ in }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}
