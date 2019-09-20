//
//  APIManager+Auth.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 09/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import Foundation

enum SocialAuthAPI {
    case socialLogin(name: String?, email: String?, accessToken: String, socialLoginProvider: SocialLoginProvider)
    case verifyPhone(phone: String, email: String, accessToken: String, socialLoginProvider: SocialLoginProvider)
    case verifySocialOTP(phone: String, email: String, accessToken: String, socialLoginProvider: SocialLoginProvider, otp: String)
}

extension SocialAuthAPI: UPAPI {
    var path: String {
        switch self {
        case .socialLogin:
            return "api/v2/social_auth/me/"
        case .verifyPhone:
            return "api/v2/social_auth/me/"
        case .verifySocialOTP:
            return "api/v2/social_auth/me/"
        }
    }

    var parameters: [String: String]? {
        switch self {
        case let .socialLogin(name, email, accessToken, socialLoginProvider):
            var params = ["provider": socialLoginProvider.rawValue,
                          "access_token": accessToken]
            if let emailId = email {
                params["email"] = emailId
            }
            if let name = name {
                params["name"] = name
            }
            return params
        case let .verifyPhone(phone, email, accessToken, socialLoginProvider):
            return ["email": email,
                    "provider": socialLoginProvider.rawValue,
                    "access_token": accessToken,
                    "action": "check_phone",
                    "phone": phone]
        case let .verifySocialOTP(phone, email, accessToken, socialLoginProvider, otp):
            return ["email": email,
                    "provider": socialLoginProvider.rawValue,
                    "access_token": accessToken,
                    "action": "verify_otp",
                    "phone": phone,
                    "otp": otp]
        }
    }

    var headers: [String: String]? {
        switch self {
        case .socialLogin:
            return nil
        case .verifyPhone:
            return nil
        case .verifySocialOTP:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .socialLogin:
            return .GET
        case .verifyPhone:
            return .GET
        case .verifySocialOTP:
            return .GET
        }
    }

    var body: [String: AnyObject]? {
        switch self {
        case .socialLogin:
            return nil
        case .verifyPhone:
            return nil
        case .verifySocialOTP:
            return nil
        }
    }
}

//  MARK: Social Login

/* extension APIManager {

 @discardableResult internal func socialLogin(email: String,
                           socialLoginProvider: SocialLoginProvider,
                             accessToken: String,
                             completion: APICompletion<SocialLoginResponse>?,
                             failure: APIFailure?) -> URLSessionDataTask {

     let urlString: String = "\(APIManager.baseUrl)/api/v2/social_auth/me/?email=\(email)&provider=\(socialLoginProvider.rawValue)&access_token=\(accessToken)"

     var cs: CharacterSet = CharacterSet.urlQueryAllowed
     cs.remove(charactersIn: "@+")
     let encodedURlString: String = urlString.addingPercentEncoding(withAllowedCharacters: cs)!

     let url: URL = URL(string: encodedURlString)!

     var urlRequest: URLRequest = URLRequest(url: url)

     urlRequest.httpMethod = "GET"

     return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
 }

 }

 //  MARK: Mobile Verification

 extension APIManager {

 @discardableResult internal func verifyPhone(phone: String,
                           email: String,
                           socialLoginProvider: SocialLoginProvider,
                           accessToken: String,
                           completion: APICompletion<SocialLoginResponse>?,
                           failure: APIFailure?) -> URLSessionDataTask {

     let urlString: String = "\(APIManager.baseUrl)/api/v2/social_auth/me/?email=\(email)&provider=\(socialLoginProvider.rawValue)&access_token=\(accessToken)&action=check_phone&phone=\(phone)"

     var cs: CharacterSet = CharacterSet.urlQueryAllowed
     cs.remove(charactersIn: "@+")
     let encodedURlString: String = urlString.addingPercentEncoding(withAllowedCharacters: cs)!

     let url: URL = URL(string: encodedURlString)!

     var urlRequest: URLRequest = URLRequest(url: url)

     urlRequest.httpMethod = "GET"

     return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
 }

 @discardableResult internal func verifySocialOTP(phone: String,
                             email: String,
                             socialLoginProvider: SocialLoginProvider,
                             accessToken: String,
                             otp: String,
                             completion: APICompletion<SocialLoginResponse>?,
                             failure: APIFailure?) -> URLSessionDataTask {

     let urlString: String = "\(APIManager.baseUrl)/api/v2/social_auth/me/?email=\(email)&provider=\(socialLoginProvider.rawValue)&access_token=\(accessToken)&action=verify_otp&phone=\(phone)&otp=\(otp)"

     var cs: CharacterSet = CharacterSet.urlQueryAllowed
     cs.remove(charactersIn: "@+")
     let encodedURlString: String = urlString.addingPercentEncoding(withAllowedCharacters: cs)!

     let url: URL = URL(string: encodedURlString)!

     var urlRequest: URLRequest = URLRequest(url: url)

     urlRequest.httpMethod = "GET"

     return apiRequest(urlRequest: &urlRequest, completion: completion, failure: failure)
 }

 }*/
