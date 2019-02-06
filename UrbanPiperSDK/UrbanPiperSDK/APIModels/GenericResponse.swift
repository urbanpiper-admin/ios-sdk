//
//  GenericResponse.swift
//  UrbanPiperSDK
//
//  Created by Vid on 06/02/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

@objc public class GenericResponse: NSObject {
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init?(fromDictionary dictionary: [String:Any]?) {
        guard dictionary != nil else { return nil }
    }

}
