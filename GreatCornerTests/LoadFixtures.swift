//
//  LoadFixtures.swift
//  GreatCornerTests
//
//  Created by Mathieu Chelim on 25/07/2021.
//

import Foundation
@testable import GreatCorner

class LoadFixtures {
    
    enum LoadFixturesError: Error {
            case resourceNotFound
            case decodingError
        }
    
    private static func loadFixture<T: Decodable>(resource: String) throws -> T {
        let bundle = Bundle(for: self)
        guard let path = bundle.path(forResource: resource, ofType: "json") else {
            throw LoadFixturesError.resourceNotFound
        }
        
        let fileUrl = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: fileUrl)
            let decodedObjects = try JSONDecoder().decode(T.self, from: data)
            return decodedObjects
        } catch {
            throw LoadFixturesError.decodingError
        }
    }
    
    static func loadItemsListViewModel() throws -> [ItemEntity] {
        do {
            let itemsModel: [ItemModel] = try loadFixture(resource: "itemsList")
            return itemsModel.map(ItemEntity.init)
        } catch let error as LoadFixturesError {
            throw error
        }
    }
    
    static func loadCategoriesList() throws -> [CategoryEntity] {
            let categoriesModel: [CategoryEntity] =  CategoryEntity.allCases
            return categoriesModel
            
    }

}
