//
//	Geometry.swift
//
//	Create by Vidhyadharan Mohanram on 11/4/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Geometry : NSObject{

	public private(set) var location : Location!
	public private(set) var viewport : Viewport!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal init(fromDictionary dictionary:  [String:Any]){
		if let locationData: [String:Any] = dictionary["location"] as? [String:Any]{
			location = Location(fromDictionary: locationData)
		}
		if let viewportData: [String:Any] = dictionary["viewport"] as? [String:Any]{
			viewport = Viewport(fromDictionary: viewportData)
		}
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String: Any] = [String:Any]()
//        if location != nil{
//            dictionary["location"] = location.toDictionary()
//        }
//        if viewport != nil{
//            dictionary["viewport"] = viewport.toDictionary()
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
//         location = aDecoder.decodeObject(forKey: "location") as? Location
//         viewport = aDecoder.decodeObject(forKey: "viewport") as? Viewport
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if location != nil{
//            aCoder.encode(location, forKey: "location")
//        }
//        if viewport != nil{
//            aCoder.encode(viewport, forKey: "viewport")
//        }
//
//    }

}
