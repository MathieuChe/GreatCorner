//
//  CategoryViewModel.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 24/07/2021.
//

import Foundation

struct CategoryViewModel: DataCollectionOrTableViewModel {
    
    var dataView: [CategoryEntity]
    
    init() {
        self.dataView = CategoryEntity.allCases
    }
}
