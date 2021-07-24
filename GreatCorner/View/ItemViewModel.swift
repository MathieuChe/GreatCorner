//
//  ItemViewModel.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import Foundation

struct ItemViewModel {
    
    let model: ItemEntity
    
    var category: CategoryEntity? { model.category }
    var isUrgent: Bool { model.isUrgent }
    
    var creationDate: String {model.creationDateString }
}
