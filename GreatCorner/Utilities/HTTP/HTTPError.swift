//
//  HTTPError.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import Foundation

// Enum each LocalizedError cases
enum HTTPError: LocalizedError {
    case badRequest
    case unauthorized
    case notFound
    case internalServerError
    case decodingError
    case noData
    case unknown(Error)
    
    // Set Status Code of some LocalizedError cases
    private static func fromErrorStatusCode(_ statusCode: Int) -> HTTPError {
        switch statusCode {
        case 400:       return .badRequest
        case 401:       return .unauthorized
        case 404:       return .notFound
        case 500..<600: return .internalServerError
        default:        return .unknown(NSError())
        }
    }
    
    static func fromHTTPURLResponse(_ httpResponse: HTTPURLResponse) -> HTTPError {
        return fromErrorStatusCode(httpResponse.statusCode)
    }
    
    static func fromNSError(_ nsError: NSError) -> HTTPError {
        return fromErrorStatusCode(nsError.code)
    }
}

