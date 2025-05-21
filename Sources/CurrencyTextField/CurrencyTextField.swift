//
//  CurrencyTextField2.swift
//  CurrencyTextField
//
//  Created by Isaías Santana on 05/12/24.
//

import SwiftUI

public struct CurrencyField: View {
    @Binding private var value: Decimal
    private var configuration: Configuration = Configuration()
    
    /// Creates a new instance of `CurrencyField`.
    ///
    /// Use this initializer to create a `CurrencyField` bound to a specific `Decimal` value.
    ///
    /// - Parameter value: the value controlled by the text field.
    public init(value: Binding<Decimal>) {
        self._value = value
    }

    public var body: some View {
        CurrencyTextFieldRepresentable(
            value: $value,
            configuration: configuration
        )
    }
    
    /// A ``Formatter`` used with the ``CurrencyField``.
    /// - Parameter formatter: Formatter to be used.
    public func formatter(_ formatter: CurrencyTextField.Formatter) -> Self {
        var newSelf = self
        newSelf.configuration.formatter = formatter
        return newSelf
    }

    /// The attributed string that displays when there is no other text in the text field.
    public func placeholder(_ placeholder: NSAttributedString?) -> Self {
        var newSelf = self
        newSelf.configuration.placeholder = placeholder
        return newSelf
    }

    /// The color of the text.
    public func textColor(_ color: UIColor) -> Self {
        var newSelf = self
        newSelf.configuration.textColor = color
        return newSelf
    }

    /// The text alignment.
    public func textAlignment(_ alignment: NSTextAlignment) -> Self {
        var newSelf = self
        newSelf.configuration.textAligment = alignment
        return newSelf
    }

    /// The font used by the CurrencyField.
    public func font(_ font: UIFont) -> Self {
        var newSelf = self
        newSelf.configuration.font = font
        return newSelf
    }

    /// The locale used when formatting.
    public func locale(_ locale: Locale) -> Self {
        var newSelf = self
        newSelf.configuration.locale = locale
        return newSelf
    }

    /// The currency code used  when formatting.
    public func currencyCode(_ code: String) -> Self {
        var newSelf = self
        newSelf.configuration.currencyCode = code
        return newSelf
    }

    /// the maximum allowed value of the ``CurrencyField``.
    public func maximumValue(_ value: Decimal) -> Self {
        var newSelf = self
        newSelf.configuration.maximumValue = value
        return newSelf
    }

    /// The maximum number of digits after the decimal separator.
    public func decimalPlaces(_ places: Int) -> Self {
        var newSelf = self
        newSelf.configuration.decimalPlaces = places
        return newSelf
    }

    /// if `true` the caret will be displayed.
    public func displayCaret(_ show: Bool) -> Self {
        var newSelf = self
        newSelf.configuration.displayCaret = show
        return newSelf
    }

    /// The color of the caret.
    public func caretColor(_ color: UIColor?) -> Self {
        var newSelf = self
        newSelf.configuration.caretColor = color
        return newSelf
    }

    /// `true` to show an accessory view in the keyboard.
    public func displayDoneButtonAsAccessory(_ show: Bool) -> Self {
        var newSelf = self
        newSelf.configuration.displayDoneButtonAsAccessory = show
        return newSelf
    }

    /// If `true`, the `TextField` will clear its content. If you create your own custom formatter, you are responsible for this logic.
    public func allowClearFieldWhenValueIsZero(_ clear: Bool) -> Self {
        var newSelf = self
        newSelf.configuration.allowClearFieldWhenValueIsZero = clear
        return newSelf
    }

    /// See [Apple doc](https://developer.apple.com/documentation/uikit/uitextfield/adjustsfontsizetofitwidth)
    public func adjustsFontSizeToFitWidth(_ adjust: Bool) -> Self {
        var newSelf = self
        newSelf.configuration.adjustsFontSizeToFitWidth = adjust
        return newSelf
    }

    /// See [Apple doc](https://developer.apple.com/documentation/uikit/uitextfield/minimumfontsize)
    public func minimumFontSize(_ size: CGFloat) -> Self {
        var newSelf = self
        newSelf.configuration.minimumFontSize = size
        return newSelf
    }

    /// If `true`, the text field allows the user to copy its content but prevents editing. When `readOnly` is `true`, the `displayCaret` setting is ignored.
    public func readOnly(_ readOnly: Bool) -> Self {
        var newSelf = self
        newSelf.configuration.readOnly = readOnly
        return newSelf
    }

    /// Checks whether the keyboard is the first responder.
    public func onFocusChanged(_ closure: ((Bool) -> Void)?) -> Self {
        var newSelf = self
        newSelf.configuration.onFocusChanged = closure
        return newSelf
    }
}

#if DEBUG
struct Sample: View {
    @State private var value: Decimal = 0.0
    var body: some View {
        if #available(iOS 14.0, *) {
            CurrencyField(
                value: $value
            )
            .placeholder(
                NSAttributedString(
                    string: "R$ 0,00",
                    attributes: [
                        .font: UIFont.systemFont(ofSize: 30),
                        .foregroundColor: UIColor.systemGray3,
                        .paragraphStyle: NSParagraphStyle.default
                    ]
                )
            )
            .textColor(.systemGray)
            .textAlignment(.center)
            .font(
                .systemFont(ofSize: 30)
            )
            .locale(
                Locale(identifier: "pt_BR")
            )
            .currencyCode("BRL")
            .maximumValue(10_000)
            .decimalPlaces(2)
            .displayCaret(true)
            .caretColor(.green)
            .displayDoneButtonAsAccessory(true)
            .allowClearFieldWhenValueIsZero(false)
            .adjustsFontSizeToFitWidth(true)
            .minimumFontSize(1.0)
            .readOnly(false)
            .onFocusChanged { isFocused in
                print("Is focused \(isFocused)")
            }
            .onChange(of: value, perform: { newValue in
                print("Value: \(newValue)")
            })
        } else {
            CurrencyField(
                value: $value
            )
            .placeholder(
                NSAttributedString(
                    string: "R$ 0,00",
                    attributes: [
                        .font: UIFont.systemFont(ofSize: 30),
                        .foregroundColor: UIColor.systemGray3,
                        .paragraphStyle: NSParagraphStyle.default
                    ]
                )
            )
            .textColor(.systemGray)
            .textAlignment(.center)
            .font(
                .systemFont(ofSize: 30)
            )
            .locale(
                Locale(identifier: "pt_BR")
            )
            .currencyCode("BRL")
            .maximumValue(10_000)
            .decimalPlaces(2)
            .displayCaret(true)
            .caretColor(.green)
            .displayDoneButtonAsAccessory(true)
            .allowClearFieldWhenValueIsZero(true)
            .adjustsFontSizeToFitWidth(true)
            .minimumFontSize(1.0)
            .readOnly(false)
            .onFocusChanged { isFocused in
                print("Is focused \(isFocused)")
            }
        }
    }
}
#Preview {
    Sample()
}
#endif
