//
//  FirRemoteConfigDefaultsExtension.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 03/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import Foundation

extension FirRemoteConfigDefaults {

    public static let scheduleTabModuleKey = "Schedule_tab"
    public static let bulkOrderingTabModuleKey = "Bulk_ordering_tab"
    public static let subscriptionTabModuleKey = "Subscription_tab"
    public static let presidenteRewardTabModuleKey = "Presidente_reward_tab"
    public static let settingsTabModuleKey = "Settings_tab"


    public var sideMenuTabKeyArray: [String] {
        var stringArray = [String]()

        if moduleOrdering {
            stringArray.append(Module.ordering.rawValue)
            stringArray.append(Module.history.rawValue)
        }

//        if "Home_Enabled" {
        #if PLATINUM
            stringArray.append(Module.home.rawValue)
        #endif

//        } else

        if moduleWallet {
            stringArray.append(Module.wallet.rawValue)
        }

//        else if "legacy pay enabled"  {
//        }
//        if "bulk ordering enabled" {
//        }
//        if "subscription ordering enabled" {
//        }

        if moduleRewardsOld {
            stringArray.append(Module.rewardsOld.rawValue)
            stringArray.append(Module.promo.rawValue)
        }

        if moduleReferral {
            stringArray.append(Module.referral.rawValue)
        }

//        if "custom rewards enabled" {
//        }

        if moduleRewards {
            stringArray.append(Module.rewards.rawValue)
        }
        

        if moduleBookTable {
            stringArray.append(Module.bookTable.rawValue)
        }

        if moduleOffers {
            stringArray.append(Module.offers.rawValue)
        }

//        if "custom offer enabled" {
//        }

        #if PLATINUM
            stringArray.append(Module.schedule.rawValue)
        #endif

        if !moduleOrdering, moduleHistory {
            stringArray.append(Module.historyWeb.rawValue)
        }

//        if "custom messages enabled" {
//        }

        if moduleStoreLocOld {
            stringArray.append(Module.storeLocOld.rawValue)
        }

        if moduleFeedbackOld {
            stringArray.append(Module.feedbackOld.rawValue)
        }
//        if "custom feedback enabled" {
//        }

        if moduleNotifications {
            stringArray.append(Module.notifications.rawValue)
        }

        if moduleStoreLoc {
            stringArray.append(Module.storeLoc.rawValue)
        }

        if moduleFaq {
            stringArray.append(Module.faq.rawValue)
        }

        if moduleSettings {
            stringArray.append(Module.settings.rawValue)
        }

        if moduleHelp {
            stringArray.append(Module.help.rawValue)
        }

        if moduleAboutUs {
            stringArray.append(Module.aboutUs.rawValue)
        }

        stringArray.append(Module.login.rawValue)
        stringArray.append(Module.logout.rawValue)

        return stringArray
    }

}
