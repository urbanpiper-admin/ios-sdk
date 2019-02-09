//
//	Result.swift
//
//	Create by Vidhyadharan Mohanram on 11/4/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Result : NSObject{

	public var addressComponents : [AddressComponent]!
	public var adrAddress : String!
	public var formattedAddress : String!
	public var geometry : Geometry!
	public var icon : String!
	public var id : String!
	public var name : String!
	public var photos : [Photo]!
	public var placeId : String!
	public var reference : String!
	public var scope : String!
	public var types : [String]!
	public var url : String!
	public var utcOffset : Int!
	public var vicinity : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		addressComponents = [AddressComponent]()
		if let addressComponentsArray: [[String:Any]] = dictionary["address_components"] as? [[String:Any]]{
			for dic in addressComponentsArray{
				let value: AddressComponent = AddressComponent(fromDictionary: dic)
				addressComponents.append(value)
			}
		}
		adrAddress = dictionary["adr_address"] as? String
		formattedAddress = dictionary["formatted_address"] as? String
		if let geometryData: [String:Any] = dictionary["geometry"] as? [String:Any]{
			geometry = Geometry(fromDictionary: geometryData)
		}
		icon = dictionary["icon"] as? String
		id = dictionary["id"] as? String
		name = dictionary["name"] as? String
		photos = [Photo]()
		if let photosArray: [[String:Any]] = dictionary["photos"] as? [[String:Any]]{
			for dic in photosArray{
				let value: Photo = Photo(fromDictionary: dic)
				photos.append(value)
			}
		}
		placeId = dictionary["place_id"] as? String
		reference = dictionary["reference"] as? String
		scope = dictionary["scope"] as? String
		types = dictionary["types"] as? [String]
		url = dictionary["url"] as? String
		utcOffset = dictionary["utc_offset"] as? Int
		vicinity = dictionary["vicinity"] as? String
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String: Any] = [String:Any]()
//        if addressComponents != nil{
//            var dictionaryElements: [[String:Any]] = [[String:Any]]()
//            for addressComponentsElement in addressComponents {
//                dictionaryElements.append(addressComponentsElement.toDictionary())
//            }
//            dictionary["address_components"] = dictionaryElements
//        }
//        if adrAddress != nil{
//            dictionary["adr_address"] = adrAddress
//        }
//        if formattedAddress != nil{
//            dictionary["formatted_address"] = formattedAddress
//        }
//        if geometry != nil{
//            dictionary["geometry"] = geometry.toDictionary()
//        }
//        if icon != nil{
//            dictionary["icon"] = icon
//        }
//        if id != nil{
//            dictionary["id"] = id
//        }
//        if name != nil{
//            dictionary["name"] = name
//        }
//        if photos != nil{
//            var dictionaryElements: [[String:Any]] = [[String:Any]]()
//            for photosElement in photos {
//                dictionaryElements.append(photosElement.toDictionary())
//            }
//            dictionary["photos"] = dictionaryElements
//        }
//        if placeId != nil{
//            dictionary["place_id"] = placeId
//        }
//        if reference != nil{
//            dictionary["reference"] = reference
//        }
//        if scope != nil{
//            dictionary["scope"] = scope
//        }
//        if types != nil{
//            dictionary["types"] = types
//        }
//        if url != nil{
//            dictionary["url"] = url
//        }
//        if utcOffset != nil{
//            dictionary["utc_offset"] = utcOffset
//        }
//        if vicinity != nil{
//            dictionary["vicinity"] = vicinity
//        }
//        return dictionary
//    }
//
//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required public init(coder aDecoder: NSCoder)
//    {
//         addressComponents = aDecoder.decodeObject(forKey :"address_components") as? [AddressComponent]
//         adrAddress = aDecoder.decodeObject(forKey: "adr_address") as? String
//         formattedAddress = aDecoder.decodeObject(forKey: "formatted_address") as? String
//         geometry = aDecoder.decodeObject(forKey: "geometry") as? Geometry
//         icon = aDecoder.decodeObject(forKey: "icon") as? String
//         id = aDecoder.decodeObject(forKey: "id") as? String
//         name = aDecoder.decodeObject(forKey: "name") as? String
//         photos = aDecoder.decodeObject(forKey :"photos") as? [Photo]
//         placeId = aDecoder.decodeObject(forKey: "place_id") as? String
//         reference = aDecoder.decodeObject(forKey: "reference") as? String
//         scope = aDecoder.decodeObject(forKey: "scope") as? String
//         types = aDecoder.decodeObject(forKey: "types") as? [String]
//         url = aDecoder.decodeObject(forKey: "url") as? String
//         utcOffset = aDecoder.decodeObject(forKey: "utc_offset") as? Int
//         vicinity = aDecoder.decodeObject(forKey: "vicinity") as? String
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if addressComponents != nil{
//            aCoder.encode(addressComponents, forKey: "address_components")
//        }
//        if adrAddress != nil{
//            aCoder.encode(adrAddress, forKey: "adr_address")
//        }
//        if formattedAddress != nil{
//            aCoder.encode(formattedAddress, forKey: "formatted_address")
//        }
//        if geometry != nil{
//            aCoder.encode(geometry, forKey: "geometry")
//        }
//        if icon != nil{
//            aCoder.encode(icon, forKey: "icon")
//        }
//        if id != nil{
//            aCoder.encode(id, forKey: "id")
//        }
//        if name != nil{
//            aCoder.encode(name, forKey: "name")
//        }
//        if photos != nil{
//            aCoder.encode(photos, forKey: "photos")
//        }
//        if placeId != nil{
//            aCoder.encode(placeId, forKey: "place_id")
//        }
//        if reference != nil{
//            aCoder.encode(reference, forKey: "reference")
//        }
//        if scope != nil{
//            aCoder.encode(scope, forKey: "scope")
//        }
//        if types != nil{
//            aCoder.encode(types, forKey: "types")
//        }
//        if url != nil{
//            aCoder.encode(url, forKey: "url")
//        }
//        if utcOffset != nil{
//            aCoder.encode(utcOffset, forKey: "utc_offset")
//        }
//        if vicinity != nil{
//            aCoder.encode(vicinity, forKey: "vicinity")
//        }
//
//    }

}
