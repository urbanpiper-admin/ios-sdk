//
//  APIManager+Auth.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 09/01/18.
//  Copyright © 2018 UrbanPiper Inc. All rights reserved.
//

import Foundation

enum AuthAPI {
    case refreshToken(token: String)
    case login(phone: String, password: String)
    case forgotPassword(phone: String)
    case resetPassword(phone: String, otp: String, password: String, confirmPassword: String)
    case registerUser(name: String, phone: String, email: String, password: String, referral: Referral?)
    case createSocialUser(name: String, phone: String, email: String, gender: String?, accessToken: String, referral: Referral?)
    case verifyRegOTP(phone: String, pin: String)
    case resendOTP(phone: String)
}

extension AuthAPI: UPAPI {
    var path: String {
        switch self {
        case .refreshToken:
            return "api/v2/auth/refresh-token/"
        case .login:
            return "api/v2/auth/token/"
        case .forgotPassword:
            return "api/v1/user/password/token/"
        case .resetPassword:
            return "api/v1/user/password/"
        case .registerUser:
            return "api/v2/card/"
        case .createSocialUser:
            return "api/v2/card/"
        case .verifyRegOTP:
            return "api/v2/card/"
        case .resendOTP:
            return "api/v2/card/"
        }
    }

    var parameters: [String: String]? {
        var params: [String: String]?
        switch self {
        case .refreshToken:
            params = nil
        case .login:
            params = nil
        case .forgotPassword:
            params = nil
        case .resetPassword:
            params = nil
        case let .registerUser(name, phone, email, password, _):
            params = ["customer_name": name,
                      "customer_phone": phone,
                      "email": email,
                      "password": password,
                      "channel": APIManager.channel]
        case let .createSocialUser(name, phone, email, gender, accessToken, _):
            params = ["customer_name": name,
                      "customer_phone": phone,
                      "email": email,
                      "password": accessToken,
                      "channel": APIManager.channel]

            if let gender = gender, gender.count > 0 {
                params?["gender"] = gender
            }
        case let .verifyRegOTP(phone, pin):
            params = ["customer_phone": phone,
                      "pin": pin,
                      "nopinsend": "true"]
        case let .resendOTP(phone):
            params = ["customer_phone": phone,
                      "pin": "resendotp"]
        }

        return params
    }

    var headers: [String: String]? {
        switch self {
        case .refreshToken:
            return ["Authorization": APIManager.shared.bizAuth()]
        case .login:
            return nil
        case .forgotPassword:
            return nil
        case .resetPassword:
            return nil
        case .registerUser:
            return ["Authorization": APIManager.shared.bizAuth()]
        case .createSocialUser:
            return ["Authorization": APIManager.shared.bizAuth()]
        case .verifyRegOTP:
            return ["Authorization": APIManager.shared.bizAuth()]
        case .resendOTP:
            return ["Authorization": APIManager.shared.bizAuth()]
        }
    }

    var method: HttpMethod {
        switch self {
        case .refreshToken:
            return .POST
        case .login:
            return .POST
        case .forgotPassword:
            return .POST
        case .resetPassword:
            return .POST
        case .registerUser:
            return .POST
        case .createSocialUser:
            return .POST
        case .verifyRegOTP:
            return .POST
        case .resendOTP:
            return .POST
        }
    }

    var body: [String: AnyObject]? {
        switch self {
        case let .refreshToken(token):
            return ["token": token] as [String: AnyObject]
        case let .login(phone, password):
            return ["username": phone,
                    "pass": password] as [String: AnyObject]
        case let .forgotPassword(phone):
            return ["biz_id": APIManager.shared.bizId,
                    "phone": phone] as [String: AnyObject]
        case let .resetPassword(phone, otp, password, confirmPassword):
            return ["biz_id": APIManager.shared.bizId,
                    "phone": phone,
                    "token": otp,
                    "new_password1": password,
                    "new_password2": confirmPassword] as [String: AnyObject]
        case let .registerUser(_, _, _, _, referral):
            if let params = referral?.toDictionary() {
                return ["referral": params] as [String: AnyObject]
            } else {
                return nil
            }
        case let .createSocialUser(_, _, _, _, _, referral):
            if let params = referral?.toDictionary() {
                return ["referral": params] as [String: AnyObject]
            } else {
                return nil
            }
        case .verifyRegOTP:
            return nil
        case .resendOTP:
            return nil
        }
    }
}
