//
//  HTTPConfiguration.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import Foundation

//MARK:- Protocols

protocol Configuration {
    var urlString: String { get }
}

struct HTTPConfiguration: Configuration {
    var urlString = "https://raw.githubusercontent.com/leboncoin/paperclip/master"
}

//MARK:- Extension

extension Configuration {
    var url: URL { URL(string: "\(urlString)")! }
}
