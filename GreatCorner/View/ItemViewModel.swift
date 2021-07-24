//
//  ItemViewModel.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import Foundation

struct ItemViewModel {
    
    let dateFormatter: DateFormatter = DateFormatter()
    
    let model: ItemEntity
    
    var category: CategoryEntity? { model.category }
    var isUrgent: Bool { model.isUrgent }
    
    // Convert the date string to a date for sorting
    var creationDate: Date? {
        let creationDate: Date?
        do {
            creationDate = try dateFormatter.date(from: model.creationDateString)
        } catch {
            creationDate = nil
        }
        return creationDate
    }
}
