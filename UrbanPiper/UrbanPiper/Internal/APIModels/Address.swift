//
//	Address.swift
//
//	Create by Vidhyadharan Mohanram on 24/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import CoreLocation
import Foundation

public enum AddressTag: String {
    case home
    case office = "work"
    case other
}

@objc public class Address: NSObject, JSONDecodable, NSCoding {
    public var address1: String!
    public var landmark: String!
    public var deliverable: Bool = false
    @objc public var city: String!
    public var id: Int?
    @objc public var lat: CLLocationDegrees = 0
    @objc public var lng: CLLocationDegrees = 0
    @objc public var pin: String!
    public var podId: Int?
    @objc public var subLocality: String!
    @objc public var tag: String!

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
    @objc public required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
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
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    @objc public func toDictionary() -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [String: AnyObject]()
        if let address1 = address1 {
            dictionary["address_1"] = address1 as AnyObject
        }
        if let landmark = landmark {
            dictionary["landmark"] = landmark as AnyObject
        }
        dictionary["deliverable"] = deliverable as AnyObject
        if let city = city {
            dictionary["city"] = city as AnyObject
        }
        if let id = id {
            dictionary["id"] = id as AnyObject
        }
        dictionary["lat"] = lat as AnyObject
        dictionary["lng"] = lng as AnyObject
        if let pin = pin {
            dictionary["pin"] = pin as AnyObject
        }
        if let podId = podId {
            dictionary["pod_id"] = podId as AnyObject
        }
        if let subLocality = subLocality {
            dictionary["sub_locality"] = subLocality as AnyObject
        }
        if let tag = tag {
            dictionary["tag"] = tag as AnyObject
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc public required init(coder aDecoder: NSCoder) {
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
    @objc public func encode(with aCoder: NSCoder) {
        if let address1 = address1 {
            aCoder.encode(address1, forKey: "address_1")
        }
        if let landmark = landmark {
            aCoder.encode(landmark, forKey: "landmark")
        }

        aCoder.encode(deliverable, forKey: "deliverable")

        if let city = city {
            aCoder.encode(city, forKey: "city")
        }
        if let id = id {
            aCoder.encode(id, forKey: "id")
        }

        aCoder.encode(lat, forKey: "lat")

        aCoder.encode(lng, forKey: "lng")

        if let pin = pin {
            aCoder.encode(pin, forKey: "pin")
        }
        if let podId = podId {
            aCoder.encode(podId, forKey: "pod_id")
        }
        if let subLocality = subLocality {
            aCoder.encode(subLocality, forKey: "sub_locality")
        }
        if let tag = tag {
            aCoder.encode(tag, forKey: "tag")
        }
    }
}
