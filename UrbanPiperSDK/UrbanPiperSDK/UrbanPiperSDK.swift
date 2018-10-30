//
//  UrbanPiperSDK.swift
//  UrbanPiperSDK
//
//  Created by Vid on 24/10/18.
//

import UIKit

public class UrbanPiperSDK: NSObject {

    @objc public static private(set) var shared: UrbanPiperSDK!
    
    private init(language: Language) {
        super.init()
        APIManager.initializeManager(language: language)
    }
    
    public class func intializeSDK(language: Language = .english) {
        shared = UrbanPiperSDK(language: language)
    }
    
    public func change(language: Language) {
        APIManager.shared.language = language
    }

}
