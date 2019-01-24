//
//	FeedbackConfig.swift
//
//	Create by Vidhyadharan Mohanram on 29/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class FeedbackConfig : NSObject, NSCoding{

	public var choices : [Choice]!
	public var type : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		choices = [Choice]()
		if let choicesArray: [[String:Any]] = dictionary["choices"] as? [[String:Any]]{
			for dic in choicesArray{
				let value: Choice = Choice(fromDictionary: dic)
				choices.append(value)
			}
		}
		type = dictionary["type"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	public func toDictionary() -> [String:Any]
	{
		var dictionary: [String : Any] = [String:Any]()
		if choices != nil{
            var dictionaryElements: [[String:Any]] = [[String:Any]]()
			for choicesElement in choices {
				dictionaryElements.append(choicesElement.toDictionary())
			}
			dictionary["choices"] = dictionaryElements
		}
		if type != nil{
			dictionary["type"] = type
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
        Choice.registerClassName()
        Choice.registerClassNameWhiteLabel()
         choices = aDecoder.decodeObject(forKey :"choices") as? [Choice]
         type = aDecoder.decodeObject(forKey: "type") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if choices != nil{
			aCoder.encode(choices, forKey: "choices")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}

	}

}
