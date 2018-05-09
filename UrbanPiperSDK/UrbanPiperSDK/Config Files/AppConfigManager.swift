//
//  AppConfigManager.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 30/10/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

public class AppConfigManager: NSObject {

    @objc public static private(set) var shared = AppConfigManager()

    @objc public let firRemoteConfigDefaults = FirRemoteConfigDefaults.shared

    lazy var sideMenuPanelTabDetails: [SideMenuPanelTabDetail]! = {
        let plistPath = Bundle(for: AppConfigManager.self).path(forResource: "WLDetailOptionData", ofType: "plist")!
//        let plistPath = Bundle.main.path(forResource: "WLDetailOptionData", ofType: "plist")!
        var plistArray = NSArray(contentsOfFile: plistPath) as! [[String: Any]]
        let unFilteredTabsArray = plistArray.map { SideMenuPanelTabDetail(fromDictionary: $0) }
        let sideMenuTabKeyArray = firRemoteConfigDefaults.sideMenuTabKeyArray

        let filteredTabsArray = sideMenuTabKeyArray.map({ (key) -> SideMenuPanelTabDetail in
            let module = Module.init(rawValue: key)
            return unFilteredTabsArray.filter { $0.tag == module }.last!
        })

        return filteredTabsArray
    }()

    lazy var guestUserSidePanelTabs: [SideMenuPanelTabDetail] = {
        return sideMenuPanelTabDetails.filter { !$0.loginMandatory }
    }()

    lazy var loggedInUserSidePanelTabs: [SideMenuPanelTabDetail] = {
        return sideMenuPanelTabDetails.filter { $0.tag != .login }
    }()

    public override init() {
        
    }

}
