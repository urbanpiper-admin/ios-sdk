//
//  APIManager+FCM.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 17/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension APIManager {
    
    private struct UserDefaultsFCMKeys {
        static let BizFCMTokenKey = "BizFCMTokenKey"
        static let UserBizFCMTokenKey = "UserBizFCMTokenKey"
    }
    
    var lastRegisteredFCMToken: String? {
        get {
            if AppUserDataModel.shared.validAppUserData != nil {
                return UserDefaults.standard.string(forKey: UserDefaultsFCMKeys.UserBizFCMTokenKey)
            } else {
                return UserDefaults.standard.string(forKey: UserDefaultsFCMKeys.BizFCMTokenKey)
            }
        }
        set {
            if let token = newValue {
                if AppUserDataModel.shared.validAppUserData != nil {
                    return UserDefaults.standard.set(token, forKey: UserDefaultsFCMKeys.UserBizFCMTokenKey)
                } else {
                    return UserDefaults.standard.set(token, forKey: UserDefaultsFCMKeys.BizFCMTokenKey)
                }
            } else {
                if AppUserDataModel.shared.validAppUserData != nil {
                    return UserDefaults.standard.removeObject(forKey: UserDefaultsFCMKeys.UserBizFCMTokenKey)
                } else {
                    return UserDefaults.standard.removeObject(forKey: UserDefaultsFCMKeys.BizFCMTokenKey)
                }
            }
        }
    }

    @objc public func registerForFCMMessaging(token: String,
                                       completion: APICompletion<[String : Any]>?,
                                       failure: APIFailure?) -> URLSessionTask? {
        
        guard lastRegisteredFCMToken == nil || lastRegisteredFCMToken! != token else {
            completion?(nil)
            return nil
        }
        
        let urlString = "\(APIManager.baseUrl)/api/v1/device/fcm/"
        
        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        let params = ["registration_id": token,
                      "device_id": APIManager.uuidString,
                      "channel": APIManager.channel]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])

        let task = session.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                self?.lastRegisteredFCMToken = token
                guard let completionClosure = completion else { return }
                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {

                    DispatchQueue.main.async {
                        completionClosure(dictionary)
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
    
    @objc public func unRegisterForFCMMessaging(completion: APICompletion<[String: Any]>?,
                                         failure: APIFailure?) -> URLSessionTask? {
        let oldToken = UserDefaults.standard.string(forKey: UserDefaultsFCMKeys.UserBizFCMTokenKey)
        guard AppUserDataModel.shared.validAppUserData == nil, oldToken != nil else {
            completion?(nil)
            return nil
        }
        
        let urlString = "\(APIManager.baseUrl)/api/v1/device/fcm/"

        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        let params = ["registration_id": oldToken,
                      "device_id": APIManager.uuidString,
                      "channel": APIManager.channel]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                UserDefaults.standard.removeObject(forKey: UserDefaultsFCMKeys.UserBizFCMTokenKey)
                guard let completionClosure = completion else { return }

                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {

                    DispatchQueue.main.async {
                        completionClosure(dictionary)
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
}
