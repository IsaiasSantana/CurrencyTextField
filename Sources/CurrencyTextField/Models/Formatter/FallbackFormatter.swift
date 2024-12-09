//
//  FallbackFormatter.swift
//  CurrencyTextField
//
//  Created by Isaías Santana on 08/12/24.
//

import Foundation
import SwiftUI

extension CurrencyField {
    struct FallbackFormatter: Formatter {
        let currencyCode: String
        let locale: Locale
        let decimalPlaces: Int
        let textAlignment: NSTextAlignment
        let font: UIFont
        let color: UIColor

        private let formatter = NumberFormatter()
        private let attributtedString = NSMutableAttributedString()

        init(
            currencyCode: String,
            locale: Locale,
            decimalPlaces: Int,
            textAlignment: NSTextAlignment = .center,
            font: UIFont = UIFont.systemFont(ofSize: 30),
            color: UIColor = UIColor.darkText
        ) {
            self.currencyCode = currencyCode
            self.locale = locale
            self.decimalPlaces = decimalPlaces
            self.textAlignment = textAlignment
            self.font = font
            self.color = color

            formatter.numberStyle = .currency
            formatter.currencyCode = currencyCode
            formatter.locale = locale
            formatter.maximumFractionDigits = decimalPlaces
            formatter.currencyCode = currencyCode
        }

        func value(from text: String) -> Decimal? {
            value(from: text, decimalPlaces: decimalPlaces)
        }

        func formatted(_ value: Decimal) -> NSAttributedString {
            let text = formatter.string(from: NSDecimalNumber(decimal: value)) ?? ""

            attributtedString.mutableString.setString(text)

            let paragraph: NSParagraphStyle = {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = textAlignment
                return paragraphStyle
            }()

            attributtedString.addAttributes(
                [
                    .foregroundColor: color,
                    .font: font,
                    .paragraphStyle: paragraph,
                ],
                range: .init(location: 0, length: (text as NSString).length)
            )

            return attributtedString
        }
    }
}
