//
//  Decimal+Rounded.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 01/02/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension Decimal {
    
    public var rounded: Decimal {
        var current = self
        var rounded = Decimal()
        NSDecimalRound(&rounded, &current, 2, .plain)
        
        return rounded
    }

}
