//
//  CategoryModel.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 24/07/2021.
//

import Foundation

struct CategoryModel {
    let id: Int
    let name: String
}

extension CategoryModel: Decodable {}

