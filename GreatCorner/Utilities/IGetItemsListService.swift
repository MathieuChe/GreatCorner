//
//  IGetItemsListService.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import Foundation

//MARK:- Protocol

protocol IGetItemsListService {
    func fetchListItems(completion: @escaping (Result<[ItemEntity], ErrorService>) -> Void)
}

//MARK:- Class

final class ItemsListService: IGetItemsListService {
    private let dataAccessor: GetItemsListData
    
    init(dataAccessor: GetItemsListData) {
        self.dataAccessor = dataAccessor
    }
    
    func fetchListItems(completion: @escaping (Result<[ItemEntity], ErrorService>) -> Void) {
        dataAccessor.fetchListItems { (result: Result<[ItemModel], Error>) in
            completion(
                result.map { models -> [ItemEntity] in
                    models.map(ItemEntity.init)
                }
                .mapError { error -> ErrorService in
                    guard let httpError = error as? HTTPError else {
                        return ErrorService.unknown(error as NSError)
                    }
                    return ErrorService.makeFromHttpError(httpError)
                }
            )
        }
    }
}
