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

	public private(set)  var address1 : String!
	public private(set)  var landmark : String!
    public internal(set)  var deliverable : Bool?
	@objc public private(set)  var city : String!
	public internal(set)  var id : Int!
    @objc public private(set)  var lat : CLLocationDegrees = 0
    @objc public private(set)  var lng : CLLocationDegrees = 0
	@objc public private(set)  var pin : String!
	public private(set)  var podId : Int!
	@objc public private(set)  var subLocality : String!
	@objc public private(set)  var tag : String!
    
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
    
    public init(placeDetailsResponse: PlaceDetailsResponse) {
        lat = placeDetailsResponse.result!.geometry.location.lat
        lng = placeDetailsResponse.result!.geometry.location.lng
        
        let addressComponents = placeDetailsResponse.result!.addressComponents
        
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
            landmark = text
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
            let formattedAddress = placeDetailsResponse.result?.formattedAddress ?? ""
            var addressComps = formattedAddress.components(separatedBy: ", ")
            if let neighborhood = subLocalityLevel2, let index = addressComps.index(of: neighborhood) {
                addressComps.removeFirst(index)
                let addressString = addressComps.joined(separator: ", ")
                let stringWithoutDigit = (addressString.components(separatedBy: NSCharacterSet.decimalDigits).joined(separator: ""))
                subLocality = stringWithoutDigit.replacingOccurrences(of: " ,", with: ",")
            } else if let area = subLocalityLevel1, let index = addressComps.index(of: area) {
                addressComps.removeFirst(index)
                let addressString = addressComps.joined(separator: ", ")
                let stringWithoutDigit = (addressString.components(separatedBy: NSCharacterSet.decimalDigits).joined(separator: ""))
                subLocality = stringWithoutDigit.replacingOccurrences(of: " ,", with: ",")
            } else if let cityName = city, var index = addressComps.index(of: cityName) {
                if index > 2 {
                    index = index - 1
                }
                addressComps.removeFirst(index)
                let addressString = addressComps.joined(separator: ", ")
                let stringWithoutDigit = (addressString.components(separatedBy: NSCharacterSet.decimalDigits).joined(separator: ""))
                subLocality = stringWithoutDigit.replacingOccurrences(of: " ,", with: ",")
            } else {
                subLocality = placeDetailsResponse.result!.formattedAddress
            }
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
//            if let landmarkVal = lines?[1] {
//                landmark = landmarkVal
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
	@objc public init(fromDictionary dictionary:  [String:Any]){
		city = dictionary["city"] as? String

         deliverable = dictionary["deliverable"] as? Bool

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
    
    public init (id: Int? = nil, address1: String, landmark: String, city: String, lat: CLLocationDegrees,
                 lng: CLLocationDegrees, pin: String, subLocality: String, tag: String) {
        
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
    public func toDictionary() -> [String:Any]
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
         deliverable = aDecoder.decodeObject(forKey: "deliverable") as? Bool
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
		if landmark != nil{
			aCoder.encode(landmark, forKey: "landmark")
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
