//
//  ItemEntity.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

// Set Item Entity with attributes
struct ItemEntity: ModelInitializable {
    
    let id: Int
    let title: String
    let price: Double
    let category: Int
    let description: String
    let imageEntity: ImageEntity
    let creationDateString: String
    let isUrgent: Bool
        
    // Initialize attributes from model thanks to ModelInitializable
    init(from model: ItemModel) {
        self.id = model.id
        self.title = model.title
        self.price = model.price
        self.category = model.category_id
        self.description = model.description
        self.imageEntity = ImageEntity(from: model.images_url)
        self.creationDateString = model.creation_date
        self.isUrgent = model.is_urgent
    }
}
