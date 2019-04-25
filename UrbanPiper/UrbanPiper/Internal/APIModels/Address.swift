//
//	Address.swift
//
//	Create by Vidhyadharan Mohanram on 24/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import CoreLocation

public enum AddressTag: String {
    case home = "home"
    case office = "work"
    case other = "other"
}


@objc public class Address : NSObject, NSCoding {

	public var address1 : String!
	public var landmark : String!
    public var deliverable : Bool = false
	@objc public var city : String!
	public var id : Int!
    @objc public var lat : CLLocationDegrees = 0
    @objc public var lng : CLLocationDegrees = 0
	@objc public var pin : String!
	public var podId : Int!
	@objc public var subLocality : String!
	@objc public var tag : String!
    
    public var addressTag: AddressTag {
        guard let tagString: String = tag, let addressTagVal: AddressTag = AddressTag(rawValue: tagString.lowercased()) else { return .other }
        return addressTagVal
    }
    
    @objc public var addressString: String? {
        return fullAddress?.replacingOccurrences(of: "\n", with: ", ")
    }
    
    @objc public var fullAddress: String? {
        var fullAddress: String = ""
        if let string = address1 {
            fullAddress = "\(fullAddress + string)\n"
        }
        if let string = landmark {
            fullAddress = "\(fullAddress + string)\n"
        }
        if let string = subLocality {
            fullAddress = "\(fullAddress + string)\n"
        }
        if let string = city {
            fullAddress = "\(fullAddress + string)"
        }
        if let string = pin {
            fullAddress = "\(fullAddress) - \(string)"
        }
        guard fullAddress.count > 0 else { return nil }
        return fullAddress
    }

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	@objc internal init(fromDictionary dictionary:  [String:Any]){
		city = dictionary["city"] as? String

         deliverable = dictionary["deliverable"] as? Bool ?? false

        if let latitude: Double = dictionary["latitude"] as? Double {
            lat = latitude
        } else {
            lat = dictionary["lat"] as? Double ?? Double(0)
        }
        
        if let longitude: Double = dictionary["longitude"] as? Double {
            lng = longitude
        } else {
            lng = dictionary["lng"] as? Double ?? Double(0)
        }
        
        if let line1: String = dictionary["line_1"] as? String {
            address1 = line1
        } else {
            address1 = dictionary["address_1"] as? String
        }
        
        landmark = dictionary["landmark"] as? String
        
		id = dictionary["id"] as? Int
		pin = dictionary["pin"] as? String
		podId = dictionary["pod_id"] as? Int
		subLocality = dictionary["sub_locality"] as? String
		tag = dictionary["tag"] as? String ?? AddressTag.other.rawValue
	}
    
//    public init(address1: String, landmark: String, city: String, lat: CLLocationDegrees,
//                lng: CLLocationDegrees, pin: String, subLocality: String, tag: AddressTag) {
//        self.address1 = address1
//        self.landmark = landmark
//        self.city = city
//        self.lat = lat
//        self.lng = lng
//        self.pin = pin
//        self.subLocality = subLocality
//        self.tag = tag.rawValue
//    }
    
    @objc public convenience init(address1: String, landmark: String, city: String, lat: CLLocationDegrees,
                 lng: CLLocationDegrees, pin: String, subLocality: String, tag: String) {
        self.init(id: nil, address1: address1, landmark: landmark, city: city, lat: lat, lng: lng, pin: pin, subLocality: subLocality, tag: tag)
    }
    
    public init(id: Int? = nil, address1: String, landmark: String, city: String, lat: CLLocationDegrees,
                lng: CLLocationDegrees, pin: String, subLocality: String, tag: String?) {
        
        self.id = id
        self.address1 = address1
        self.landmark = landmark
        self.city = city
        self.lat = lat
        self.lng = lng
        self.pin = pin
        self.subLocality = subLocality
        self.tag = tag
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    @objc public func toDictionary() -> [String:Any]
    {
        var dictionary: [String: Any] = [String:Any]()
        if address1 != nil{
            dictionary["address_1"] = address1
        }
        if landmark != nil{
            dictionary["landmark"] = landmark
        }
        if deliverable != nil{
            dictionary["deliverable"] = deliverable
        }
        if city != nil{
            dictionary["city"] = city
        }
        if id != nil{
            dictionary["id"] = id
        }
        dictionary["lat"] = lat
        dictionary["lng"] = lng
        if pin != nil{
            dictionary["pin"] = pin
        }
        if podId != nil{
            dictionary["pod_id"] = podId
        }
        if subLocality != nil{
            dictionary["sub_locality"] = subLocality
        }
        if tag != nil{
            dictionary["tag"] = tag
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         address1 = aDecoder.decodeObject(forKey: "address_1") as? String
         landmark = aDecoder.decodeObject(forKey: "landmark") as? String
        if landmark == nil {
            landmark = aDecoder.decodeObject(forKey: "address_2") as? String
        }
        if let numberVal = aDecoder.decodeObject(forKey: "deliverable") as? NSNumber {
            deliverable = numberVal == 0 ? false : true
        } else if aDecoder.containsValue(forKey: "deliverable") {
            deliverable = aDecoder.decodeBool(forKey: "deliverable")
        } else {
            deliverable = false
        }
         city = aDecoder.decodeObject(forKey: "city") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         lat = aDecoder.decodeObject(forKey: "lat") as? Double ?? Double(0)
         lng = aDecoder.decodeObject(forKey: "lng") as? Double ?? Double(0)
         pin = aDecoder.decodeObject(forKey: "pin") as? String
         podId = aDecoder.decodeObject(forKey: "pod_id") as? Int
         subLocality = aDecoder.decodeObject(forKey: "sub_locality") as? String
         tag = aDecoder.decodeObject(forKey: "tag") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if address1 != nil{
			aCoder.encode(address1, forKey: "address_1")
		}
		if landmark != nil{
			aCoder.encode(landmark, forKey: "landmark")
		}

        aCoder.encode(deliverable, forKey: "deliverable")
        
		if city != nil{
			aCoder.encode(city, forKey: "city")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
        
        aCoder.encode(lat, forKey: "lat")
		
        aCoder.encode(lng, forKey: "lng")

		if pin != nil{
			aCoder.encode(pin, forKey: "pin")
		}
		if podId != nil{
			aCoder.encode(podId, forKey: "pod_id")
		}
		if subLocality != nil{
			aCoder.encode(subLocality, forKey: "sub_locality")
		}
		if tag != nil{
			aCoder.encode(tag, forKey: "tag")
		}

	}

}
