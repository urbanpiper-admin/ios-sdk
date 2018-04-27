//
//  WeakRef.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 15/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

class WeakRef<T> where T: AnyObject {

    private(set) weak var value: T?

    init(value: T?) {
        self.value = value
    }
}

