//
//  APIManager+Auth.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 09/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import Foundation

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

    static let socialLoginBaseUrl: String = "\(APIManager.baseUrl)/api/v2/social_auth/me"

    @objc internal func request(urlString: String,
                              completion: ((socialLoginResponse?) -> Void)?,
                              failure: APIFailure?) -> URLSessionDataTask {
        
        var cs: CharacterSet = CharacterSet.urlQueryAllowed
        cs.remove(charactersIn: "@+")
        let encodedURlString: String = urlString.addingPercentEncoding(withAllowedCharacters: cs)!
        
        let url: URL = URL(string: encodedURlString)!

        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        
        return apiRequest(urlRequest: urlRequest, responseParser: { (dictionary) -> socialLoginResponse? in
            return socialLoginResponse(fromDictionary: dictionary)
        }, completion: completion, failure: failure)!
        
        /*let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let code = statusCode, code == 200 {
                
                if let jsonData: Data = data, let JSON: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []), let dictionary: [String: Any] = JSON as? [String: Any] {
                    let appUser: User
                    if let jwtToken = dictionary["token"] as? String {
                        appUser = User(jwtToken: jwtToken)
                    } else {
                        appUser = User(fromDictionary: dictionary)
//                        appUser.countryCode = user.countryCode
//
//                        if appUser.phone == nil || appUser.phone.count == 0 {
//                            appUser.phone = user.phone
//                        }
//
//                        if appUser.provider == nil {
//                            appUser.provider = user.provider
//                        }
//
//                        appUser.gender = user.gender
//
//                        appUser.firstName = user.firstName
//                        appUser.email = user.email
//                        appUser.accessToken = user.accessToken
                    }
                    
                    DispatchQueue.main.async {
                        completion?(appUser)
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
    
}

//  MARK: Social Login

extension APIManager {
    
    @objc internal func socialLogin(email: String,
                                    socialLoginProvider: SocialLoginProvider,
                                    accessToken: String,
                                    completion: ((socialLoginResponse?) -> Void)?,
                                    failure: APIFailure?) -> URLSessionDataTask {

        let urlString: String = "\(APIManager.socialLoginBaseUrl)/?email=\(email)&provider=\(socialLoginProvider.rawValue)&access_token=\(accessToken)"

        return request(urlString: urlString, completion: completion, failure: failure)
    }
    
}

//  MARK: Mobile Verification

extension APIManager {
    
    @objc internal func verifyPhone(phone: String,
                                         email: String,
                                         socialLoginProvider: SocialLoginProvider,
                                         accessToken: String,
                                         completion: ((socialLoginResponse?) -> Void)?,
                                         failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.socialLoginBaseUrl)/?email=\(email)&provider=\(socialLoginProvider.rawValue)&access_token=\(accessToken)&action=check_phone&phone=\(phone)"
        
        return request(urlString: urlString, completion: completion, failure: failure)
        
    }
    
    @objc internal func verifySocialOTP(phone: String,
                                email: String,
                                socialLoginProvider: SocialLoginProvider,
                                accessToken: String,
                                otp: String,
                                completion: ((socialLoginResponse?) -> Void)?,
                                failure: APIFailure?) -> URLSessionDataTask {
        
        let urlString: String = "\(APIManager.socialLoginBaseUrl)/?email=\(email)&provider=\(socialLoginProvider.rawValue)&access_token=\(accessToken)&action=verify_otp&phone=\(phone)&otp=\(otp)"
        
        return request(urlString: urlString, completion: completion, failure: failure)
        
    }
    
}
