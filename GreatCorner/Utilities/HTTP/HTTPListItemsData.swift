//
//  HTTPListItemsData.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import Foundation

//MARK:- Protocol

protocol GetItemsListData {
    func fetchListItems(completion: @escaping (Result<[ItemModel], Error>) -> Void)
}

//MARK:- Acces and send request

struct HTTPListItemsData: GetItemsListData {
    private let httpService: Network
    private let httpConfiguration: Configuration
    
    init(httpService: Network, httpConfiguration: Configuration) {
        self.httpService = httpService
        self.httpConfiguration = httpConfiguration
    }
    
    func fetchListItems(completion: @escaping (Result<[ItemModel], Error>) -> Void) {
        let httpRequest = HTTPRequest(
            baseUrl: httpConfiguration.url,
            endPoint: .itemsList
        )
        httpService.sendRequest(httpRequest, completion: completion)
    }
}
