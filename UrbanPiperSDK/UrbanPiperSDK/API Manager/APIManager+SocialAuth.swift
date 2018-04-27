//
//  APIManager+Auth.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 09/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import UIKit

@objc public enum SocialLoginProvider: Int, RawRepresentable {
    case google
    case facebook
    
    public typealias RawValue = String

    public init?(rawValue: RawValue) {
        switch rawValue {
        case "google": self = .google
        case "facebook": self = .facebook
        default: return nil
        }
    }
    
    public var rawValue: RawValue {
        switch self {
        case .google: return "google"
        case .facebook: return "facebook"
        }
    }
}

extension APIManager {

    static let socialLoginBaseUrl = "\(APIManager.baseUrl)/api/v2/social_auth/me"

    @objc public func socialLogin(user: User,
                           urlString: String,
                           completion: APICompletion<User>?,
                           failure: APIFailure?) -> URLSessionTask {

        var apiURLString = urlString
        if let gender = user.gender {
            apiURLString.append("&gender=\(gender)")
        }
        
        var cs = CharacterSet.urlQueryAllowed
        cs.remove(charactersIn: "@+")
        let encodedURlString = apiURLString.addingPercentEncoding(withAllowedCharacters: cs)
        
        let url = URL(string: encodedURlString!)

        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "GET"
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let completionClosure = completion else { return }
                
                if let jsonData = data, let JSON = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary = JSON as? [String: Any] {
                    let appUser = User(fromDictionary: dictionary)

                    appUser.countryCode = user.countryCode
                   
                    if appUser.phone == nil || appUser.phone.count == 0 {
                        appUser.phone = user.phone
                    }
                    
                    if appUser.provider == nil {
                        appUser.provider = user.provider
                    }
                    
                    appUser.gender = user.gender

                    appUser.name = user.name
                    appUser.email = user.email
                    appUser.accessToken = user.accessToken
                    
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
    
}

//  MARK: Social Login

extension APIManager {
    
    @objc public func checkForUser(user: User,
                            completion: APICompletion<User>?,
                            failure: APIFailure?) -> URLSessionTask {

        let urlString = "\(APIManager.socialLoginBaseUrl)/?email=\(user.email!)&provider=\(user.provider!.rawValue)&access_token=\(user.accessToken!)"
        
        return socialLogin(user: user, urlString: urlString, completion: completion, failure: failure)
    }
    
}

//  MARK: Mobile Verification

extension APIManager {
    
    @objc public func checkPhoneNumber(user: User,
                                completion: APICompletion<User>?,
                                failure: APIFailure?) -> URLSessionTask {
        
        let urlString = "\(APIManager.socialLoginBaseUrl)/?email=\(user.email!)&provider=\(user.provider!.rawValue)&access_token=\(user.accessToken!)&action=check_phone&phone=\(user.phoneNumberWithCountryCode!)"
        
        return socialLogin(user: user, urlString: urlString, completion: completion, failure: failure)
        
    }
    
    @objc public func verifyOTP(user: User,
                         otp: String,
                         completion: APICompletion<User>?,
                         failure: APIFailure?) -> URLSessionTask {
        
        let urlString = "\(APIManager.socialLoginBaseUrl)/?email=\(user.email!)&provider=\(user.provider!.rawValue)&access_token=\(user.accessToken!)&action=verify_otp&phone=\(user.phoneNumberWithCountryCode!)&otp=\(otp)"
        
        return socialLogin(user: user, urlString: urlString, completion: completion, failure: failure)
        
    }
    
}

//  MARK: Mobile Verification

extension APIManager {
    
}

