//
//  ValorMonetarioDelegate.swift
//  CurrencyTextField
//
//  Created by Isaías Santana on 24/09/19.
//  Copyright © 2019 Isaías Santana. All rights reserved.
//

import Foundation
import UIKit

protocol CurrencyProtocol: AnyObject {
    func onValueChanged(value: Double)
}

final class CurrencyDelegate: NSObject, UITextFieldDelegate {
    private let base: Double = 10
    private let numberOfDecimals = 2.0
    private let totalDigits = 11 // 999.999.999,00
    private var _value = 0.0
    private var clearTextFieldIfValueIsEqualsZero = true
    
    var currencySymbol: String = {
        var simbolo = ""
        if #available(iOS 12.0, *) {
            simbolo = "R$"
        } else {
            simbolo = "R$ "
        }
        
        return simbolo
    }()
    
    let locale = Locale(identifier: "pt_BR")
    weak var delegate: CurrencyProtocol?
    
    private lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        formatter.currencySymbol = currencySymbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var value: Double {
        return _value
    }
    
    var toReal: String {
        return formatter.string(from: value as NSNumber) ?? ""
    }
    
    func setValue(_ valor: Double) {
        _value = valor
    }
    
    func clearTextFieldIfValueIsEqualsZero(_ isToClear: Bool) {
        clearTextFieldIfValueIsEqualsZero = isToClear
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string)) {
            return false
        }
        
        let newText = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        
        guard !newText.isEmpty else {
            return false
        }
        
        let numero = newText.onlyNumbers
        guard numero.count <= totalDigits else {
            return false
        }
        
        if newText.count > currencySymbol.count,
            let lastCaractere = currencySymbol.last,
            let lastIndex = newText.lastIndex(of: lastCaractere),
            !String(newText[newText.startIndex ..< newText.index(after: lastIndex)]).onlyNumbers.isEmpty {
            return false
        }
        
        _value = (Double(numero) ?? 0.0) / pow(base, numberOfDecimals)
        textField.text = (_value == 0 && clearTextFieldIfValueIsEqualsZero) ? "" : toReal
        
        delegate?.onValueChanged(value: _value)
        return false
    }
}
