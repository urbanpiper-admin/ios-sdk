//
//	CategoryOptionsResponse.swift
//
//	Create by Vidhyadharan Mohanram on 11/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class CategoryOptionsResponse: NSObject, JSONDecodable {
    public var filters: [Filter]!
    public var sortBy: [String]!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        filters = [Filter]()
        if let filtersArray = dictionary["filters"] as? [[String: AnyObject]] {
            for dic in filtersArray {
                guard let value = Filter(fromDictionary: dic) else { continue }
                filters.append(value)
            }
        }
        sortBy = dictionary["sort_by"] as? [String]
    }

    /*	/**
         * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String : AnyObject]
    {
    	var dictionary = [String : AnyObject]()
    	if let filters = filters {
    		var dictionaryElements = [[String : AnyObject]]()
    		for filtersElement in filters {
    			dictionaryElements.append(filtersElement.toDictionary())
    		}
    		dictionary["filters"] = dictionaryElements as AnyObject
    	}
    	if let sortBy = sortBy {
    		dictionary["sort_by"] = sortBy as AnyObject
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
    	if let filters = filters {
    		aCoder.encode(filters, forKey: "filters")
    	}
    	if let sortBy = sortBy {
    		aCoder.encode(sortBy, forKey: "sort_by")
    	}

    }*/
}
