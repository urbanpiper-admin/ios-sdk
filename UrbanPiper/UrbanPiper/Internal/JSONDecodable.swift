//
//  JSONDecodable.swift
//  UrbanPiper
//
//  Created by Vidhyadharan Mohanram on 07/09/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

@objc protocol JSONDecodable {
    @objc init?(fromDictionary dictionary: [String: AnyObject]?)
}
