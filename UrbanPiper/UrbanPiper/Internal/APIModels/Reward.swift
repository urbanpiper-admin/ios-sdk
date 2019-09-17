//
//  Reward.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on February 12, 2019

import Foundation


public class Reward : NSObject, JSONDecodable, NSCoding{

    public var claimedCount : Int?
    public var descriptionField : String!
    public var expiresOn : Int?
    public var id : Int = 0
    public var imgLink : String!
    public var inStoreCouponRewards : Bool = false
    public var locked : Bool = false
    public var points : Int?
    public var redeemedCount : Int?
    public var redemptionCodes : [RedemptionCode]!
    public var title : String!
    public var type : Int?
    public var value : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        claimedCount = dictionary["claimed_count"] as? Int
        descriptionField = dictionary["description"] as? String
        expiresOn = dictionary["expires_on"] as? Int
        id = dictionary["id"] as? Int ?? 0
        imgLink = dictionary["img_link"] as? String
        inStoreCouponRewards = dictionary["in_store_coupon_rewards"] as? Bool ?? false
        locked = dictionary["locked"] as? Bool ?? false
        points = dictionary["points"] as? Int
        redeemedCount = dictionary["redeemed_count"] as? Int
        redemptionCodes = [RedemptionCode]()
        if let redemptionCodesArray = dictionary["redemption_codes"] as? [[String : AnyObject]]{
            for dic in redemptionCodesArray{
                guard let value = RedemptionCode(fromDictionary: dic) else { continue }
                redemptionCodes.append(value)
            }
        }
        title = dictionary["title"] as? String
        type = dictionary["type"] as? Int
        value = dictionary["value"] as? String
    }

    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String : AnyObject]
    {
        var dictionary = [String : AnyObject]()
        if let claimedCount = claimedCount {
            dictionary["claimed_count"] = claimedCount as AnyObject
        }
        if let descriptionField = descriptionField {
            dictionary["description"] = descriptionField as AnyObject
        }
        if let expiresOn = expiresOn {
            dictionary["expires_on"] = expiresOn as AnyObject
        }
        dictionary["id"] = id as AnyObject
        if let imgLink = imgLink {
            dictionary["img_link"] = imgLink as AnyObject
        }

        dictionary["in_store_coupon_rewards"] = inStoreCouponRewards as AnyObject
        
        dictionary["locked"] = locked as AnyObject
        
        if let points = points {
            dictionary["points"] = points as AnyObject
        }
        if let redeemedCount = redeemedCount {
            dictionary["redeemed_count"] = redeemedCount as AnyObject
        }
        if let redemptionCodes = redemptionCodes {
            var dictionaryElements = [[String : AnyObject]]()
            for redemptionCodesElement in redemptionCodes {
                dictionaryElements.append(redemptionCodesElement.toDictionary())
            }
            dictionary["redemption_codes"] = dictionaryElements as AnyObject
        }
        if let title = title {
            dictionary["title"] = title as AnyObject
        }
        if let type = type {
            dictionary["type"] = type as AnyObject
        }
        if let value = value {
            dictionary["value"] = value as AnyObject
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder)
    {
        claimedCount = aDecoder.decodeObject(forKey: "claimed_count") as? Int
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
        expiresOn = aDecoder.decodeObject(forKey: "expires_on") as? Int
        if let val = aDecoder.decodeObject(forKey: "id") as? Int {
            id = val
        } else {
            id = aDecoder.decodeInteger(forKey: "id")
        }
        imgLink = aDecoder.decodeObject(forKey: "img_link") as? String
        
        if let numberVal = aDecoder.decodeObject(forKey: "in_store_coupon_rewards") as? NSNumber {
            inStoreCouponRewards = numberVal == 0 ? false : true
        } else if aDecoder.containsValue(forKey: "in_store_coupon_rewards") {
            inStoreCouponRewards = aDecoder.decodeBool(forKey: "in_store_coupon_rewards")
        } else {
            inStoreCouponRewards = false
        }

        if let numberVal = aDecoder.decodeObject(forKey: "locked") as? NSNumber {
            locked = numberVal == 0 ? false : true
        } else if aDecoder.containsValue(forKey: "locked") {
            locked = aDecoder.decodeBool(forKey: "locked")
        } else {
            locked = false
        }

        points = aDecoder.decodeObject(forKey: "points") as? Int
        redeemedCount = aDecoder.decodeObject(forKey: "redeemed_count") as? Int
        redemptionCodes = aDecoder.decodeObject(forKey: "redemption_codes") as? [RedemptionCode]
        title = aDecoder.decodeObject(forKey: "title") as? String
        type = aDecoder.decodeObject(forKey: "type") as? Int
        value = aDecoder.decodeObject(forKey: "value") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder)
    {
        if let claimedCount = claimedCount {
            aCoder.encode(claimedCount, forKey: "claimed_count")
        }
        if let descriptionField = descriptionField {
            aCoder.encode(descriptionField, forKey: "description")
        }
        if let expiresOn = expiresOn {
            aCoder.encode(expiresOn, forKey: "expires_on")
        }
        aCoder.encode(id, forKey: "id")
        if let imgLink = imgLink {
            aCoder.encode(imgLink, forKey: "img_link")
        }

        aCoder.encode(inStoreCouponRewards, forKey: "in_store_coupon_rewards")

        aCoder.encode(locked, forKey: "locked")
        
        if let points = points {
            aCoder.encode(points, forKey: "points")
        }
        if let redeemedCount = redeemedCount {
            aCoder.encode(redeemedCount, forKey: "redeemed_count")
        }
        if let redemptionCodes = redemptionCodes {
            aCoder.encode(redemptionCodes, forKey: "redemption_codes")
        }
        if let title = title {
            aCoder.encode(title, forKey: "title")
        }
        if let type = type {
            aCoder.encode(type, forKey: "type")
        }
        if let value = value {
            aCoder.encode(value, forKey: "value")
        }
    }
}
