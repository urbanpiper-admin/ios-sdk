//
//	BizInfo.swift
//
//	Create by Vidhyadharan Mohanram on 17/1/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public class UserBizInfoResponse: NSObject, JSONDecodable, NSCoding {
    public var meta: Meta!
    @objc public var userBizInfos: [UserBizInfo]!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    internal required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        if let metaData: [String: AnyObject] = dictionary["meta"] as? [String: AnyObject] {
            meta = Meta(fromDictionary: metaData)
        }
        userBizInfos = [UserBizInfo]()
        if let objectsArray: [[String: AnyObject]] = dictionary["objects"] as? [[String: AnyObject]] {
            for dic in objectsArray {
                guard let value: UserBizInfo = UserBizInfo(fromDictionary: dic) else { continue }
                userBizInfos.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [String: AnyObject]()
        if let meta = meta {
            dictionary["meta"] = meta.toDictionary() as AnyObject
        }
        if let userBizInfos = userBizInfos {
            var dictionaryElements: [[String: AnyObject]] = [[String: AnyObject]]()
            for userBizInfo in userBizInfos {
                dictionaryElements.append(userBizInfo.toDictionary())
            }
            dictionary["objects"] = dictionaryElements as AnyObject
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc public required init(coder aDecoder: NSCoder) {
        meta = aDecoder.decodeObject(forKey: "meta") as? Meta
        userBizInfos = aDecoder.decodeObject(forKey: "objects") as? [UserBizInfo]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        if let meta = meta {
            aCoder.encode(meta, forKey: "meta")
        }
        if let userBizInfos = userBizInfos {
            aCoder.encode(userBizInfos, forKey: "objects")
        }
    }
}
