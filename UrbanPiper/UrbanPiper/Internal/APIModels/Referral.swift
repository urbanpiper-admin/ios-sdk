//
//  Referral.swift
//  UrbanPiper
//
//  Created by Vid on 28/12/18.
//

import UIKit

@objcMembers public class Referral: NSObject, Codable {
    public let codeLink: String
    public let referrerCard: String
    public let channel: String
    public let sharedOn: String
    public let platform: String

    public required init?(fromDictionary dictionary: [String: AnyObject]?) {
        guard let dictionary = dictionary else { return nil }

        var referralLink = dictionary["~referring_link"] as? String
        if referralLink == nil || referralLink!.count == 0 {
            referralLink = dictionary["link_to_share"] as? String
        }
        codeLink = referralLink!
        referrerCard = dictionary["card"] as! String
        channel = dictionary["~channel"] as! String
        sharedOn = dictionary["link_share_time"] as! String
        platform = dictionary["~creation_source"] as! String
    }

    enum CodingKeys: String, CodingKey {
        case codeLink = "code_link"
        case referrerCard = "referrer_card"
        case channel
        case sharedOn = "shared_on"
        case platform
    }

    init(codeLink: String, referrerCard: String, channel: String, sharedOn: String, platform: String) {
        self.codeLink = codeLink
        self.referrerCard = referrerCard
        self.channel = channel
        self.sharedOn = sharedOn
        self.platform = platform
    }

    required convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Referral.self, from: data)
        self.init(codeLink: me.codeLink, referrerCard: me.referrerCard, channel: me.channel, sharedOn: me.sharedOn, platform: me.platform)
    }

}
