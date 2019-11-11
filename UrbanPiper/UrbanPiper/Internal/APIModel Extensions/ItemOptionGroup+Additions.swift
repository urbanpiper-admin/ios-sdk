//
//  ItemOptionGroup+Additions.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 22/12/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension OptionGroup {

    internal var isSingleSelectionGroup: Bool {
        minSelectable == SelectionQuantity.one
    }

    internal var isMultipleSelectionGroup: Bool {
        maxSelectable > SelectionQuantity.one || maxSelectable == SelectionQuantity.unlimited
    }

    internal var reorderOptionsToAdd: [OptionGroupOption] {
        var reorderOptionsToAdd = [OptionGroupOption]()

        for option in options {
            let options = option.reorderOptionsToAdd

            for optionItem in options {
                optionItem.quantity = isDefault ? 0 : 1
            }

            reorderOptionsToAdd.append(contentsOf: options)
        }

        return reorderOptionsToAdd
    }

}
