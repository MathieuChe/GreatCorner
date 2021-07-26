//
//  CurrencyFormatter.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 26/07/2021.
//

import Foundation

// To handle badDateFormat
enum CurrencyFormatterError: LocalizedError {
    case badCurrencyFormat
}

// Set the currency as a string ISO formatted
final class CurrencyFormatter {
    private lazy var currencyFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "€"
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.locale = Locale(identifier: "fr_FR")
        return numberFormatter
    }()
    
    func currency(from double: Double) throws -> String {
        guard let currencyString = currencyFormatter.string(from: NSNumber(value: double)) else {
            throw CurrencyFormatterError.badCurrencyFormat
        }
        
        return currencyString
    }
}
