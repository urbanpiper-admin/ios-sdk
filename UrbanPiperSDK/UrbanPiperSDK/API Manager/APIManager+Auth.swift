//
//  APIManager+Auth.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 09/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import Foundation

extension APIManager {

    static let cardBaseUrl: String = "\(APIManager.baseUrl)/api/v2/card"
    
    public func refreshToken(token: String,
                             completion: ((String?) -> Void)?,
                             failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v2/auth/refresh-token/"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)

        urlRequest.setValue(bizAuth(), forHTTPHeaderField: "Authorization")

        urlRequest.httpMethod = "POST"
        
        let params: [String: Any] = ["token": token]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let errorCode = (error as NSError?)?.code
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? errorCode
            if statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any], let newToken = dictionary["token"] as? String {
                    DispatchQueue.main.async {
                        completionClosure(newToken)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completionClosure(nil)
                }
            } else {
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }
    
    @objc public func login(username: String,
                     password: String,
                     completion: ((User?) -> Void)?,
                     failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v2/auth/token/"

        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"

        let params: [String: Any] = ["username": username,
                                     "pass": password]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])

        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let errorCode = (error as NSError?)?.code
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? errorCode
            if statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let appUser = User(jwtToken: (dictionary["token"] as! String))
                    DispatchQueue.main.async {
                        completionClosure(appUser)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completionClosure(nil)
                }
            } else {
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }
    
    @objc public func forgotPassword(countryCode: String,
                     phoneNumber: String,
                     completion: (([String: Any]?) -> Void)?,
                     failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/password/token/"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
                
        let appId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizId!
        let params: [String: Any] = ["biz_id": appId,
                      "phone": "\(countryCode)\(phoneNumber)"]

        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let errorCode = (error as NSError?)?.code
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? errorCode
            if statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    
                    DispatchQueue.main.async {
                        completionClosure(dictionary)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completionClosure(nil)
                }
            } else {
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }
    
    @objc public func resetPassword(countryCode: String,
                             phoneNumber: String,
                             otp: String,
                             password: String,
                             confirmPassword: String,
                             completion: (([String: Any]?) -> Void)?,
                             failure: APIFailure?) -> URLSessionDataTask {

        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/password/"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"

        let appId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizId!
        let params: [String: Any] = ["biz_id": appId,
                      "phone": "\(countryCode)\(phoneNumber)",
                      "token": otp,
                      "new_password1": password,
                      "new_password2": confirmPassword]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])

        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let errorCode = (error as NSError?)?.code
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? errorCode
            if statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    
                    DispatchQueue.main.async {
                        completionClosure(dictionary)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completionClosure(nil)
                }
            } else {
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }
    
    @objc public func card(urlString: String,
                    referralParams: [String : Any]? = nil,
                    completion: ((CardAPIResponse?) -> Void)?,
                    failure: APIFailure?) -> URLSessionDataTask {
        
        var cs: CharacterSet = CharacterSet.urlQueryAllowed
        cs.remove(charactersIn: "@+")
        let encodedURlString: String = urlString.addingPercentEncoding(withAllowedCharacters: cs)!

        let url: URL = URL(string: encodedURlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        if let params = referralParams {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])            
        }

        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let errorCode = (error as NSError?)?.code
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? errorCode
            if let code = statusCode, (code == 200 || code == 201) {
                guard let completionClosure = completion else { return }
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let cardAPIResponse: CardAPIResponse = CardAPIResponse(fromDictionary: dictionary)
                    
                    DispatchQueue.main.async {
                        completionClosure(cardAPIResponse)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completionClosure(nil)
                }
            } else {
                self?.handleAPIError(httpStatusCode: statusCode, errorCode: errorCode, data: data, failureClosure: failure)
            }
            
        }
        
        return dataTask
    }
    
}

//  MARK: Create User

extension APIManager {
    
    func referralDict() -> [String : Any]? {
        guard let data: Data = UserDefaults.standard.object(forKey: "referral_dictionary") as? Data,
            let referralDictionary: [String: Any] = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String: Any],
            let referralLink: String = referralDictionary["link_to_share"] as? String, referralLink.count > 0,
            AppConfigManager.shared.firRemoteConfigDefaults.moduleReferral else { return nil }
        
        var requestDict: [String : Any] = ["code_link": referralLink] as [String : Any]
        
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
        let referralDict: [String: Any] = ["referral": requestDict]
        
        return referralDict
        
    }
    
    @objc public func createUser(user: User,
                          password: String,
                          completion: ((CardAPIResponse?) -> Void)?,
                          failure: APIFailure?) -> URLSessionDataTask {
        AnalyticsManager.shared.track(event: .signupStart(phone: user.phone))
        let urlString: String = "\(APIManager.cardBaseUrl)/?customer_name=\(user.firstName!)&customer_phone=\(user.phoneNumberWithCountryCode!)&email=\(user.email!)&password=\(password)&channel=\(APIManager.channel)"
        
        return card(urlString: urlString, referralParams: referralDict(), completion: completion, failure: failure)
    }
    
    @objc public func createSocialUser(user: User,
                          completion: ((CardAPIResponse?) -> Void)?,
                          failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.cardBaseUrl)/?customer_name=\(user.firstName!)&customer_phone=\(user.phoneNumberWithCountryCode!)&email=\(user.email!)&password=\(user.accessToken!)&channel=\(APIManager.channel)"
        
        return card(urlString: urlString, referralParams: referralDict(), completion: completion, failure: failure)
    }
    
}

//  MARK: Mobile Verification

extension APIManager {
    
    @objc public func verifyMobile(user: User,
                            pin: String,
                            completion: ((CardAPIResponse?) -> Void)?,
                            failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.cardBaseUrl)/?customer_phone=\(user.phoneNumberWithCountryCode!)&pin=\(pin)&nopinsend=true"
        
        return card(urlString: urlString, completion: completion, failure: failure)
    }
    
    @objc public func resendOTP(user: User,
                         completion: ((CardAPIResponse?) -> Void)?,
                         failure: APIFailure?) -> URLSessionDataTask {
        let urlString: String = "\(APIManager.cardBaseUrl)/?customer_phone=\(user.phoneNumberWithCountryCode!)&pin=resendotp"
        
        return card(urlString: urlString, completion: completion, failure: failure)
    }
    
}

