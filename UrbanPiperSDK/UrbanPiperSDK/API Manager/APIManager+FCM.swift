//
//  APIManager+FCM.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 17/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import Foundation

extension APIManager {
    
    private struct UserDefaultsFCMKeys {
        static let BizFCMTokenKey: String = "BizFCMTokenKey"
        static let UserBizFCMTokenKey: String = "UserBizFCMTokenKey"
    }
    
    var lastRegisteredFCMToken: String? {
        get {
            if UserManager.shared.currentUser != nil {
                return UserDefaults.standard.string(forKey: UserDefaultsFCMKeys.UserBizFCMTokenKey)
            } else {
                return UserDefaults.standard.string(forKey: UserDefaultsFCMKeys.BizFCMTokenKey)
            }
        }
        set {
            if let token = newValue {
                if UserManager.shared.currentUser != nil {
                    UserDefaults.standard.set(token, forKey: UserDefaultsFCMKeys.UserBizFCMTokenKey)
                } else {
                    UserDefaults.standard.set(token, forKey: UserDefaultsFCMKeys.BizFCMTokenKey)
                }
            } else {
                UserDefaults.standard.removeObject(forKey: UserDefaultsFCMKeys.UserBizFCMTokenKey)
                UserDefaults.standard.removeObject(forKey: UserDefaultsFCMKeys.BizFCMTokenKey)
            }
        }
    }

    @objc public func registerForFCMMessaging(token: String,
                                       completion: (([String : Any]?) -> Void)?,
                                       failure: APIFailure?) -> URLSessionDataTask? {
        
        guard lastRegisteredFCMToken == nil || lastRegisteredFCMToken! != token else {
            completion?(nil)
            return nil
        }
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/device/fcm/"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        let params: [String: Any] = ["registration_id": token,
                      "device_id": APIManager.uuidString,
                      "channel": APIManager.channel]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])

        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let errorCode = (error as NSError?)?.code
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? errorCode
            if let code = statusCode, code == 201 {
                self?.lastRegisteredFCMToken = token
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {

                    DispatchQueue.main.async {
                        completion?(dictionary)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion?(nil)
                }
            } else {
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }
    
    @objc public func unRegisterForFCMMessaging(completion: (([String: Any]?) -> Void)?,
                                         failure: APIFailure?) -> URLSessionDataTask? {
        let oldToken = UserDefaults.standard.string(forKey: UserDefaultsFCMKeys.UserBizFCMTokenKey)
        guard UserManager.shared.currentUser == nil, oldToken != nil else {
            completion?(nil)
            return nil
        }
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/device/fcm/"

        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        let params: [String: Any] = ["registration_id": oldToken!,
                      "device_id": APIManager.uuidString,
                      "channel": APIManager.channel]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let errorCode = (error as NSError?)?.code
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? errorCode
            if let code = statusCode, code == 201 {
                UserDefaults.standard.removeObject(forKey: UserDefaultsFCMKeys.UserBizFCMTokenKey)

                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {

                    DispatchQueue.main.async {
                        completion?(dictionary)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion?(nil)
                }
            } else {
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }
}
