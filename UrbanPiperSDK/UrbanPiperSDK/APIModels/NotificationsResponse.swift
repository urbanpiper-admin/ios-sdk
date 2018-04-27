//
//	NotificationsResponse.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class NotificationsResponse : NSObject, NSCoding{

	public var messages : [Message]!
	public var meta : Meta!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	public init(fromDictionary dictionary:  [String:Any]){
		messages = [Message]()
		if let messagesArray = dictionary["messages"] as? [[String:Any]]{
			for dic in messagesArray{
				let value = Message(fromDictionary: dic)
				messages.append(value)
			}
		}
		if let metaData = dictionary["meta"] as? [String:Any]{
			meta = Meta(fromDictionary: metaData)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	public func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if messages != nil{
            var dictionaryElements = [[String:Any]]()
			for messagesElement in messages {
				dictionaryElements.append(messagesElement.toDictionary())
			}
			dictionary["messages"] = dictionaryElements
		}
		if meta != nil{
			dictionary["meta"] = meta.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required public init(coder aDecoder: NSCoder)
	{
         messages = aDecoder.decodeObject(forKey :"messages") as? [Message]
         meta = aDecoder.decodeObject(forKey: "meta") as? Meta

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc public func encode(with aCoder: NSCoder)
	{
		if messages != nil{
			aCoder.encode(messages, forKey: "messages")
		}
		if meta != nil{
			aCoder.encode(meta, forKey: "meta")
		}

	}

}
