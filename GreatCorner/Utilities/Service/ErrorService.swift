//
//  ErrorService.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import Foundation

enum ErrorService: LocalizedError {
    case serverError
    case appError
    case unauthorizedUser
    case unknown(NSError)
    
    var errorDescription: String? {
        // Descriptions should be localized
        switch self {
        case .serverError:          return "Server Issue, Please try again later."
        case .appError:             return "Issue happened, please contact us."
        case .unauthorizedUser:     return "Resource you're trying to get is not available. You should be logged to have an access."
        case .unknown(let nsError): return "Unknown error: \(nsError.localizedDescription)"
        }
    }
    
    static func fromHttpError(_ httpError: HTTPError) -> Self {
        switch httpError {
        case .internalServerError, .noData:             return .serverError
        case .badRequest, .decodingError, .notFound:    return .appError
        case .unauthorized:                             return .unauthorizedUser
        case .unknown(let error as NSError):            return .unknown(error)
        }
    }
}
