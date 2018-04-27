//
//  OrderDeliveryAddress.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 16/04/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

public class OrderDeliveryAddress: NSObject, NSCoding {
 
    @objc public var coordLatitude: CLLocationDegrees = 0
    @objc public var coordLongitude: CLLocationDegrees = 0
    
//    public var thoroughfare: String!
    
    @objc public var locality: String!
    
//    public var subLocality: String!
    
//    public var administrativeArea: String!
    
    @objc public var postalCode: String!
    
//    public var country: String!
    
    public var lines: [String?]!
    
    public var fullAddress: String? {
        if let address = lines {
            var filteredAddress = address.compactMap { $0 }
            filteredAddress = filteredAddress.filter { $0.count > 0 }
            let addressText = filteredAddress.joined(separator: ", ")
            return addressText
        }
        
        return nil
    }
    
    @objc public var displayAddress: String {
        if let address = lines {
            var filteredAddress = address.compactMap { $0 }
            filteredAddress = filteredAddress.filter { $0.count > 0 }
            
            if let code = postalCode, code.count > 0 {
                filteredAddress = filteredAddress.map { $0.replacingOccurrences(of: code, with: "") }
            }
            
            filteredAddress = filteredAddress.filter({ (text) -> Bool in
                let trimmedText = text.trimmingCharacters(in: CharacterSet.whitespaces)
                guard Int(trimmedText) == nil else { return false }
                return true
            })
            
            let addressText = filteredAddress.joined(separator: ", ")
            let trimmedText = addressText.trimmingCharacters(in: CharacterSet.whitespaces)
            if trimmedText.count > 0 {
                return trimmedText
            }
        }
        
        return "No Address"
    }
    
    init(gmsAddress: GMSAddress) {
        coordLatitude = gmsAddress.coordinate.latitude
        coordLongitude = gmsAddress.coordinate.longitude

//        thoroughfare = gmsAddress.thoroughfare
        locality = gmsAddress.locality
//        subLocality = gmsAddress.subLocality
//        administrativeArea = gmsAddress.administrativeArea
        postalCode = gmsAddress.postalCode
//        country = gmsAddress.country
        lines = gmsAddress.lines
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(NSNumber(value: coordLatitude), forKey: "coordLatitude")
        aCoder.encode(NSNumber(value: coordLongitude), forKey: "coordLongitude")
//        aCoder.encode(thoroughfare, forKey: "thoroughfare")
        aCoder.encode(locality, forKey: "locality")
//        aCoder.encode(subLocality, forKey: "subLocality")
//        aCoder.encode(administrativeArea, forKey: "administrativeArea")
        aCoder.encode(postalCode, forKey: "postalCode")
//        aCoder.encode(country, forKey: "country")
        aCoder.encode(lines, forKey: "lines")
    }
    
    @objc required public init(coder aDecoder: NSCoder) {
        coordLatitude = (aDecoder.decodeObject(forKey: "coordLatitude") as? NSNumber)?.doubleValue ?? 0
        coordLongitude = (aDecoder.decodeObject(forKey: "coordLongitude") as? NSNumber)?.doubleValue ?? 0
//        thoroughfare = aDecoder.decodeObject(forKey: "thoroughfare") as? String ?? ""
        locality = aDecoder.decodeObject(forKey: "locality") as? String ?? ""
//        subLocality = aDecoder.decodeObject(forKey: "subLocality") as? String ?? ""
//        administrativeArea = aDecoder.decodeObject(forKey: "administrativeArea") as? String
        postalCode = aDecoder.decodeObject(forKey: "postalCode") as? String ?? ""
//        country = aDecoder.decodeObject(forKey: "country") as? String ?? ""
        lines = aDecoder.decodeObject(forKey: "lines") as! [String?]
    }
    
}
