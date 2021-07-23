//
//  ImageEntity.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import Foundation

struct ImageEntity: ModelInitializable {
    let smallImageUrl: URL?
    let thumbImageUrl: URL?
    
    init(from model: ImageModel) {
        self.smallImageUrl = URL(string: model.small ?? "")
        self.thumbImageUrl = URL(string: model.large ?? "")
    }
}
