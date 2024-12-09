//
//  CurrencyTextFie.swift
//  CurrencyTextField
//
//  Created by Isaías Santana on 05/12/24.
//

import Foundation
import SwiftUI

extension CurrencyField {
    public struct Configuration {
        public let placeholder: NSAttributedString?
        public let maximumValue: Decimal
        public let formatter: Formatter
        public let displayCaret: Bool
        public let caretColor: UIColor?
        public let displayDoneButtonAsAccessory: Bool
        public let allowClearFieldWhenValueIsZero: Bool
        public let adjustsFontSizeToFitWidth: Bool
        public let minimumFontSize: CGFloat
        public let onFocusChanged: ((Bool) -> Void)?

        public init(
            placeholder: NSAttributedString? = nil,
            textColor: UIColor = .systemGray,
            textAligment: NSTextAlignment = .center,
            font: UIFont = .systemFont(ofSize: 30),
            locale: Locale = .autoupdatingCurrent,
            currencyCode: String,
            maximumValue: Decimal = 1_000_000_000_000,
            decimalPlaces: Int = 2,
            displayCaret: Bool = true,
            caretColor: UIColor? = nil,
            displayDoneButtonAsAccessory: Bool = true,
            allowClearFieldWhenValueIsZero: Bool = false,
            adjustsFontSizeToFitWidth: Bool = false,
            minimumFontSize: CGFloat = 0.0,
            onFocusChanged: ((Bool) -> Void)? = nil
        ) {
            self.placeholder = placeholder
            self.maximumValue = maximumValue

            if #available(iOS 15.0, *) {
                self.formatter = DefaultFormatter(
                    currencyCode: currencyCode,
                    locale: locale,
                    decimalPlaces: decimalPlaces < 0 ? 2 : decimalPlaces,
                    textAlignment: textAligment,
                    font: font,
                    color: textColor)
            } else {
                self.formatter = FallbackFormatter(
                    currencyCode: currencyCode,
                    locale: locale,
                    decimalPlaces: decimalPlaces,
                    textAlignment: textAligment,
                    font: font,
                    color: textColor)
            }

            self.displayCaret = displayCaret
            self.caretColor = caretColor
            self.displayDoneButtonAsAccessory = displayDoneButtonAsAccessory
            self.allowClearFieldWhenValueIsZero = allowClearFieldWhenValueIsZero
            self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
            self.minimumFontSize = minimumFontSize
            self.onFocusChanged = onFocusChanged
        }

        public init(
            formatter: Formatter,
            placeholder: NSAttributedString? = nil,
            maximumValue: Decimal = 1_000_000_000_000,
            displayCaret: Bool = true,
            caretColor: UIColor? = nil,
            displayDoneButtonAsAccessory: Bool = true,
            allowClearFieldWhenValueIsZero: Bool = false,
            adjustsFontSizeToFitWidth: Bool = false,
            minimumFontSize: CGFloat = 0.0,
            onFocusChanged: ((Bool) -> Void)? = nil
        ) {
            self.formatter = formatter
            self.placeholder = placeholder
            self.maximumValue = maximumValue
            self.displayCaret = displayCaret
            self.displayDoneButtonAsAccessory = displayDoneButtonAsAccessory
            self.allowClearFieldWhenValueIsZero = allowClearFieldWhenValueIsZero
            self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
            self.minimumFontSize = minimumFontSize
            self.onFocusChanged = onFocusChanged
            self.caretColor = caretColor
        }
    }
}
