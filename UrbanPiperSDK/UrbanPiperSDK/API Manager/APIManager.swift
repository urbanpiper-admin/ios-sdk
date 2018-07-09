//
//  APIManager.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 30/10/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import Foundation

@objc public class APIManager: NSObject {

    #if DEBUG
    public static let baseUrl: String = "https://staging.urbanpiper.com"
    #else
    public static let baseUrl: String = "https://api.urbanpiper.com"
    #endif

    public typealias APISuccess = () -> Void
    public typealias APICompletion<T> = (T?) -> Void
    public typealias APIFailure = (UPError?) -> Void

    @objc public static private(set) var shared: APIManager = APIManager()

    public static let channel: String = "app_ios"

    private static let KeyChainUUIDString: String = "KeyChainUUIDStringKey"

    fileprivate var sessionConfig: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return config
    }()

    lazy internal var session: URLSession = {
        let session: URLSession = URLSession(configuration: sessionConfig,
                                 delegate: self,
                                 delegateQueue: nil)
        return session
    }()

    internal static let reachability: UPReachability? = UPReachability(hostname: "www.google.com")

    private static let keychain: UPKeychainWrapper = UPKeychainWrapper(serviceName: Bundle.main.bundleIdentifier!)
    
    static var uuidString: String! {
        get {
            guard let uuidStringVal: String = APIManager.keychain.string(forKey: APIManager.KeyChainUUIDString) else {
                let newUUIDString: String = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
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
        guard let pNo: String = phone, pNo.count > 0 else { return nil }
        guard let passwordString: String = password, passwordString.count > 0 else { return nil }
        
        let bizId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!
        
        let authString: String = "\(pNo)__\(bizId):\(passwordString)"
        
        let data: Data = authString.data(using: String.Encoding.utf8)!
        let encodedAuthString: String = data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        let returnVal: String = "Basic \(encodedAuthString)"
        
        return returnVal
    }
    
    func socialLoginUserAuthString(email: String?, accessToken: String?) -> String? {
        guard let emailId = email, let token = accessToken, emailId.count > 0, token.count > 0 else { return nil }
                
        let authString: String = "\(emailId):\(token)"
        
        let data = authString.data(using: String.Encoding.utf8)
        let encodedAuthString: String = data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        return "Basic \(encodedAuthString)"
    }
    
    func bizAuth() -> String {
        let apiUsername: String = AppConfigManager.shared.firRemoteConfigDefaults.apiUsername
        let apiKey: String = AppConfigManager.shared.firRemoteConfigDefaults.apiKey
        
        return "apikey \(apiUsername):\(apiKey)"
    }
    
    @objc public func authorizationKey() -> String {
        let user = AppUserDataModel.shared.validAppUserData

        if let normalAuthString: String = normalLoginUserAuthString(phone: user?.phoneNumberWithCountryCode, password: user?.password) {
            return normalAuthString
        } else if let socialAuthString: String = socialLoginUserAuthString(email: user?.email, accessToken: user?.accessToken) {
            return socialAuthString
        } else {
            return bizAuth()
        }
    }

    @objc public func updateHeaders() {

        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        var additionalHeaders: [String : Any] = ["X-App-Src": "ios",
                                                 "X-Bid": AppConfigManager.shared.firRemoteConfigDefaults.bizAppId!,
                                                 "X-App-Version": version,
                                                 "Content-Type": "application/json"] as [String : Any]

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
