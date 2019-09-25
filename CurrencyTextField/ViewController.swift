//
//  ViewController.swift
//  CurrencyTextField
//
//  Created by Isaías Santana on 24/09/19.
//  Copyright © 2019 Isaías Santana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let currencyTextField = ValorMonetarioTextField()
        currencyTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(currencyTextField)
        currencyTextField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        currencyTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: currencyTextField.trailingAnchor).isActive = true
        
    }

}

