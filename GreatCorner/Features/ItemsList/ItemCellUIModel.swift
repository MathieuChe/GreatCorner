//
//  ItemCellUIModel.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import Foundation

// MARK: - UI Model to configure ItemCollectionViewCell

protocol ItemCellUIModel {
    var title: String                       { get }
    var price: Double                       { get }
    var imageUrl: URL?                      { get }
    var categoryDescription: String?        { get }
    var isUrgentPictureImageName: String?   { get }
    var defaultPictureImageName: String     { get }
}

// MARK: - Item cell UI model conformance: can fill this kind of cell

extension ItemViewModel: ItemCellUIModel {
    
    var title: String                       { model.title }
    var imageUrl: URL?                      { model.imageEntity.smallImageUrl }
    var categoryDescription: String?        { model.category?.description }
    var price: Double                       { model.price }
    var isUrgentPictureImageName: String?   { model.isUrgentImageName }
    var defaultPictureImageName: String     { model.imageEntity.defaultImageName }
}
