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


public class Address : NSObject, NSCoding {

	public var address1 : String!
	public var address2 : String!
    public var deliverable : Bool!
	public var city : String!
	public var id : Int!
	public var lat : Double!
	public var lng : Double!
	public var pin : String!
	public var podId : Int!
	public var subLocality : String!
	public var tag : String!
    
    public var addressTag: AddressTag {
        guard let tagString: String = tag, let addressTagVal: AddressTag = AddressTag(rawValue: tagString.lowercased()) else { return .other }
        return addressTagVal
    }
    
    public var addressString: String? {
        return fullAddress?.replacingOccurrences(of: "\n", with: ", ")
    }
    
    public var fullAddress: String? {
        var fullAddress: String = ""
        if let string = address1 {
            fullAddress = "\(fullAddress + string)\n"
        }
        if let string = address2 {
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
    
    public init(placeDetailsResponse: PlaceDetailsResponse) {
        lat = placeDetailsResponse.result.geometry.location.lat
        lng = placeDetailsResponse.result.geometry.location.lng
        
        let addressComponents = placeDetailsResponse.result.addressComponents
        
        var subLocalityArray = [String]()
        
        let subLocalityLevel1 = addressComponents?.filter ({ $0.types.contains("sublocality_level_1")}).last?.longName
        let subLocalityLevel2 = addressComponents?.filter ({ $0.types.contains("sublocality_level_2")}).last?.longName

        if let text = addressComponents?.filter ({ $0.types.contains("route")}).last?.longName {
            subLocalityArray.append(text)
        }
        if let text = addressComponents?.filter ({ $0.types.contains("neighborhood")}).last?.longName {
            subLocalityArray.append(text)
        }
        if let text = addressComponents?.filter ({ $0.types.contains("sublocality_level_5")}).last?.longName {
            subLocalityArray.append(text)
        }
        if let text = addressComponents?.filter ({ $0.types.contains("sublocality_level_4")}).last?.longName {
            subLocalityArray.append(text)
        }
        if let text = addressComponents?.filter ({ $0.types.contains("sublocality_level_3")}).last?.longName {
            subLocalityArray.append(text)
        }
        if let text = subLocalityLevel2 {
            subLocalityArray.append(text)
            address2 = text
        }
        if let text = subLocalityLevel1 {
            subLocalityArray.append(text)
            address1 = text
        }
        if let text = addressComponents?.filter ({ $0.types.contains("locality")}).last?.longName {
            subLocalityArray.append(text)
            city = text
        }
        
        if subLocalityArray.count < 3 {
            subLocality = placeDetailsResponse.result.formattedAddress
        } else {
            subLocality = subLocalityArray.joined(separator: ", ")
        }
        
        pin = addressComponents?.filter ({ $0.types.contains("postal_code")}).last?.longName
    }
    
//    public init(coordinate: CLLocationCoordinate2D?, thoroughfare: String?, locality: String?, administrativeArea: String?, postalCode: String?, lines: [String?]?) {
//        lat = coordinate?.latitude ?? Double.zero
//        lng = coordinate?.longitude ?? Double.zero
//        
//        address1 = thoroughfare
//        if let linesString = lines {
//            if let address2Val = lines?[1] {
//                address2 = address2Val
//            }
//        }
//        
//        subLocality = locality
//        city = administrativeArea
//        pin = postalCode
//    }

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		city = dictionary["city"] as? String

         deliverable = dictionary["deliverable"] as? Bool ?? false

        if let latitude: Double = dictionary["latitude"] as? Double {
            lat = latitude
        } else {
            lat = dictionary["lat"] as? Double ?? Double.zero
        }
        
        if let longitude: Double = dictionary["longitude"] as? Double {
            lng = longitude
        } else {
            lng = dictionary["lng"] as? Double ?? Double.zero
        }
        
        if let line1: String = dictionary["line_1"] as? String {
            address2 = line1
        } else {
            address1 = dictionary["address_1"] as? String
        }
        
        if let line2: String = dictionary["line_2"] as? String {
            address2 = line2
        } else {
            address2 = dictionary["address_2"] as? String
        }
        
		id = dictionary["id"] as? Int
		pin = dictionary["pin"] as? String
		podId = dictionary["pod_id"] as? Int
		subLocality = dictionary["sub_locality"] as? String
		tag = dictionary["tag"] as? String
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String : Any] = [String:Any]()
//        if address1 != nil{
//            dictionary["address_1"] = address1
//        }
//        if address2 != nil{
//            dictionary["address_2"] = address2
//        }
//        if deliverable != nil{
//            dictionary["deliverable"] = deliverable
//        }
//        if city != nil{
//            dictionary["city"] = city
//        }
//        if id != nil{
//            dictionary["id"] = id
//        }
//        if lat != nil{
//            dictionary["lat"] = lat
//        }
//        if lng != nil{
//            dictionary["lng"] = lng
//        }
//        if pin != nil{
//            dictionary["pin"] = pin
//        }
//        if podId != nil{
//            dictionary["pod_id"] = podId
//        }
//        if subLocality != nil{
//            dictionary["sub_locality"] = subLocality
//        }
//        if tag != nil{
//            dictionary["tag"] = tag
//        }
//        return dictionary
//    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         address1 = aDecoder.decodeObject(forKey: "address_1") as? String
         address2 = aDecoder.decodeObject(forKey: "address_2") as? String
         deliverable = aDecoder.decodeObject(forKey: "deliverable") as? Bool ?? false
         city = aDecoder.decodeObject(forKey: "city") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         lat = aDecoder.decodeObject(forKey: "lat") as? Double ?? Double.zero
         lng = aDecoder.decodeObject(forKey: "lng") as? Double ?? Double.zero
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
		if address2 != nil{
			aCoder.encode(address2, forKey: "address_2")
		}
        if deliverable != nil{
            aCoder.encode(deliverable, forKey: "deliverable")
        }
		if city != nil{
			aCoder.encode(city, forKey: "city")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if lat != nil{
			aCoder.encode(lat, forKey: "lat")
		}
		if lng != nil{
			aCoder.encode(lng, forKey: "lng")
		}
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
