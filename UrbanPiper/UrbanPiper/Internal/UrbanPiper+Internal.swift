//
//  UrbanPiper+Internal.swift
//  UrbanPiper
//
//  Created by Vid on 06/03/19.
//

import UIKit

public extension UrbanPiper {
    
    @discardableResult @objc public func reverseGeoCode(lat: Double,
                                                        lng: Double,
                                                        completion: ((Address?) -> Void)?,
                                                        failure: APIFailure?) -> URLSessionDataTask {
        return APIManager.shared.reverseGeoCode(lat: lat, lng: lng, completion: completion, failure: failure)
    }
    
    @discardableResult @objc public func fetchCoordinates(placeId: String,
                                                          completion: ((PlaceDetailsResponse?) -> Void)?,
                                                          failure: APIFailure?) -> URLSessionDataTask {
        return APIManager.shared.fetchCoordinates(from: placeId, completion: completion, failure: failure)
    }
    
    @discardableResult @objc public func fetchPlaces(for keyword: String,
                                                     completion: ((GooglePlacesResponse?) -> Void)?,
                                                     failure: APIFailure?) -> URLSessionDataTask {
        return APIManager.shared.fetchPlaces(for: keyword, completion: completion, failure: failure)
    }

    func addAddress(address: Address) {
//        AddressDataModel.shared.userAddressesResponse?.addresses.insert(address, at: 0)
    }
    
    func deleteAddress(addressId: Int) {
//        if let addresses = AddressDataModel.shared.userAddressesResponse?.addresses {
//            AddressDataModel.shared.userAddressesResponse?.addresses = addresses.filter { $0.id != addressId }
//        }
    }
    
    
    func setUpMixpanelObserver() {
        if let mixpanelToken = AppConfigManager.shared.firRemoteConfigDefaults.mixpanelProjectToken, mixpanelToken.count > 0 {
            let mixpanelObserver = MixpanelObserver(mixpanelToken: mixpanelToken)
            AnalyticsManager.shared.addObserver(observer: mixpanelObserver)
        }
    }
    
    func setUpGAObserver() {
        let plistPath: String = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")!
        var googleServiceInfoPlist: [String: Any] = NSDictionary(contentsOfFile: plistPath) as! [String: Any]
        if let trackingId: String = googleServiceInfoPlist["TRACKING_ID"] as? String, trackingId.count > 0 {
            let gaObserver = GAObserver(gaTrackingId: trackingId)
            AnalyticsManager.shared.addObserver(observer: gaObserver)
        }
    }
    
    func setUpAppsFlyerObserver() {
        if let appsFlyerDevAppid: String = AppConfigManager.shared.firRemoteConfigDefaults.appsFlyerDevAppid, let appsFlyerDevKey: String = AppConfigManager.shared.firRemoteConfigDefaults.appsFlyerDevKey {
            let appsFlyerObserver = AppsFlyerObserver(appsFlyerDevAppid: appsFlyerDevAppid, appsFlyerDevKey: appsFlyerDevKey)
            AnalyticsManager.shared.addObserver(observer: appsFlyerObserver)
        }
    }
}
