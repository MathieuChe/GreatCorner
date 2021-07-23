//
//  ImageModel.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import Foundation

// Set Image Model as decodable when decoding json data from API
struct ImageModel: Decodable {
    let small: String?
    let large: String?
}
