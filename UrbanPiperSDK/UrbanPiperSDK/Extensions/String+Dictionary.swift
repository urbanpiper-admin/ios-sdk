//
//  String+Dictionary.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 18/04/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension String {

    public var array: [[String: AnyObject]]? {
        guard let data = data(using: String.Encoding.utf8) else { return nil }
        
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: AnyObject]] else { throw UPError(type: .unknown) }
            return json
        } catch {
            return nil
        }
    }
    
}
