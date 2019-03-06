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
        guard let data: Data = data(using: String.Encoding.utf8) else { return nil }
        
        do {
            guard let json: [[String: AnyObject]] = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: AnyObject]] else {
                throw UPError(type: .responseParseError, data: data, response: nil, error: nil)
            }
            
            return json
        } catch {
            return nil
        }
    }
    
}
