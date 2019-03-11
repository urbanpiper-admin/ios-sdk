//
//	OffersAPIResponse.swift
//
//	Create by Vidhyadharan Mohanram on 10/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class OffersAPIResponse : NSObject{

	public internal(set)  var coupons : [Coupon]!
	public internal(set)  var meta : Meta!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		coupons = [Coupon]()
		if let couponsArray = dictionary["coupons"] as? [[String:Any]]{
			for dic in couponsArray{
				let value = Coupon(fromDictionary: dic)
				coupons.append(value)
			}
		}
		if let metaData = dictionary["meta"] as? [String:Any]{
			meta = Meta(fromDictionary: metaData)
		}
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String:Any]
//    {
//        var dictionary = [String:Any]()
//        if coupons != nil{
//            var dictionaryElements = [[String:Any]]()
//            for couponsElement in coupons {
//                dictionaryElements.append(couponsElement.toDictionary())
//            }
//            dictionary["coupons"] = dictionaryElements
//        }
//        if meta != nil{
//            dictionary["meta"] = meta.toDictionary()
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
//         coupons = aDecoder.decodeObject(forKey :"coupons") as? [Coupon]
//         meta = aDecoder.decodeObject(forKey: "meta") as? Meta
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc public func encode(with aCoder: NSCoder)
//    {
//        if coupons != nil{
//            aCoder.encode(coupons, forKey: "coupons")
//        }
//        if meta != nil{
//            aCoder.encode(meta, forKey: "meta")
//        }
//
//    }

}
