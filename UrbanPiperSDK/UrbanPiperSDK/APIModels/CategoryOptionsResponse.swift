//
//	CategoryOptionsResponse.swift
//
//	Create by Vidhyadharan Mohanram on 11/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class CategoryOptionsResponse : NSObject {

	public var filters : [Filter]!
	public var sortBy : [String]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		filters = [Filter]()
		if let filtersArray = dictionary["filters"] as? [[String:Any]]{
			for dic in filtersArray{
				let value = Filter(fromDictionary: dic)
				filters.append(value)
			}
		}
		sortBy = dictionary["sort_by"] as? [String]
	}

/*	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if filters != nil{
			var dictionaryElements = [[String:Any]]()
			for filtersElement in filters {
				dictionaryElements.append(filtersElement.toDictionary())
			}
			dictionary["filters"] = dictionaryElements
		}
		if sortBy != nil{
			dictionary["sort_by"] = sortBy
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         filters = aDecoder.decodeObject(forKey :"filters") as? [Filter]
         sortBy = aDecoder.decodeObject(forKey: "sort_by") as? [String]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if filters != nil{
			aCoder.encode(filters, forKey: "filters")
		}
		if sortBy != nil{
			aCoder.encode(sortBy, forKey: "sort_by")
		}

	}*/

}
