//
//  ValorMonetarioTextField.swift
//  CurrencyTextField
//
//  Created by Isaías Santana on 24/09/19.
//  Copyright © 2019 Isaías Santana. All rights reserved.
//

import UIKit

final class ValorMonetarioTextField: UITextField, CurrencyProtocol {
    /// O delegate para o valor digitado.
    weak var delegateValorMonetario: ValorMonetarioTextFieldDelegate?
    
    // swiftlint:disable:next weak_delegate
    private let valorMonetarioDelegate = CurrencyDelegate()
    
    /// Esta propriedade se configurada serve para exibir o valor na cor vermelha se o valor digitado for maior que valor máximo.
    var valorMaximo: Double? {
        didSet {
            onValueChanged(value: valorMonetarioDelegate.value)
        }
    }
    
    private let corPadrao = UIColor.black
    
    /// A cor para o texto digitado
    var corCampoTexto: UIColor? {
        didSet {
            textColor = corCampoTexto ?? corPadrao
        }
    }
    
    /// O Valor digitado pelo usuário.
    var valor: Double {
        return valorMonetarioDelegate.value
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        placeholder = "R$ 0,00"
        textColor = corPadrao
        font = .systemFont(ofSize: 27)
        textAlignment = .center
        keyboardType = .numberPad
        delegate = valorMonetarioDelegate
        valorMonetarioDelegate.delegate = self
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onValueChanged(value: Double) {
        if let valorMaximo = valorMaximo, value > valorMaximo {
            textColor = .red
            delegateValorMonetario?.aoMudarOValorDigitado(isValorValido: false)
        } else {
            textColor = corCampoTexto ?? corPadrao
            delegateValorMonetario?.aoMudarOValorDigitado(isValorValido: value > 0)
        }
    }
}
