//
//  ValorMonetarioTextFieldDelegate.swift
//  CurrencyTextField
//
//  Created by Isaías Santana on 24/09/19.
//  Copyright © 2019 Isaías Santana. All rights reserved.
//

import Foundation
protocol ValorMonetarioTextFieldDelegate: AnyObject {
    ///
    /// Sempre será chamado quando o valor no campo de texto mudar.
    ///
    /// - parameter isValorValido: Um booleano indicando se o valor digitado está entre o valor máximo.
    ///     Se a propriedade `valorMaximo` for nil, então este parâmetro retornará sempre falso.
    ///
    func aoMudarOValorDigitado(isValorValido: Bool)
}
