//
//	OffersAPIResponse.swift
//
//	Create by Vidhyadharan Mohanram on 10/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class OffersAPIResponse : NSObject, JSONDecodable{

	public var coupons : [Coupon]!
	public var meta : Meta!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
		coupons = [Coupon]()
		if let couponsArray = dictionary["coupons"] as? [[String : AnyObject]]{
			for dic in couponsArray{
				guard let value = Coupon(fromDictionary: dic) else { continue }
				coupons.append(value)
			}
		}
		if let metaData = dictionary["meta"] as? [String : AnyObject]{
			meta = Meta(fromDictionary: metaData)
		}
	}

//    /**
//     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String : AnyObject]
//    {
//        var dictionary = [String : AnyObject]()
//        if let coupons = coupons {
//            var dictionaryElements = [[String : AnyObject]]()
//            for couponsElement in coupons {
//                dictionaryElements.append(couponsElement.toDictionary())
//            }
//            dictionary["coupons"] = dictionaryElements as AnyObject
//        }
//        if let meta = meta {
//            dictionary["meta"] = meta.toDictionary() as AnyObject
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
//        if let coupons = coupons {
//            aCoder.encode(coupons, forKey: "coupons")
//        }
//        if let meta = meta {
//            aCoder.encode(meta, forKey: "meta")
//        }
//
//    }

}
