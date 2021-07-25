//
//  HTTPRequest.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import Foundation

//MARK:- protocol

protocol Request {
    var baseUrl: URL { get }
}

struct HTTPRequest: Request {
    let baseUrl: URL
    let endPoint: HTTPEndPoint

    var resourceUrl: URL? {
        return URL(string: baseUrl.absoluteString + endPoint.description)
    }
}
