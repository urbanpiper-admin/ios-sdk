//
//  APIManager.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 30/10/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

/*@GET("/api/v2/social_auth/me/")
 @GET("/api/v2/ub/wallet/transactions/")
 @POST("/api/v2/card/")
 @GET("/api/v2/items/0/recommendations/")
 @GET("/api/v2/order/{id}/reorder/")

 @GET("/api/v2/orders/")
 @GET("/api/v2/orders/{order_id}/")

 @GET("/api/v2/search/items/")

 @POST("/api/v2/feedback/")
 
 @GET("/api/v2/rewards/")
 @POST("/api/v2/rewards/{rewards_id}/redeem/")
 
 @GET("/api/v2/store/{store_id}/pod/")
*/

import Foundation

@objc public class APIManager: NSObject {

    #if DEBUG
    public static let baseUrl: String = "https://staging.urbanpiper.com"
    #elseif RELEASE
    public static let baseUrl: String = "https://api.urbanpiper.com"
    #else
    public static let baseUrl: String = "https://api.urbanpiper.com"
    #endif

    public typealias APISuccess = () -> Void
    public typealias APICompletion<T> = (T?) -> Void
    public typealias APIFailure = (UPError?) -> Void

    @objc public static private(set) var shared: APIManager!
    
    var language: Language = .english {
        didSet {
            updateHeaders()
        }
    }

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

    internal static let reachability: UPReachability? = {
        let reachability = UPReachability(hostname: "www.google.com")
        do {
            try reachability?.startNotifier()
        } catch {
        }
        return reachability
    }()

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

    private init(language: Language) {
        super.init()
        self.language = language
        updateHeaders()
    }
    
    internal class func initializeManager(language: Language) {
        shared = APIManager(language: language)
    }
    
    func normalLoginUserAuthString(phone: String?, password: String?) -> String? {
        guard let pNo: String = phone, pNo.count > 0 else { return nil }
        guard let passwordString: String = password, passwordString.count > 0 else { return nil }
        
        let bizId: String = AppConfigManager.shared.firRemoteConfigDefaults.bizId!
        
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
                                                 "X-Bid": AppConfigManager.shared.firRemoteConfigDefaults.bizId!,
                                                 "X-App-Version": version,
                                                 "X-Use-Lang": language.rawValue,
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
    
//    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
//        guard session.delegateQueue.operationCount == 0 else { return }
//        print("task count \(session.delegateQueue.operationCount)")
//        session.finishTasksAndInvalidate()
//    }
    
}
