//
//	NotificationsResponse.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


public class NotificationsResponse : NSObject, JSONDecodable{

	public var messages : [Message]!
	public var meta : Meta!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
		messages = [Message]()
		if let messagesArray: [[String : AnyObject]] = dictionary["messages"] as? [[String : AnyObject]]{
			for dic in messagesArray{
				guard let value: Message = Message(fromDictionary: dic) else { continue }
				messages.append(value)
			}
		}
		if let metaData: [String : AnyObject] = dictionary["meta"] as? [String : AnyObject]{
			meta = Meta(fromDictionary: metaData)
		}
	}

//    /**
//     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    public func toDictionary() -> [String : AnyObject]
//    {
//        var dictionary: [String : AnyObject] = [String : AnyObject]()
//        if let messages = messages {
//            var dictionaryElements: [[String : AnyObject]] = [[String : AnyObject]]()
//            for messagesElement in messages {
//                dictionaryElements.append(messagesElement.toDictionary())
//            }
//            dictionary["messages"] = dictionaryElements as AnyObject
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
//         messages = aDecoder.decodeObject(forKey :"messages") as? [Message]
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
//        if let messages = messages {
//            aCoder.encode(messages, forKey: "messages")
//        }
//        if let meta = meta {
//            aCoder.encode(meta, forKey: "meta")
//        }
//
//    }

}
