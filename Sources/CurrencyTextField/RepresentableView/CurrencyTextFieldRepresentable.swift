//
//  CurrencyTextFieldRepresentable.swift
//  CurrencyTextField
//
//  Created by Isaías Santana on 07/12/24.
//

import SwiftUI

struct CurrencyTextFieldRepresentable: UIViewRepresentable {
    @Binding var value: Decimal
    let configuration: CurrencyField.Configuration

    func makeUIView(context: Context) -> _CurrencyTextField {
        let textField = _CurrencyTextField()
        textField.delegate = context.coordinator
        textField.attributedPlaceholder = configuration.placeholder
        textField.attributedText = configuration.formatter.formatted(value)
        textField.currencyDelegate = context.coordinator
        textField.updateView(with: configuration)

        return textField
    }

    func updateUIView(_ uiView: _CurrencyTextField, context: Context) {
        if uiView.attributedText != configuration.formatter.formatted(value) {
            uiView.attributedText = configuration.formatter.formatted(value)
        }
        uiView.updateView(with: configuration)
    }

    func makeCoordinator() -> CurrencyCoordinator {
        CurrencyCoordinator(value: $value, configuration: configuration)
    }
}
