//
//  APIManager.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 30/10/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import UIKit

@objc public class APIManager: NSObject {

    #if DEBUG
    public static let baseUrl = "https://staging.urbanpiper.com"
    #else
    public static let baseUrl = "https://api.urbanpiper.com"
    #endif

    public typealias APICompletion<T> = (T?) -> Void
    public typealias APIFailure = (UPError?) -> Void

    @objc public static private(set) var shared = APIManager()

    public static let channel = "app_ios"

    private static let KeyChainUUIDString = "KeyChainUUIDStringKey"

    fileprivate var sessionConfig: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return config
    }()

    lazy internal var session: URLSession = {
        let session = URLSession(configuration: sessionConfig,
                                 delegate: self,
                                 delegateQueue: nil)
        return session
    }()

    internal static let reachability = UPReachability(hostname: "www.google.com")

    private static let keychain = UPKeychainWrapper(serviceName: Bundle.main.bundleIdentifier!)
    
    static var uuidString: String! {
        get {
            guard let uuidStringVal = APIManager.keychain.string(forKey: APIManager.KeyChainUUIDString) else {
                let newUUIDString = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
                APIManager.keychain.set(newUUIDString, forKey: APIManager.KeyChainUUIDString)
                return newUUIDString
            }
            return uuidStringVal
        }
    }

    public override init() {
        super.init()
        updateHeaders()
    }
    
    func normalLoginUserAuthString(phone: String?, password: String?) -> String? {
        guard let phoneNo = phone, let passwordString = password, phoneNo.count > 0, passwordString.count > 0 else { return nil }
        
        let bizId = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!
        
        let authString = "\(phoneNo)__\(bizId):\(passwordString)"
        
        let data = authString.data(using: String.Encoding.utf8)
        let encodedAuthString = data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        return "Basic \(encodedAuthString)"
    }
    
    func socialLoginUserAuthString(email: String?, accessToken: String?) -> String? {
        guard let emailId = email, let token = accessToken, emailId.count > 0, token.count > 0 else { return nil }
                
        let authString = "\(emailId):\(token)"
        
        let data = authString.data(using: String.Encoding.utf8)
        let encodedAuthString = data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        return "Basic \(encodedAuthString)"
    }
    
    func bizAuth() -> String {
        let apiUsername: String = AppConfigManager.shared.firRemoteConfigDefaults.apiUsername
        let apiKey: String = AppConfigManager.shared.firRemoteConfigDefaults.apiKey
        
        return "apikey \(apiUsername):\(apiKey)"
    }
    
    @objc public func authorizationKey() -> String {
        let user = AppUserDataModel.shared.validAppUserData

        if let normalAuthString = normalLoginUserAuthString(phone: user?.phoneNumberWithCountryCode, password: user?.password) {
            return normalAuthString
        } else if let socialAuthString = socialLoginUserAuthString(email: user?.email, accessToken: user?.accessToken) {
            return socialAuthString
        } else {
            return bizAuth()
        }
    }

    @objc public func updateHeaders() {

        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        var additionalHeaders = ["X-Device": "ios",
                                 "X-App-Version": version,
                                 "Content-Type": "application/json"] as [AnyHashable : Any]
        
        additionalHeaders["Accept-Encoding"] = "gzip"
        
        additionalHeaders["Authorization"] = authorizationKey()

        sessionConfig.httpAdditionalHeaders = additionalHeaders
        
        session = URLSession(configuration: sessionConfig,
                             delegate: self,
                             delegateQueue: nil)
    }

}

extension APIManager: URLSessionDelegate {

}
