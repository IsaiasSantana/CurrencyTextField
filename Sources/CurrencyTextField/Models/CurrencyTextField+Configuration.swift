//
//  CurrencyTextFie.swift
//  CurrencyTextField
//
//  Created by Isaías Santana on 05/12/24.
//

import Foundation
import SwiftUI

extension CurrencyField {
    /// Use this struct to configure a ``CurrencyField``.
    public struct Configuration {
        /// The attributed string that displays when there is no other text in the text field.
        public let placeholder: NSAttributedString?

        /// the maximum allowed value of the ``CurrencyField``.
        public let maximumValue: Decimal

        /// A ``Formatter`` used with the ``CurrencyField``.
        public let formatter: Formatter

        /// if `true` the caret will be displayed
        public let displayCaret: Bool

        /// The color of the caret
        public let caretColor: UIColor?

        /// `true` to show an accessory view in the keyboard.
        public let displayDoneButtonAsAccessory: Bool

        /// If `true`, the `TextField` will clear its content.
        public let allowClearFieldWhenValueIsZero: Bool

        /// The text alignment.
        public let textAligment: NSTextAlignment

        /// See [Apple doc](https://developer.apple.com/documentation/uikit/uitextfield/adjustsfontsizetofitwidth)
        public let adjustsFontSizeToFitWidth: Bool

        /// See [Apple doc](https://developer.apple.com/documentation/uikit/uitextfield/minimumfontsize)
        public let minimumFontSize: CGFloat

        /// Checks whether the keyboard is the first responder.
        public let onFocusChanged: ((Bool) -> Void)?

        /// Instantiates a ``Configuration`` using a default formatter.
        /// - Parameters:
        ///   - formatter: The Custom ``Formatter``.
        ///   - placeholder: The attributed string that displays when there is no other text in the text field.
        ///   - textColor: The color of the text.
        ///   - textAligment: The text alignment.
        ///   - font: The text font.
        ///   - locale:/// The locale used when formatting.
        ///   - currencyCode: The currency code used  when formatting.
        ///   - maximumValue: The maximum allowed value of the ``CurrencyField``.
        ///   - decimalPlaces: The maximum number of digits after the decimal separator.
        ///   - displayCaret:  if `true` the caret will be displayed.
        ///   - caretColor: The color of the caret.
        ///   - displayDoneButtonAsAccessory: `true` to show an accessory view in the keyboard.
        ///   - allowClearFieldWhenValueIsZero:  If `true`, the `TextField` will clear its content. If you create your own custom formatter, you are responsible for this logic.
        ///   - adjustsFontSizeToFitWidth: See [Apple doc](https://developer.apple.com/documentation/uikit/uitextfield/adjustsfontsizetofitwidth)
        ///   - minimumFontSize: See [Apple doc](https://developer.apple.com/documentation/uikit/uitextfield/minimumfontsize)
        ///   - onFocusChanged: Checks whether the keyboard is the first responder.
        public init(
            formatter: Formatter? = nil,
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

            if let formatter {
                self.formatter = formatter
            } else if #available(iOS 15.0, *) {
                self.formatter = DefaultFormatter(
                    currencyCode: currencyCode,
                    locale: locale,
                    decimalPlaces: decimalPlaces < 0 ? 2 : decimalPlaces,
                    textAlignment: textAligment,
                    font: font,
                    color: textColor,
                    allowClearFieldWhenValueIsZero: allowClearFieldWhenValueIsZero)
            } else {
                self.formatter = FallbackFormatter(
                    currencyCode: currencyCode,
                    locale: locale,
                    decimalPlaces: decimalPlaces,
                    textAlignment: textAligment,
                    font: font,
                    color: textColor,
                    allowClearFieldWhenValueIsZero: allowClearFieldWhenValueIsZero)
            }

            self.displayCaret = displayCaret
            self.caretColor = caretColor
            self.displayDoneButtonAsAccessory = displayDoneButtonAsAccessory
            self.allowClearFieldWhenValueIsZero = allowClearFieldWhenValueIsZero
            self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
            self.minimumFontSize = minimumFontSize
            self.onFocusChanged = onFocusChanged
            self.textAligment = textAligment
        }
    }
}
