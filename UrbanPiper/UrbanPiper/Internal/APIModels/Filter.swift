//
//	Filter.swift
//
//	Create by Vidhyadharan Mohanram on 11/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Filter : NSObject, JSONDecodable {

	public var filterOptions : [FilterOption]!
	public var group : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
		filterOptions = [FilterOption]()
		if let filterOptionsArray = dictionary["options"] as? [[String : AnyObject]]{
			for dic in filterOptionsArray{
				guard let value = FilterOption(fromDictionary: dic) else { continue }
				filterOptions.append(value)
			}
		}
		group = dictionary["group"] as? String
	}

/*	/**
	 * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String : AnyObject]
	{
		var dictionary = [String : AnyObject]()
		if let filterOptions = filterOptions {
			var dictionaryElements = [[String : AnyObject]]()
			for filterOptionsElement in filterOptions {
				dictionaryElements.append(filterOptionsElement.toDictionary())
			}
			dictionary["filter_options"] = dictionaryElements as AnyObject
		}
		if let group = group {
			dictionary["group"] = group as AnyObject
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
		if let filterOptions = filterOptions {
			aCoder.encode(filterOptions, forKey: "filter_options")
		}
		if let group = group {
			aCoder.encode(group, forKey: "group")
		}

	}*/

}
