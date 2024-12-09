//
//  CurrencyTextField2.swift
//  CurrencyTextField
//
//  Created by Isaías Santana on 05/12/24.
//

import SwiftUI

public struct CurrencyField: View {
    @Binding private var value: Decimal
    let configuration: Configuration

    public init(value: Binding<Decimal>, configuration: Configuration) {
        self._value = value
        self.configuration = configuration
    }

    public var body: some View {
        CurrencyTextFieldRepresentable(value: $value, configuration: configuration)
    }
}
