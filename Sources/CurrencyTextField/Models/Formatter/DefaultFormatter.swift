//
//  DefaultFormatter.swift
//  CurrencyTextField
//
//  Created by Isaías Santana on 08/12/24.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
extension CurrencyField {
    struct DefaultFormatter: Formatter {
        let currencyCode: String
        let locale: Locale
        let decimalPlaces: Int
        let textAlignment: NSTextAlignment
        let font: UIFont
        let color: UIColor
        let allowClearFieldWhenValueIsZero: Bool

        private let attributtedString = NSMutableAttributedString()

        init(
            currencyCode: String,
            locale: Locale,
            decimalPlaces: Int,
            textAlignment: NSTextAlignment = .center,
            font: UIFont = UIFont.systemFont(ofSize: 30),
            color: UIColor = UIColor.darkText,
            allowClearFieldWhenValueIsZero: Bool
        ) {
            self.currencyCode = currencyCode
            self.locale = locale
            self.decimalPlaces = decimalPlaces
            self.textAlignment = textAlignment
            self.font = font
            self.color = color
            self.allowClearFieldWhenValueIsZero = allowClearFieldWhenValueIsZero
        }

        func value(from text: String) -> Decimal? {
            value(from: text, decimalPlaces: decimalPlaces)
        }

        func formatted(_ value: Decimal) -> NSAttributedString {
            let text: String

            if allowClearFieldWhenValueIsZero && value == .zero {
                text = ""
            } else {
                text = value.formatted(
                    .currency(code: currencyCode)
                        .precision(.fractionLength(decimalPlaces))
                        .locale(locale)
                )
            }

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
