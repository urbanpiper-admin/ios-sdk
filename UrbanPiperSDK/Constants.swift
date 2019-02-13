//
//  Constants.swift
//  UrbanPiperSDK
//
//  Created by Vid on 31/01/19.
//

import UIKit

struct Constants {

    static let isNotFirstLaunchKey: String = "IsNotFirstLaunchKey"

    static let fetchLimit: Int = 20
}


public extension NSNotification.Name {
    
    public static let upSDKTokenExpired = NSNotification.Name("upsdk-token-expired")
    
}

