//
//  Strings+Extensions.swift
//  CurrencyTextField
//
//  Created by Isaías Santana on 24/09/19.
//  Copyright © 2019 Isaías Santana. All rights reserved.
//

import Foundation
extension String {
    var onlyNumbers: String {
        return components(separatedBy: NSCharacterSet.decimalDigits.inverted)
            .joined(separator: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
