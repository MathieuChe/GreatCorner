//
//  ImageModel.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import Foundation

// Set Image Model as decodable when decoding json data from API
struct ImageModel {
    let small: String?
    let thumb: String?
}

extension ImageModel: Decodable {}
