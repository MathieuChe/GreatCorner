//
//  ModelInitializable.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import Foundation

//MARK:- Protocol

// Set this protocol to initialize the model associated
protocol ModelInitializable {
    
    // Associate to Model type
    associatedtype Model
    init(from model: Model)
}
