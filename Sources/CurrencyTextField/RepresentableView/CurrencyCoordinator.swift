//
//  CurrencyCoordinator.swift
//  CurrencyTextField
//
//  Created by Isaías Santana on 07/12/24.
//

import SwiftUI

@MainActor
final class CurrencyCoordinator: NSObject, UITextFieldDelegate {
    @Binding private var value: Decimal
    let configuration: CurrencyField.Configuration

    init(value: Binding<Decimal>, configuration: CurrencyField.Configuration) {
        self._value = value
        self.configuration = configuration
    }

    func textField(
        _ textField: UITextField, shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let nstring = textField.text as NSString? else {
            return true
        }

        let clearText = nstring.replacingCharacters(in: range, with: string)
            .onlyNumbers()

        guard let newValue = configuration.formatter.value(from: clearText),
            newValue <= configuration.maximumValue else {
            return false
        }

        DispatchQueue.main.async {
            self.value = newValue
        }

        if newValue == .zero, configuration.allowClearFieldWhenValueIsZero {
            textField.attributedText = nil
            return false
        }

        textField.attributedText = configuration.formatter.formatted(newValue)

        return false
    }
}

extension CurrencyCoordinator: _CurrencyTextFieldDelegate {
    func currencyTextFieldDidBeginEditing(_ currencyTextField: _CurrencyTextField) {
        configuration.onFocusChanged?(true)
    }

    func currencyTextFieldDidEndEditing(_ currencyTextField: _CurrencyTextField) {
        configuration.onFocusChanged?(false)
    }
}

extension String {
    func onlyNumbers() -> String {
        String(unicodeScalars.filter { CharacterSet.decimalDigits.contains($0) })
    }
}
