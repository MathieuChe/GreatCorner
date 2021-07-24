//
//  DateFormatter.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 24/07/2021.
//

import Foundation

// To handle badDateFormat
enum DateFormatterError: LocalizedError {
        case badDateFormat
    }

// Set the date as a string ISO formatted
final class DateFormatter {
    private lazy var dateISOFormatter: ISO8601DateFormatter = {
        let dateFormattor = ISO8601DateFormatter()
        return dateFormattor
    }()
    
    func date(from string: String) throws -> Date {
            guard let date = dateISOFormatter.date(from: string) else {
                throw DateFormatterError.badDateFormat
            }
            
            return date
        }
}
