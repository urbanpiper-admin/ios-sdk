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
                let newUUIDString: String = UUID().uuidString
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
        refreshToken()
    }
    
    internal class func initializeManager(language: Language) {
        shared = APIManager(language: language)
    }
    
    public func refreshToken() {
        guard let jwt = AppUserDataModel.shared.validAppUserData?.jwt, jwt.shouldRefreshToken else { return }
        let task = refreshToken(token: jwt.token, completion: { [weak self] (newToken) in
            guard let token = newToken else { return }
            let user = AppUserDataModel.shared.validAppUserData?.update(fromJWTToken: token)
            AppUserDataModel.shared.appUserData = user
            self?.updateHeaders()
        }, failure: nil)
        task.resume()
    }

    func bizAuth() -> String {
        let apiUsername: String = AppConfigManager.shared.firRemoteConfigDefaults.apiUsername
        let apiKey: String = AppConfigManager.shared.firRemoteConfigDefaults.apiKey
        
        return "apikey \(apiUsername):\(apiKey)"
    }
    
    @objc public func authorizationKey() -> String {
        if let token: String = AppUserDataModel.shared.validAppUserData?.jwt?.token {
            return "Bearer \(token)"
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
    
    public func handleAPIError(errorCode: Int = 0, data: Data?, failureClosure: APIFailure?) {
        if let closure = failureClosure {
            DispatchQueue.main.async {
                if let apiError: UPAPIError = UPAPIError(errorCode: errorCode, data: data) {
                    closure(apiError as UPError)
                } else {
                    closure(nil)
                }
            }
        }

        guard let jwt = AppUserDataModel.shared.validAppUserData?.jwt,
            let httpStatusCode = HTTPStatusCode(rawValue: errorCode),
            httpStatusCode == .unauthorized, jwt.tokenExpired else { return }
        
        DispatchQueue.main.async {
            AppUserDataModel.shared.reset()
        }
        return
    }

}

extension APIManager: URLSessionDelegate {
    
//    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
//        guard session.delegateQueue.operationCount == 0 else { return }
//        print("task count \(session.delegateQueue.operationCount)")
//        session.finishTasksAndInvalidate()
//    }
    
}
