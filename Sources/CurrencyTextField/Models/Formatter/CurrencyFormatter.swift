//
//  CurrencyFormatter.swift
//  CurrencyTextField
//
//  Created by Isaías Santana on 08/12/24.
//

import Foundation

extension CurrencyField {
    /// Implements this protocol if you want a custom behavior to the valued showed in the TextField.
    public protocol Formatter {
        /// Use this method to return the `value` normalized.
        /// - Parameter text: text with only numbers or an empty string from the TextField.
        /// - Returns: A normalized value to be displayed and update the binded value.
        func value(from text: String) -> Decimal?

        /// Use this method to format the value that will be displayed on TextField. Don't call ``value(from:)``  inside this method, because the
        /// Textfield invokes it before to call ``formatted(_:)``.
        /// - Parameter value: the value to formatted,
        /// - Returns: An `NSAttributedString` to be displayed.
        func formatted(_ value: Decimal) -> NSAttributedString
    }
}

extension CurrencyField.Formatter {
    func value(from text: String, decimalPlaces: Int) -> Decimal? {
        if text.isEmpty {
            return 0
        }

        guard let value = Decimal(string: text) else {
            return nil
        }

        return value / pow(10, decimalPlaces)
    }
}
