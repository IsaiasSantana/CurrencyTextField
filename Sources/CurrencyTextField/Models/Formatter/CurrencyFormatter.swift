//
//  CurrencyFormatter.swift
//  CurrencyTextField
//
//  Created by Isaías Santana on 08/12/24.
//

import Foundation

/// Implement this protocol if you want a custom behavior for the value shown in the TextField.
public protocol Formatter {
    /// Use this method to return the normalized value.
    /// - Parameter text: Text containing only numbers or an empty string from the TextField.
    /// - Returns: A normalized value to be displayed and used to update the @Binding property
    func value(from text: String) -> Decimal?

    /// Use this method to format the value that will be displayed in the `TextField`.
    /// Do not call ``value(from:)`` inside this method, because the `TextField` invokes it before calling ``formatted(_:)``.
    /// - Parameter value: The value to be formatted.
    /// - Returns: An `NSAttributedString` to be displayed.
    func formatted(_ value: Decimal) -> NSAttributedString
}

extension Formatter {
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
