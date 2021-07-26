//
//  ItemModel.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import Foundation

// Set Item Model as decodable when decoding json data from API
struct ItemModel {
    let id: Int
    let title: String
    let price: Double
    let category_id: Int
    let description: String
    
    // Two size of images_url defined in ImageModel
    let images_url: ImageModel
    let creation_date: String
    let is_urgent: Bool
}

extension ItemModel: Decodable {}
