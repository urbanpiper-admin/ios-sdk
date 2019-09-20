//
//	StatusUpdate.swift
//
//	Create by Vidhyadharan Mohanram on 18/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class StatusUpdate: NSObject, JSONDecodable {
    public var created: Int?
    public var message: String!
    public var status: String!
    public var updatedBy: String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        created = dictionary["created"] as? Int
        message = dictionary["message"] as? String
        status = dictionary["status"] as? String
        updatedBy = dictionary["updated_by"] as? String
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String: AnyObject] {
        var dictionary = [String: AnyObject]()
        if let created = created {
            dictionary["created"] = created as AnyObject
        }
        if let message = message {
            dictionary["message"] = message as AnyObject
        }
        if let status = status {
            dictionary["status"] = status as AnyObject
        }
        if let updatedBy = updatedBy {
            dictionary["updated_by"] = updatedBy as AnyObject
        }
        return dictionary
    }

    /*    /**
        * NSCoding required initializer.
        * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
    created = aDecoder.decodeObject(forKey: "created") as? Int
    message = aDecoder.decodeObject(forKey: "message") as? String
    status = aDecoder.decodeObject(forKey: "status") as? String
    updatedBy = aDecoder.decodeObject(forKey: "updated_by") as? String

    }

    /**
        * NSCoding required method.
        * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
    	if let created = created {
    		aCoder.encode(created, forKey: "created")
    	}
    	if let message = message {
    		aCoder.encode(message, forKey: "message")
    	}
    	if let status = status {
    		aCoder.encode(status, forKey: "status")
    	}
    	if let updatedBy = updatedBy {
    		aCoder.encode(updatedBy, forKey: "updated_by")
    	}

    }*/
}
