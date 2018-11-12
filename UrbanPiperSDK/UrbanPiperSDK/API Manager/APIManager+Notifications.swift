//
//  APIManager+Notifications.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 07/11/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import Foundation

extension APIManager {

    @objc public func fetchNotificationsList(completion: ((NotificationsResponse?) -> Void)?,
                                      failure: APIFailure?) -> URLSessionDataTask {

        let urlString: String = "\(APIManager.baseUrl)/api/v1/ub/notifications/?channel__in=app_notification,all"

        let url: URL = URL(string: urlString)!

        var urlRequest: URLRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"

        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in

            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                guard let completionClosure = completion else { return }

                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let notificationsResponse: NotificationsResponse = NotificationsResponse(fromDictionary: dictionary)

                    DispatchQueue.main.async {
                        completionClosure(notificationsResponse)
                    }
                    return
                }

                DispatchQueue.main.async {
                    completionClosure(nil)
                }
            } else {
                self?.handleAPIError(errorCode: statusCode ?? 0, data: data, failureClosure: failure)
            }

        }

        return dataTask
    }

}

