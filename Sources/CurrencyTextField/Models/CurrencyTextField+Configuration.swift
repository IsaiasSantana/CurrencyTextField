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
    struct Configuration {
        /// The attributed string that displays when there is no other text in the text field.
        var placeholder: NSAttributedString?

        /// the maximum allowed value of the ``CurrencyField``.
        var maximumValue: Decimal

        private var _formatter: (any Formatter)?

        /// A ``Formatter`` used with the ``CurrencyField``.
        var formatter: any Formatter {
            set {
                _formatter = newValue
            }
            get {
                if let _formatter {
                    return _formatter
                }

                if #available(iOS 15.0, *) {
                    return DefaultFormatter(
                        currencyCode: currencyCode,
                        locale: locale,
                        decimalPlaces: decimalPlaces < 0 ? 2 : decimalPlaces,
                        textAlignment: textAligment,
                        font: font,
                        color: textColor,
                        allowClearFieldWhenValueIsZero: allowClearFieldWhenValueIsZero
                    )
                } else {
                    return FallbackFormatter(
                        currencyCode: currencyCode,
                        locale: locale,
                        decimalPlaces: decimalPlaces,
                        textAlignment: textAligment,
                        font: font,
                        color: textColor,
                        allowClearFieldWhenValueIsZero: allowClearFieldWhenValueIsZero
                    )
                }
            }
        }

        /// if `true` the caret will be displayed
        var displayCaret: Bool

        /// The color of the caret
        var caretColor: UIColor?

        /// `true` to show an accessory view in the keyboard.
        var displayDoneButtonAsAccessory: Bool

        /// If `true`, the `TextField` will clear its content.
        var allowClearFieldWhenValueIsZero: Bool

        /// The text alignment.
        var textAligment: NSTextAlignment

        /// See [Apple doc](https://developer.apple.com/documentation/uikit/uitextfield/adjustsfontsizetofitwidth)
        var adjustsFontSizeToFitWidth: Bool

        /// See [Apple doc](https://developer.apple.com/documentation/uikit/uitextfield/minimumfontsize)
        var minimumFontSize: CGFloat

        /// The text field does not allow deleting its content.
        var readOnly: Bool

        /// Checks whether the keyboard is the first responder.
        var onFocusChanged: ((Bool) -> Void)?

        var currencyCode: String

        var locale: Locale

        var decimalPlaces: Int

        var font: UIFont

        var textColor: UIColor

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
        ///   - readOnly: If `true`, the text field allows the user to copy its content but prevents editing. When `readOnly` is `true`, the `displayCaret` setting is ignored.
        ///   - onFocusChanged: Checks whether the keyboard is the first responder.
        init(
            formatter: Formatter? = nil,
            placeholder: NSAttributedString? = nil,
            textColor: UIColor = .systemGray,
            textAligment: NSTextAlignment = .center,
            font: UIFont = .systemFont(ofSize: 30),
            locale: Locale = .autoupdatingCurrent,
            currencyCode: String = "BRL",
            maximumValue: Decimal = 1_000_000_000_000,
            decimalPlaces: Int = 2,
            displayCaret: Bool = true,
            caretColor: UIColor? = nil,
            displayDoneButtonAsAccessory: Bool = true,
            allowClearFieldWhenValueIsZero: Bool = false,
            adjustsFontSizeToFitWidth: Bool = true,
            minimumFontSize: CGFloat = 0.0,
            readOnly: Bool = false,
            onFocusChanged: ((Bool) -> Void)? = nil
        ) {
            self._formatter = formatter
            self.placeholder = placeholder
            self.maximumValue = maximumValue
            self.displayCaret = displayCaret
            self.caretColor = caretColor
            self.displayDoneButtonAsAccessory = displayDoneButtonAsAccessory
            self.allowClearFieldWhenValueIsZero = allowClearFieldWhenValueIsZero
            self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
            self.minimumFontSize = minimumFontSize
            self.readOnly = readOnly
            self.onFocusChanged = onFocusChanged
            self.textAligment = textAligment
            self.currencyCode = currencyCode
            self.locale = locale
            self.decimalPlaces = decimalPlaces
            self.font = font
            self.textColor = textColor
        }
    }
}
