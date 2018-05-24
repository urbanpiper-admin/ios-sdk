//
//  APIManager+Ordering.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 07/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension APIManager {

    @objc public func fetchCategoriesList(_ isForceRefresh: Bool,
                                   completion: APICompletion<CategoriesResponse>?,
                                   failure: APIFailure?) -> URLSessionTask {

        let canUseCachedResponse = AppConfigManager.shared.firRemoteConfigDefaults.enableCaching && !isForceRefresh

        let appId = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!

        let urlString = "\(APIManager.baseUrl)/api/v1/order/categories/?format=json&biz_id=\(appId)"

        let url = URL(string: urlString)!

        var urlRequest = URLRequest(url: url,
                                    cachePolicy: canUseCachedResponse ? .useProtocolCachePolicy : .reloadIgnoringLocalAndRemoteCacheData)

        urlRequest.httpMethod = "GET"
        
        let task = session.dataTask(with: urlRequest) { [weak self] (data, response, error) in

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }

                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    let categoriesResponse = CategoriesResponse(fromDictionary: dictionary)
                    if categoriesResponse.objects.count > 1 {
                        categoriesResponse.objects.sort { $0.sortOrder < $1.sortOrder }
                    }

                    Biz.shared = categoriesResponse.biz
                    
                    self?.saveDeliveryTimingSlots(biz: categoriesResponse.biz)
                    // Saving feedback config info
                    self?.saveFeedbackConfiguration(biz: categoriesResponse.biz)
                    // Baba Fattoosh Specific
                    self?.saveReferEarnDetail(biz: categoriesResponse.biz)
                    // POD feature enable
                    self?.usePODEnabled(biz: categoriesResponse.biz)
                    // PayTm payment Enabled
                    self?.savePaymentOptionsDetail(biz: categoriesResponse.biz)

                    DispatchQueue.main.async {
                        completionClosure(categoriesResponse)
                    }
                    return
                }

                DispatchQueue.main.async {
                    completionClosure(nil)
                }
            } else {
                if let failureClosure = failure {
                    guard let apiError = UPAPIError(error: error, data: data) else { return }
                    DispatchQueue.main.async {
                        failureClosure(apiError as UPError)
                    }
                }
            }

        }

        return task
    }

    func saveDeliveryTimingSlots(biz: Biz) {
        guard let timeSlots = biz.timeSlots, timeSlots.count > 0 else { return }
        let timeSlotsDictionary = biz.timeSlots.map { $0.toDictionary() }
        let responseData = NSKeyedArchiver.archivedData(withRootObject: timeSlotsDictionary)
        UserDefaults.standard.set(responseData, forKey: "deliverySlots")
        UserDefaults.standard.set(true, forKey: "deliverySlotsEnabled")
        UserDefaults.standard.synchronize()
    }

    func saveFeedbackConfiguration(biz: Biz) {
        guard let feedbackConfig = biz.feedbackConfig, feedbackConfig.count > 0 else { return }
        let responseData = NSKeyedArchiver.archivedData(withRootObject: biz.toDictionary()["feedback_config"]!)
        UserDefaults.standard.set(responseData, forKey: "feedback_config")
        UserDefaults.standard.synchronize()
    }

    func saveReferEarnDetail(biz: Biz) {
        if let referralShareLbl = biz.referralShareLbl, referralShareLbl.count > 0 {
            UserDefaults.standard.set(referralShareLbl, forKey: "referral_share_lbl")
        }

        if let referralUILbl = biz.referralUiLbl, referralUILbl.count > 0 {
            UserDefaults.standard.set(referralUILbl, forKey: "referral_ui_lbl")
        }
        UserDefaults.standard.synchronize()
    }

    func usePODEnabled(biz: Biz) {
        if let usePointOfDelivery = biz.usePointOfDelivery {
            UserDefaults.standard.set(usePointOfDelivery, forKey: "use_point_of_delivery")
            UserDefaults.standard.synchronize()
        }
    }

    func savePaymentOptionsDetail(biz: Biz) {
        if let paymentOptions = biz.paymentOptions {
            UserDefaults.standard.set(paymentOptions, forKey: "payment_options")
            UserDefaults.standard.synchronize()
        }
    }

}