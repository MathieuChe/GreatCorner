//
//  HTTPEndPoint.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import Foundation

// Set the case as a String and return value
enum HTTPEndPoint: CustomStringConvertible {
    case itemsList
    case categoriesList
    
    var description: String {
        switch self {
        case .itemsList: return "/listing.json"
        case .categoriesList: return "/categories.json"
        }
    }
}


