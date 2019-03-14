//
//  APIManager+Ordering.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 07/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import Foundation

extension APIManager {

    func getCategories(storeId: Int?,
                             offset: Int = 0,
                             limit: Int = Constants.fetchLimit,
//                             isForceRefresh: Bool,
        completion: ((CategoriesResponse?) -> Void)?,
        failure: APIFailure?) -> URLSessionDataTask {

//        /api/v1/order/categories/1419/items/?format=json&limit=50&offset=50&biz_id=14632907
        var urlString: String = "\(APIManager.baseUrl)/api/v1/order/categories/?format=json&offset=\(offset)&limit=\(limit)&biz_id=\(bizId)"

        if let id = storeId {
            urlString = "\(urlString)&location_id=\(id)"
        }
        
        let url: URL = URL(string: urlString)!

        var urlRequest: URLRequest = URLRequest(url: url)
//        , cachePolicy: isForceRefresh ? .reloadIgnoringLocalAndRemoteCacheData : .useProtocolCachePolicy)

        urlRequest.httpMethod = "GET"
        
        
        return apiRequest(urlRequest: &urlRequest, responseParser: { (dictionary) -> CategoriesResponse? in
            return CategoriesResponse(fromDictionary: dictionary)
        }, completion: completion, failure: failure)!
        
        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in

            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {

                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let categoriesResponse: CategoriesResponse = CategoriesResponse(fromDictionary: dictionary)
                    if categoriesResponse.objects.count > 1 {
                        categoriesResponse.objects.sort { $0.sortOrder < $1.sortOrder }
                    }
                    
//                    self?.saveDeliveryTimingSlots(biz: categoriesResponse.biz)
//                    // Saving feedback config info
//                    self?.saveFeedbackConfiguration(biz: categoriesResponse.biz)
//                    // Baba Fattoosh Specific
//                    self?.saveReferEarnDetail(biz: categoriesResponse.biz)
//                    // POD feature enable
//                    self?.usePODEnabled(biz: categoriesResponse.biz)
//                    // PayTm payment Enabled
//                    self?.savePaymentOptionsDetail(biz: categoriesResponse.biz)

                    DispatchQueue.main.async {
                        completion?(categoriesResponse)
                    }
                    return
                }

                DispatchQueue.main.async {
                    completion?(nil)
                }
            } else {
                let errorCode = (error as NSError?)?.code
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }

        }

        return dataTask*/
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
