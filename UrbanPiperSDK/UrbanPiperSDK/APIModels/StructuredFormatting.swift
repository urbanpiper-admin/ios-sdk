//
//	StructuredFormatting.swift
//
//	Create by Vidhyadharan Mohanram on 10/4/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class StructuredFormatting : NSObject, NSCoding{

	public var mainText : String!
	public var mainTextMatchedSubstrings : [MatchedSubstring]!
	public var secondaryText : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		mainText = dictionary["main_text"] as? String
		mainTextMatchedSubstrings = [MatchedSubstring]()
		if let mainTextMatchedSubstringsArray: [[String:Any]] = dictionary["main_text_matched_substrings"] as? [[String:Any]]{
			for dic in mainTextMatchedSubstringsArray{
				let value: MatchedSubstring = MatchedSubstring(fromDictionary: dic)
				mainTextMatchedSubstrings.append(value)
			}
		}
		secondaryText = dictionary["secondary_text"] as? String
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String: Any] = [String:Any]()
//        if mainText != nil{
//            dictionary["main_text"] = mainText
//        }
//        if mainTextMatchedSubstrings != nil{
//            var dictionaryElements: [[String:Any]] = [[String:Any]]()
//            for mainTextMatchedSubstringsElement in mainTextMatchedSubstrings {
//                dictionaryElements.append(mainTextMatchedSubstringsElement.toDictionary())
//            }
//            dictionary["main_text_matched_substrings"] = dictionaryElements
//        }
//        if secondaryText != nil{
//            dictionary["secondary_text"] = secondaryText
//        }
//        return dictionary
//    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         mainText = aDecoder.decodeObject(forKey: "main_text") as? String
         mainTextMatchedSubstrings = aDecoder.decodeObject(forKey :"main_text_matched_substrings") as? [MatchedSubstring]
         secondaryText = aDecoder.decodeObject(forKey: "secondary_text") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if mainText != nil{
			aCoder.encode(mainText, forKey: "main_text")
		}
		if mainTextMatchedSubstrings != nil{
			aCoder.encode(mainTextMatchedSubstrings, forKey: "main_text_matched_substrings")
		}
		if secondaryText != nil{
			aCoder.encode(secondaryText, forKey: "secondary_text")
		}

	}

}
