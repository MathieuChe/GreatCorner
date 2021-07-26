//
//  ItemEntity.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import Foundation

// Set Item Entity with attributes
struct ItemEntity {
    
    let id: Int
    let title: String
    let price: Float
    let category: CategoryEntity?
    let description: String
    let imageEntity: ImageEntity
    let creationDateString: String
    let isUrgent: Bool
    
    var isUrgentImageName: String? {
        if isUrgent {
            return "is_urgent"
        } else {
            return nil
        }
    }
    
    // Initialize attributes from model thanks to ModelInitializable
    init(from model: ItemModel) {
        self.id = model.id
        self.title = model.title
        self.price = model.price
        self.category = CategoryEntity(category_id: model.category_id)
        self.description = model.description
        self.imageEntity = ImageEntity(from: model.images_url)
        self.creationDateString = model.creation_date
        self.isUrgent = model.is_urgent
    }
}

extension ItemEntity: ModelInitializable {}
