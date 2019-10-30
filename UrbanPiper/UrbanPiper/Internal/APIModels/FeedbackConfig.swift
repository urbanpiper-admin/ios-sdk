//
//	FeedbackConfig.swift
//
//	Create by Vidhyadharan Mohanram on 29/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class FeedbackConfig: NSObject, JSONDecodable, NSCoding {
    public var choices: [Choice]!
    public var type: String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    internal required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        choices = [Choice]()
        if let choicesArray: [[String: AnyObject]] = dictionary["choices"] as? [[String: AnyObject]] {
            for dic in choicesArray {
                guard let value: Choice = Choice(fromDictionary: dic) else { continue }
                choices.append(value)
            }
        }
        type = dictionary["type"] as? String
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [String: AnyObject]()
        if let choices = choices {
            var dictionaryElements: [[String: AnyObject]] = [[String: AnyObject]]()
            for choicesElement in choices {
                dictionaryElements.append(choicesElement.toDictionary())
            }
            dictionary["choices"] = dictionaryElements as AnyObject
        }
        if let type = type {
            dictionary["type"] = type as AnyObject
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc public required init(coder aDecoder: NSCoder) {
        Choice.registerClass()
        choices = aDecoder.decodeObject(forKey: "choices") as? [Choice]
        type = aDecoder.decodeObject(forKey: "type") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        // if let choices = choices {
            aCoder.encode(choices, forKey: "choices")
        // }
        // if let type = type {
            aCoder.encode(type, forKey: "type")
        // }
    }
}
