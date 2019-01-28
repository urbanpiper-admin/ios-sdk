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
    
    @objc public func forgotPassword(phone: String,
                                     completion: (([String: Any]?) -> Void)?,
                                     failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/password/token/"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
                
        let params: [String: Any] = ["biz_id": bizId,
                                     "phone": phone]

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
    
    @objc public func resetPassword(phone: String,
                                    otp: String,
                                    password: String,
                                    confirmPassword: String,
                                    completion: (([String: Any]?) -> Void)?,
                                    failure: APIFailure?) -> URLSessionDataTask {

        let urlString: String = "\(APIManager.baseUrl)/api/v1/user/password/"
        
        let url: URL = URL(string: urlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"

        let params: [String: Any] = ["biz_id": bizId,
                      "phone": phone,
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
                           referralParams: Referral? = nil,
                           completion: ((CardAPIResponse?) -> Void)?,
                           failure: APIFailure?) -> URLSessionDataTask {
        
        var cs: CharacterSet = CharacterSet.urlQueryAllowed
        cs.remove(charactersIn: "@+")
        let encodedURlString: String = urlString.addingPercentEncoding(withAllowedCharacters: cs)!

        let url: URL = URL(string: encodedURlString)!
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.setValue(bizAuth(), forHTTPHeaderField: "Authorization")

        urlRequest.httpMethod = "POST"
        
        if let params = referralParams {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: ["referral": params.toDictionary()], options: [])
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
    
    @objc public func createUser(name: String,
                                 phone: String,
                                 email: String,
                                 password: String,
                                 referralObject: Referral? = nil,
                                 completion: ((CardAPIResponse?) -> Void)?,
                                 failure: APIFailure?) -> URLSessionDataTask {
        AnalyticsManager.shared.track(event: .signupStart(phone: phone))
        let urlString: String = "\(APIManager.cardBaseUrl)/?customer_name=\(name)&customer_phone=\(phone)&email=\(email)&password=\(password)&channel=\(APIManager.channel)"
        
        return card(urlString: urlString, referralParams: referralObject, completion: completion, failure: failure)
    }
    
    @objc public func createSocialUser(name: String,
                                       phone: String,
                                       email: String,
                                       gender: String? = nil,
                                       accessToken: String,
                                       referralObject: Referral? = nil,
                                       completion: ((String?) -> Void)?,
                                       failure: APIFailure?) -> URLSessionDataTask {
        
        var urlString: String = "\(APIManager.cardBaseUrl)/?customer_name=\(name)&customer_phone=\(phone)&email=\(email)&password=\(accessToken)&channel=\(APIManager.channel)"
        
        if gender != nil {
            urlString = "\(urlString)&gender=\(gender!)"
        }
        
        return card(urlString: urlString, referralParams: referralObject, completion: { (cardAPIResponse) in
            completion?(cardAPIResponse?.message)
        }, failure: failure)
    }
    
}

//  MARK: Mobile Verification

extension APIManager {
    
    @objc public func verifyMobile(phone: String,
                                   pin: String,
                                   completion: ((CardAPIResponse?) -> Void)?,
                                   failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.cardBaseUrl)/?customer_phone=\(phone)&pin=\(pin)&nopinsend=true"
        
        return card(urlString: urlString, completion: completion, failure: failure)
    }
    
    @objc public func resendOTP(phone: String,
                                completion: ((CardAPIResponse?) -> Void)?,
                                failure: APIFailure?) -> URLSessionDataTask {
        let urlString: String = "\(APIManager.cardBaseUrl)/?customer_phone=\(phone)&pin=resendotp"
        
        return card(urlString: urlString, completion: completion, failure: failure)
    }
    
}

