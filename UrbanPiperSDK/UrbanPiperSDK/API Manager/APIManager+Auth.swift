//
//  APIManager+Auth.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 09/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit

extension APIManager {

    static let cardBaseUrl = "\(APIManager.baseUrl)/api/v2/card"
    
    @objc public func login(user: User,
                     password: String,
                     completion: APICompletion<User>?,
                     failure: APIFailure?) -> URLSessionTask {
        
        let urlString = "\(APIManager.baseUrl)/api/v1/auth/me/?format=json/"

        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.setValue(normalLoginUserAuthString(phone: user.phoneNumberWithCountryCode, password: password)!,
                            forHTTPHeaderField: "Authorization")
                
        urlRequest.httpMethod = "GET"
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    let appUser = User(fromDictionary: dictionary)
                    DispatchQueue.main.async {
                        completionClosure(appUser)
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
    
    @objc public func forgotPassword(countryCode: String,
                     phoneNumber: String,
                     completion: APICompletion<[String: Any]>?,
                     failure: APIFailure?) -> URLSessionTask {
        
        let urlString = "\(APIManager.baseUrl)/api/v1/user/password/token/"
        
        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
                
        let appId = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!
        let params = ["biz_id": appId,
                      "phone": "\(countryCode)\(phoneNumber)"]

        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
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
    
    @objc public func resetPassword(countryCode: String,
                             phoneNumber: String,
                             otp: String,
                             password: String,
                             confirmPassword: String,
                             completion: APICompletion<[String: Any]>?,
                             failure: APIFailure?) -> URLSessionTask {

        let urlString = "\(APIManager.baseUrl)/api/v1/user/password/"
        
        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"

        let appId = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!
        let params = ["biz_id": appId,
                      "phone": "\(countryCode)\(phoneNumber)",
                      "token": otp,
                      "new_password1": password,
                      "new_password2": confirmPassword]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])

        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
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
    
    @objc public func card(urlString: String,
                    referralParams: [String : Any]? = nil,
                    completion: APICompletion<CardAPIResponse>?,
                    failure: APIFailure?) -> URLSessionTask {
        
        var cs = CharacterSet.urlQueryAllowed
        cs.remove(charactersIn: "@+")
        let encodedURlString = urlString.addingPercentEncoding(withAllowedCharacters: cs)

        let url = URL(string: encodedURlString!)
        
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "POST"
        
        if let params = referralParams {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            
            if let link = params["code_link"] as? String, let val = params["channel"] as? String {
                AnalyticsManager.shared.referralSentDetails(link: link, channel: val)
            }
        }

        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse, (httpResponse.statusCode == 200 || httpResponse.statusCode == 201) {
                guard let completionClosure = completion else { return }
                
                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    let cardAPIResponse = CardAPIResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completionClosure(cardAPIResponse)
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

//  MARK: Create User

extension APIManager {
    
    func referralDict() -> [String : Any]? {
        guard let data = UserDefaults.standard.object(forKey: "referral_dictionary") as? Data,
            let referralDictionary = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String: Any],
            let referralLink = referralDictionary["link_to_share"] as? String, referralLink.count > 0,
            AppConfigManager.shared.firRemoteConfigDefaults.moduleReferral else { return nil }
        
        var requestDict = ["code_link": referralLink] as [String : Any]
        
        if let val = referralDictionary["card"] {
            requestDict["referrer_card"] = val
        }
        if let val = referralDictionary["~channel"] {
            requestDict["channel"] = val
        }
        if let val = referralDictionary["link_share_time"] {
            requestDict["shared_on"] = val
        }
        if let val = referralDictionary["~creation_source"] {
            requestDict["platform"] = val
        }
        let referralDict = ["referral": requestDict]
        
        return referralDict
        
    }
    
    @objc public func createUser(user: User,
                          password: String,
                          completion: APICompletion<CardAPIResponse>?,
                          failure: APIFailure?) -> URLSessionTask {
        
        let urlString = "\(APIManager.cardBaseUrl)/?customer_name=\(user.name!)&customer_phone=\(user.phoneNumberWithCountryCode!)&email=\(user.email!)&password=\(password)&channel=\(APIManager.channel)"
        
        return card(urlString: urlString, referralParams: referralDict(), completion: completion, failure: failure)
    }
    
    @objc public func createSocialUser(user: User,
                          completion: APICompletion<CardAPIResponse>?,
                          failure: APIFailure?) -> URLSessionTask {
        
        let urlString = "\(APIManager.cardBaseUrl)/?customer_name=\(user.name!)&customer_phone=\(user.phoneNumberWithCountryCode!)&email=\(user.email!)&password=\(user.accessToken!)&channel=\(APIManager.channel)"
        
        return card(urlString: urlString, referralParams: referralDict(), completion: completion, failure: failure)
    }
    
}

//  MARK: Mobile Verification

extension APIManager {
    
    @objc public func verifyMobile(user: User,
                            pin: String,
                            completion: APICompletion<CardAPIResponse>?,
                            failure: APIFailure?) -> URLSessionTask {
        
        let urlString = "\(APIManager.cardBaseUrl)/?customer_phone=\(user.phoneNumberWithCountryCode!)&pin=\(pin)&nopinsend=true"
        
        return card(urlString: urlString, completion: completion, failure: failure)
    }
    
    @objc public func resendOTP(user: User,
                         completion: APICompletion<CardAPIResponse>?,
                         failure: APIFailure?) -> URLSessionTask {
        
        let urlString = "\(APIManager.cardBaseUrl)/?customer_phone=\(user.phoneNumberWithCountryCode!)&pin=resendotp"
        
        return card(urlString: urlString, completion: completion, failure: failure)
    }
    
}
