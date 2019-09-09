//
//  RewardsResponse.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on February 12, 2019

import Foundation


public class RewardsResponse : NSObject, JSONDecodable, NSCoding{

    public var claimed : [Reward]!
    public var locked : [Reward]!
    public var meta : Meta!
    public var redeemed : [Reward]!
    public var unlocked : [Reward]!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        if let metaData = dictionary["meta"] as? [String : AnyObject]{
            meta = Meta(fromDictionary: metaData)
        }
        claimed = [Reward]()
        if let claimedArray = dictionary["claimed"] as? [[String : AnyObject]]{
            for dic in claimedArray{
                guard let value = Reward(fromDictionary: dic) else { continue }
                claimed.append(value)
            }
        }
        locked = [Reward]()
        if let lockedArray = dictionary["locked"] as? [[String : AnyObject]]{
            for dic in lockedArray{
                guard let value = Reward(fromDictionary: dic) else { continue }
                locked.append(value)
            }
        }
        unlocked = [Reward]()
        if let unlockedArray = dictionary["unlocked"] as? [[String : AnyObject]]{
            for dic in unlockedArray{
                guard let value = Reward(fromDictionary: dic) else { continue }
                unlocked.append(value)
            }
        }
        redeemed = [Reward]()
        if let redeemedArray = dictionary["redeemed"] as? [[String : AnyObject]]{
            for dic in redeemedArray{
                guard let value = Reward(fromDictionary: dic) else { continue }
                redeemed.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    @objc public func toDictionary() -> [String : AnyObject]
    {
        var dictionary = [String : AnyObject]()
        if let meta = meta {
            dictionary["meta"] = meta.toDictionary() as AnyObject
        }
        if let claimed = claimed {
            var dictionaryElements = [[String : AnyObject]]()
            for claimedElement in claimed {
                dictionaryElements.append(claimedElement.toDictionary())
            }
            dictionary["claimed"] = dictionaryElements as AnyObject
        }
        if let locked = locked {
            var dictionaryElements = [[String : AnyObject]]()
            for lockedElement in locked {
                dictionaryElements.append(lockedElement.toDictionary())
            }
            dictionary["locked"] = dictionaryElements as AnyObject
        }
        if let redeemed = redeemed {
            var dictionaryElements = [[String : AnyObject]]()
            for redeemedElement in redeemed {
                dictionaryElements.append(redeemedElement.toDictionary())
            }
            dictionary["redeemed"] = dictionaryElements as AnyObject
        }
        if let unlocked = unlocked {
            var dictionaryElements = [[String : AnyObject]]()
            for unlockedElement in unlocked {
                dictionaryElements.append(unlockedElement.toDictionary())
            }
            dictionary["unlocked"] = dictionaryElements as AnyObject
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
        if let claimed = claimed {
            aCoder.encode(claimed, forKey: "claimed")
        }
        if let locked = locked {
            aCoder.encode(locked, forKey: "locked")
        }
        if let meta = meta {
            aCoder.encode(meta, forKey: "meta")
        }
        if let redeemed = redeemed {
            aCoder.encode(redeemed, forKey: "redeemed")
        }
        if let unlocked = unlocked {
            aCoder.encode(unlocked, forKey: "unlocked")
        }
    }
}
