//
//  Extras.swift
//  UrbanPiperSDK
//
//  Created by Vid on 24/12/18.
//

import UIKit

public class Extras: NSObject {
    
    weak public private(set) var viewController: UIViewController?
    public var objectDictionary: [String : Any] = [:]
    
    public init(viewController: UIViewController) {
        self.viewController = viewController
        super.init()
    }

}
