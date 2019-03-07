//
//	Prediction.swift
//
//	Create by Vidhyadharan Mohanram on 10/4/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class Prediction : NSObject, NSCoding{

	public private(set)  var descriptionField : String!
	public private(set)  var id : String!
	public private(set)  var matchedSubstrings : [MatchedSubstring]!
	public private(set)  var placeId : String!
	public private(set)  var reference : String!
	public private(set)  var structuredFormatting : StructuredFormatting!
	public private(set)  var terms : [Term]!
	public private(set)  var types : [String]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal init(fromDictionary dictionary:  [String:Any]){
		descriptionField = dictionary["description"] as? String
		id = dictionary["id"] as? String
		matchedSubstrings = [MatchedSubstring]()
		if let matchedSubstringsArray: [[String:Any]] = dictionary["matched_substrings"] as? [[String:Any]]{
			for dic in matchedSubstringsArray{
				let value: MatchedSubstring = MatchedSubstring(fromDictionary: dic)
				matchedSubstrings.append(value)
			}
		}
		placeId = dictionary["place_id"] as? String
		reference = dictionary["reference"] as? String
		if let structuredFormattingData: [String:Any] = dictionary["structured_formatting"] as? [String:Any]{
			structuredFormatting = StructuredFormatting(fromDictionary: structuredFormattingData)
		}
		terms = [Term]()
		if let termsArray: [[String:Any]] = dictionary["terms"] as? [[String:Any]]{
			for dic in termsArray{
				let value: Term = Term(fromDictionary: dic)
				terms.append(value)
			}
		}
		types = dictionary["types"] as? [String]
	}

//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String:Any]
//    {
//        var dictionary: [String: Any] = [String:Any]()
//        if descriptionField != nil{
//            dictionary["description"] = descriptionField
//        }
//        if id != nil{
//            dictionary["id"] = id
//        }
//        if matchedSubstrings != nil{
//            var dictionaryElements: [[String:Any]] = [[String:Any]]()
//            for matchedSubstringsElement in matchedSubstrings {
//                dictionaryElements.append(matchedSubstringsElement.toDictionary())
//            }
//            dictionary["matched_substrings"] = dictionaryElements
//        }
//        if placeId != nil{
//            dictionary["place_id"] = placeId
//        }
//        if reference != nil{
//            dictionary["reference"] = reference
//        }
//        if structuredFormatting != nil{
//            dictionary["structured_formatting"] = structuredFormatting.toDictionary()
//        }
//        if terms != nil{
//            var dictionaryElements: [[String:Any]] = [[String:Any]]()
//            for termsElement in terms {
//                dictionaryElements.append(termsElement.toDictionary())
//            }
//            dictionary["terms"] = dictionaryElements
//        }
//        if types != nil{
//            dictionary["types"] = types
//        }
//        return dictionary
//    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         id = aDecoder.decodeObject(forKey: "id") as? String
        matchedSubstrings = aDecoder.decodeObject(forKey :"matched_substrings") as? [MatchedSubstring]
         placeId = aDecoder.decodeObject(forKey: "place_id") as? String
         reference = aDecoder.decodeObject(forKey: "reference") as? String
        structuredFormatting = aDecoder.decodeObject(forKey: "structured_formatting") as? StructuredFormatting
        terms = aDecoder.decodeObject(forKey :"terms") as? [Term]
        types = aDecoder.decodeObject(forKey: "types") as? [String]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if matchedSubstrings != nil{
			aCoder.encode(matchedSubstrings, forKey: "matched_substrings")
		}
		if placeId != nil{
			aCoder.encode(placeId, forKey: "place_id")
		}
		if reference != nil{
			aCoder.encode(reference, forKey: "reference")
		}
		if structuredFormatting != nil{
			aCoder.encode(structuredFormatting, forKey: "structured_formatting")
		}
		if terms != nil{
			aCoder.encode(terms, forKey: "terms")
		}
		if types != nil{
			aCoder.encode(types, forKey: "types")
		}

	}

}
