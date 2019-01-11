//
//  UrbanPiperSDK.swift
//  UrbanPiperSDK
//
//  Created by Vid on 24/10/18.
//

import UIKit

public class UrbanPiperSDK: NSObject {

    @objc public static private(set) var shared: UrbanPiperSDK!
    
    private init(language: Language = .english, bizId: String, apiUsername: String, apiKey: String) {
        super.init()
        APIManager.initializeManager(language: language, bizId: bizId, apiUsername: apiUsername, apiKey: apiKey)
    }
    
    public class func intialize(language: Language? = .english, bizId: String, apiUsername: String, apiKey: String) {
        shared = UrbanPiperSDK(language: language!, bizId: bizId, apiUsername: apiUsername, apiKey: apiKey)
    }
    
    public func change(language: Language) {
        APIManager.shared.language = language
    }

}
