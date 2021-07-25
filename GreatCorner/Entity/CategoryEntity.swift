//
//  CategoryEntity.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import Foundation

// A type with a customized textual representation.
// A type that provides a collection of all of its values.

enum CategoryEntity: CustomStringConvertible, CaseIterable {
    
    case vehicule
    case mode
    case bricolage
    case maison
    case loisirs
    case immobilier
    case livres_CD_DVD
    case multimedia
    case service
    case animaux
    case enfants
    
    init?(category_id: Int) {
        switch category_id {
        case 1:
            self = .vehicule
        case 2:
            self = .mode
        case 3:
            self = .bricolage
        case 4:
            self = .maison
        case 5:
            self = .loisirs
        case 6:
            self = .immobilier
        case 7:
            self = .livres_CD_DVD
        case 8:
            self = .multimedia
        case 9:
            self = .service
        case 10:
            self = .animaux
        case 11:
            self = .enfants
        default:
            return nil
        }
    }
    
    var id: Int {
        
        // allCases from CaseIterable
        // Categories are starting at 1
        return Int((CategoryEntity.allCases.firstIndex(of: self) ?? 0 + 1))
    }
    
    // CustomStringConvertible
    
    var description: String {
        switch self {
        
        case .vehicule:
            return "Véhicule"
        case .mode:
            return "Mode"
        case .bricolage:
            return "Bricolage"
        case .maison:
            return "Maison"
        case .loisirs:
            return "Loisirs"
        case .immobilier:
            return "Immobilier"
        case .livres_CD_DVD:
            return "Livres/CD/DVD"
        case .multimedia:
            return "Multimédia"
        case .service:
            return "Service"
        case .animaux:
            return "Animaux"
        case .enfants:
            return "Enfants"
        }
    }
        
    init?(from category_id: Int) {
        guard let category = CategoryEntity(category_id: category_id) else {
            return nil
        }
        self = category
    }
}
