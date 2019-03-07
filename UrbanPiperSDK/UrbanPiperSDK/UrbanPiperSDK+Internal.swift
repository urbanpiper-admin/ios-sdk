//
//  UrbanPiperSDK+Internal.swift
//  UrbanPiperSDK
//
//  Created by Vid on 06/03/19.
//

import UIKit

public extension UrbanPiperSDK {
    
    @discardableResult @objc public func reverseGeoCode(lat: Double,
                                                        lng: Double,
                                                        completion: ((Address?) -> Void)?,
                                                        failure: APIFailure?) -> URLSessionDataTask {
        return APIManager.shared.reverseGeoCode(lat: lat, lng: lng, completion: completion, failure: failure)
    }

}
