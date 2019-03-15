//
//  UrbanPiperSDK+Tests.swift
//  UrbanPiperSDK
//
//  Created by Vid on 15/03/19.
//  Copyright © 2019 UrbanPiper. All rights reserved.
//

import UIKit

extension UrbanPiperSDK {

    #if SDKTESTS
    public class func intialize(language: Language? = .english, bizId: String, apiUsername: String, apiKey: String, session: URLSession? = nil, callback: @escaping (SDKEvent) -> Void) {
        shared = UrbanPiperSDK(language: language!, bizId: bizId, apiUsername: apiUsername, apiKey: apiKey, session: session, callback: callback)
    }
    #endif

}
