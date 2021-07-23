//
//  HTTPConfiguration.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import Foundation

//MARK:- Protocols

protocol Configuration {
    var netProtocol: String { get }
    var domain: String { get }
    var path: String { get }
}

struct HTTPConfiguration: Configuration {
    var netProtocol = "https://"
    var domain = "raw.githubusercontent.com/"
    var path = "leboncoin/paperclip/master"
}

//MARK:- Extension

extension Configuration {
    var url: URL { URL(string: "\(netProtocol)\(domain)\(path)")! }
}
