//
//  ItemDetailsViewUIModel.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 25/07/2021.
//

import Foundation

// MARK: - UI Model to fill ItemDetailsView

protocol ItemDetailsViewUIModel {
    var idString: String                { get }
    var titleString: String             { get }
    var descriptionString: String       { get }
    var categoryIdString: String        { get }
    var priceString: String             { get }
    var smallImageUrlString: String     { get }
    var smallImageUrl: URL?             { get }
    var largeImageUrlString: String     { get }
    var largeImageUrl: URL?             { get }
    var creationDateString: String      { get }
    var isUrgentString: String          { get }
}

// MARK: - ItemDetails View  UI model conformance: can fill this kind of view

extension ItemViewModel: ItemDetailsViewUIModel {
    
    var idString: String            { "id: \(model.id)" }
    var titleString: String         { "Title: \(model.title)" }
    var descriptionString: String   { "Description: \(model.description)" }
    var creationDateString: String  { "Creation date: \(model.creationDateString)" }
    var isUrgentString: String      { "isUrgent: \(model.isUrgent.description)" }
    var smallImageUrl: URL?         { model.imageEntity.smallImageUrl }
    var largeImageUrl: URL?         { model.imageEntity.thumbImageUrl }
    
    
    var priceString: String {
        let currencyString: String
        do {
            currencyString = try currencyFormatter.currency(from: model.price)
        } catch CurrencyFormatterError.badCurrencyFormat {
            currencyString = "Bad format"
        } catch {
            currencyString = "\(error.localizedDescription)"
        }

        return "Price: \(currencyString)"
    }
    
    var categoryIdString: String {
        guard let id = model.category else { return "Category id: no id" }
        return "Category id: \(id)"
    }
    
    var smallImageUrlString: String  {
        guard let url = model.imageEntity.smallImageUrl else { return "Error: no url for small image" }
        return "\(url)"
    }
    
    var largeImageUrlString: String  {
        guard let url = model.imageEntity.thumbImageUrl else { return "Error: no url for large image" }
        return "\(url)"
    }
}
