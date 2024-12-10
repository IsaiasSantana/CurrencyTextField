//
//  CurrencyCoordinatorTests.swift
//  CurrencyTextField
//
//  Created by Isaías Santana on 10/12/24.
//

import Testing
import SwiftUI
@testable import CurrencyTextField

@MainActor
@Suite struct CurrencyCoordinatorTests {
    @Test func zeroValueShouldClearTextField() {
        let textField = _CurrencyTextField()
        let configuration =  CurrencyField.Configuration(locale: Locale(identifier: "pt_BR"),
                                                         currencyCode: "BRL",
                                                         allowClearFieldWhenValueIsZero: true)

        textField.attributedText = configuration.formatter.formatted(0)

        #expect(textField.text?.isEmpty == true)
    }

    @Test func textFieldShouldChangeWhenEditing() async throws {
        let configuration = CurrencyField.Configuration(locale: Locale(identifier: "pt_BR"), currencyCode: "BRL")
        let currencyCoordinator = CurrencyCoordinator(value: .constant(0), configuration: configuration)
        let textField = _CurrencyTextField()
        textField.attributedText = configuration.formatter.formatted(0)

        #expect(textField.text == "R$ 0,00")

        let _ = currencyCoordinator.textField(textField, shouldChangeCharactersIn: NSRange(location: 7, length: 0), replacementString: "1")
        #expect(textField.text == "R$ 0,01")
        #expect(configuration.formatter.value(from: textField.attributedText?.string.onlyNumbers() ?? "") == Decimal(string: "0.01"))

        let _ = currencyCoordinator.textField(textField, shouldChangeCharactersIn: NSRange(location: 7, length: 0), replacementString: "2")
        #expect(textField.text == "R$ 0,12")
        #expect(configuration.formatter.value(from: textField.attributedText?.string.onlyNumbers() ?? "") == Decimal(string: "0.12"))
    }
}


