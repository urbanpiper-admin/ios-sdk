//
//  RewardsResponse.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on February 12, 2019

import Foundation


public class RewardsResponse : NSObject, NSCoding{

    public private(set) var claimed : [Reward]!
    public private(set) var locked : [Reward]!
    public private(set) var meta : Meta!
    public private(set) var redeemed : [Reward]!
    public private(set) var unlocked : [Reward]!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let metaData = dictionary["meta"] as? [String:Any]{
            meta = Meta(fromDictionary: metaData)
        }
        claimed = [Reward]()
        if let claimedArray = dictionary["claimed"] as? [[String:Any]]{
            for dic in claimedArray{
                let value = Reward(fromDictionary: dic)
                claimed.append(value)
            }
        }
        locked = [Reward]()
        if let lockedArray = dictionary["locked"] as? [[String:Any]]{
            for dic in lockedArray{
                let value = Reward(fromDictionary: dic)
                locked.append(value)
            }
        }
        redeemed = [Reward]()
        if let redeemedArray = dictionary["redeemed"] as? [[String:Any]]{
            for dic in redeemedArray{
                let value = Reward(fromDictionary: dic)
                redeemed.append(value)
            }
        }
        unlocked = [Reward]()
        if let unlockedArray = dictionary["unlocked"] as? [[String:Any]]{
            for dic in unlockedArray{
                let value = Reward(fromDictionary: dic)
                unlocked.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    @objc public func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if meta != nil{
            dictionary["meta"] = meta.toDictionary()
        }
        if locked != nil{
            var dictionaryElements = [[String:Any]]()
            for lockedElement in locked {
                dictionaryElements.append(lockedElement.toDictionary())
            }
            dictionary["locked"] = dictionaryElements
        }
        if redeemed != nil{
            var dictionaryElements = [[String:Any]]()
            for redeemedElement in redeemed {
                dictionaryElements.append(redeemedElement.toDictionary())
            }
            dictionary["redeemed"] = dictionaryElements
        }
        if unlocked != nil{
            var dictionaryElements = [[String:Any]]()
            for unlockedElement in unlocked {
                dictionaryElements.append(unlockedElement.toDictionary())
            }
            dictionary["unlocked"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder)
    {
        claimed = aDecoder.decodeObject(forKey: "claimed") as? [Reward]
        locked = aDecoder.decodeObject(forKey: "locked") as? [Reward]
        meta = aDecoder.decodeObject(forKey: "meta") as? Meta
        redeemed = aDecoder.decodeObject(forKey: "redeemed") as? [Reward]
        unlocked = aDecoder.decodeObject(forKey: "unlocked") as? [Reward]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder)
    {
        if claimed != nil{
            aCoder.encode(claimed, forKey: "claimed")
        }
        if locked != nil{
            aCoder.encode(locked, forKey: "locked")
        }
        if meta != nil{
            aCoder.encode(meta, forKey: "meta")
        }
        if redeemed != nil{
            aCoder.encode(redeemed, forKey: "redeemed")
        }
        if unlocked != nil{
            aCoder.encode(unlocked, forKey: "unlocked")
        }
    }
}
