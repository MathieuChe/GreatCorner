//
//  ImageEntity.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import Foundation

// Set Image Entity with attributes

struct ImageEntity: ModelInitializable {
    let smallImageUrl: URL?
    let thumbImageUrl: URL?
    let defaultImageName: String
    
    init(from model: ImageModel) {
        self.smallImageUrl = URL(string: model.small ?? "")
        self.thumbImageUrl = URL(string: model.thumb ?? "")
        self.defaultImageName = "No_photo"
    }
}
