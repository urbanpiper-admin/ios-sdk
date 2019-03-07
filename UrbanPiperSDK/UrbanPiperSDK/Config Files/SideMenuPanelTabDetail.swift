//
//	SideMenuPanelTabDetail.swift
//
//	Create by Vidhyadharan Mohanram on 30/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

@objc public enum Module: Int, RawRepresentable {

    case home
    case ordering
    case history
    case historyWeb
    case wallet
    case referral
    case offers
    case schedule
    case bookTable
    case feedbackOld
    case notifications
    case storeLocOld
    case storeLoc
    case faq
    case rewards
    case rewardsOld
    case promo
    case settings
    case help
    case aboutUs
    case logout
    case login

    public typealias RawValue = String

    public init?(rawValue: RawValue) {
        switch rawValue {
        case "Home_tab": self = .home
        case "Order_tab": self = .ordering
        case "Feed_tab": self = .history
        case "Feed_tab_web": self = .historyWeb
        case "Pay_tab": self = .wallet
        case "ReferEarn_tab": self = .referral
        case "Offer_tab": self = .offers
        case "Schedule_tab": self = .schedule
        case "Book_table_tab": self = .bookTable
        case "Feedback_tab": self = .feedbackOld
        case "Notification_tab": self = .notifications
        case "Locations_tab": self = .storeLocOld
        case "Store_Locations_tab": self = .storeLoc
        case "Faq_tab": self = .faq
        case "Rewards_tab": self = .rewards
        case "Rewards_tab_web": self = .rewardsOld
        case "Promo_tab": self = .promo
        case "Settings_tab_native": self = .settings
        case "ConstactUs_tab": self = .help
        case "AboutUs_tab": self = .aboutUs
        case "Logout_tab": self = .logout
        case "Login_tab": self = .login
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .home: return "Home_tab"
        case .ordering: return "Order_tab"
        case .history: return "Feed_tab"
        case .historyWeb: return "Feed_tab_web"
        case .wallet: return "Pay_tab"
        case .referral: return "ReferEarn_tab"
        case .offers: return "Offer_tab"
        case .schedule: return "Schedule_tab"
        case .bookTable: return "Book_table_tab"
        case .feedbackOld: return "Feedback_tab"
        case .notifications: return "Notification_tab"
        case .storeLocOld: return "Locations_tab"
        case .storeLoc: return "Store_Locations_tab"
        case .faq: return "Faq_tab"
        case .rewards: return "Rewards_tab"
        case .rewardsOld: return "Rewards_tab_web"
        case .promo: return "Promo_tab"
        case .settings: return "Settings_tab_native"
        case .help: return "ConstactUs_tab"
        case .aboutUs: return "AboutUs_tab"
        case .logout: return "Logout_tab"
        case .login: return "Login_tab"
        }
    }
}

public class SideMenuPanelTabDetail : NSObject {

    public static let chaiFeedbackUrl: String = "http://chaipoint.com/olo/pagerequest?page=feedback&phone=%@&email=%@&authcode=%@";
    public static let chiliFeedbackUrl: String = "https://chilis.inmoment.com/websurvey";

	public var loginMandatory : Bool = false
	public var tabImage : String?
	public var tabSelectedIcon : String?
	public var tag : Module!
	public var title : String!
    public var locKey : String!
	public var url : String?


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	internal init(fromDictionary dictionary:  [String:Any]){
		loginMandatory = dictionary["loginMandatory"] as? Bool ?? false
		tabImage = dictionary["tabImage"] as? String
		tabSelectedIcon = dictionary["tabSelectedIcon"] as? String
		tag = Module.init(rawValue: dictionary["tag"] as! String)
		title = dictionary["title"] as? String
        locKey = dictionary["locKey"] as? String
		url = dictionary["url"] as? String
	}

}
