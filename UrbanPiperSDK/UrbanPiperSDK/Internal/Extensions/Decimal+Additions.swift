//
//  Decimal+Additions.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 01/02/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension Decimal {
    
    public static let zero: Decimal = Decimal.zero
    
    public var rounded: Decimal {
        var current = self
        var rounded = Decimal()
        NSDecimalRound(&rounded, &current, 2, .plain)
        
        return rounded
    }
    
    static let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
//        numberFormatter.numberStyle = .currency
//        numberFormatter.locale = someSKProduct.priceLocale

        return numberFormatter
    }()
    public var stringVal: String {
        return Decimal.numberFormatter.string(from: self as NSDecimalNumber)!
    }

}
