//
//	Filter.swift
//
//	Create by Vidhyadharan Mohanram on 11/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Filter : NSObject {

	public private(set)  var filterOptions : [FilterOption]!
	public private(set)  var group : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		filterOptions = [FilterOption]()
		if let filterOptionsArray = dictionary["options"] as? [[String:Any]]{
			for dic in filterOptionsArray{
				let value = FilterOption(fromDictionary: dic)
				filterOptions.append(value)
			}
		}
		group = dictionary["group"] as? String
	}

/*	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if filterOptions != nil{
			var dictionaryElements = [[String:Any]]()
			for filterOptionsElement in filterOptions {
				dictionaryElements.append(filterOptionsElement.toDictionary())
			}
			dictionary["filter_options"] = dictionaryElements
		}
		if group != nil{
			dictionary["group"] = group
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         filterOptions = aDecoder.decodeObject(forKey :"filter_options") as? [FilterOption]
         group = aDecoder.decodeObject(forKey: "group") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if filterOptions != nil{
			aCoder.encode(filterOptions, forKey: "filter_options")
		}
		if group != nil{
			aCoder.encode(group, forKey: "group")
		}

	}*/

}
