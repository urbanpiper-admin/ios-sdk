//
//  Encodable+Dictionary.swift
//  UrbanPiper
//
//  Created by Vidhyadharan Mohanram on 06/11/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import Foundation

extension Encodable {
    internal func toDictionary() -> [String: AnyObject] {
        let data = try! newJSONEncoder().encode(self)
        return try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: AnyObject]
    }
}
