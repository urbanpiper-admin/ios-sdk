//
//  ItemOption+Additions.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 24/12/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import Foundation

extension OptionGroupOption {

    internal var reorderOptionsToAdd: [OptionGroupOption] {
        var reorderOptionsToAdd = [OptionGroupOption]()

        if let optionGroups = optionGroups, optionGroups.count > 0 {
            for optionGroup in optionGroups {
                reorderOptionsToAdd.append(contentsOf: optionGroup.reorderOptionsToAdd)
            }
        } else {
            reorderOptionsToAdd.append(self)
        }

        return reorderOptionsToAdd
    }
    
}
