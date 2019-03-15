//
//	Viewport.swift
//
//	Create by Vidhyadharan Mohanram on 11/4/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Viewport : NSObject{

	public private(set) var northeast : Location!
	public private(set) var southwest : Location!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal init(fromDictionary dictionary:  [String:Any]){
		if let northeastData: [String:Any] = dictionary["northeast"] as? [String:Any]{
			northeast = Location(fromDictionary: northeastData)
		}
		if let southwestData: [String:Any] = dictionary["southwest"] as? [String:Any]{
			southwest = Location(fromDictionary: southwestData)
		}
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String: Any] = [String:Any]()
//        if northeast != nil{
//            dictionary["northeast"] = northeast.toDictionary()
//        }
//        if southwest != nil{
//            dictionary["southwest"] = southwest.toDictionary()
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
//         northeast = aDecoder.decodeObject(forKey: "northeast") as? Location
//         southwest = aDecoder.decodeObject(forKey: "southwest") as? Location
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if northeast != nil{
//            aCoder.encode(northeast, forKey: "northeast")
//        }
//        if southwest != nil{
//            aCoder.encode(southwest, forKey: "southwest")
//        }
//
//    }

}
