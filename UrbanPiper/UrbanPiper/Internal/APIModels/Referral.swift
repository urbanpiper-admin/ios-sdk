//
//  Referral.swift
//  UrbanPiper
//
//  Created by Vid on 28/12/18.
//

import UIKit

public class Referral: NSObject, JSONDecodable {

    public var codeLink : String!
    public var referrerCard : String!
    public var channel : String!
    public var sharedOn : String!
    public var platform : String!

    public required init?(fromDictionary dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        
        var referralLink = dictionary["~referring_link"] as? String
        if referralLink == nil || referralLink!.count == 0 {
            referralLink = dictionary["link_to_share"] as? String
        }
        codeLink = referralLink
        referrerCard = dictionary["card"] as? String
        channel = dictionary["~channel"] as? String
        sharedOn = dictionary["link_share_time"] as? String
        platform = dictionary["~creation_source"] as? String
        
    }
    
    /**
     * Returns all the available property values in the form of [String : AnyObject] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    public func toDictionary() -> [String : AnyObject] {
        var dictionary: [String : AnyObject] = [String : AnyObject]()
        
        if let codeLink = codeLink {
            dictionary["code_link"] = codeLink as AnyObject
        }
        if let referrerCard = referrerCard {
            dictionary["referrer_card"] = referrerCard as AnyObject
        }
        if let channel = channel {
            dictionary["channel"] = channel as AnyObject
        }
        if let sharedOn = sharedOn {
            dictionary["shared_on"] = sharedOn as AnyObject
        }
        if let platform = platform {
            dictionary["platform"] = platform as AnyObject
        }
        
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder) {
        codeLink = aDecoder.decodeObject(forKey:"code_link") as? String
        referrerCard = aDecoder.decodeObject(forKey:"referrer_card") as? String
        channel = aDecoder.decodeObject(forKey:"channel") as? String
        sharedOn = aDecoder.decodeObject(forKey:"shared_on") as? String
        platform = aDecoder.decodeObject(forKey: "platform") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder) {
        if codeLink != nil {
            aCoder.encode(codeLink, forKey: "code_link")
        }
        if referrerCard != nil {
            aCoder.encode(referrerCard, forKey: "referrer_card")
        }
        if channel != nil {
            aCoder.encode(channel, forKey: "channel")
        }
        if sharedOn != nil {
            aCoder.encode(sharedOn, forKey: "shared_on")
        }
        if platform != nil {
            aCoder.encode(platform, forKey: "platform")
        }
    }
}
