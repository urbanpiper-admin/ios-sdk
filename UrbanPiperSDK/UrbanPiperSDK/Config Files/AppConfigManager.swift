//
//  AppConfigManager.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 30/10/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

public class AppConfigManager: NSObject {

    @objc public static private(set) var shared: AppConfigManager = AppConfigManager()

    @objc public let firRemoteConfigDefaults = FirRemoteConfigDefaults.shared

    lazy var sideMenuPanelTabDetails: [SideMenuPanelTabDetail]! = {
        let bundle: Bundle = Bundle(for: AppConfigManager.self)
        let plistPath: String = bundle.path(forResource: "WLDetailOptionData", ofType: "plist")!
        var plistArray: [[String: Any]] = NSArray(contentsOfFile: plistPath) as! [[String: Any]]
        let unFilteredTabsArray: [SideMenuPanelTabDetail] = plistArray.map { SideMenuPanelTabDetail(fromDictionary: $0) }
        let sideMenuTabKeyArray: [String] = firRemoteConfigDefaults.sideMenuTabKeyArray

        let filteredTabsArray: [SideMenuPanelTabDetail] = sideMenuTabKeyArray.map({ (key) -> SideMenuPanelTabDetail in
            let module: Module = Module.init(rawValue: key)!
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

}
