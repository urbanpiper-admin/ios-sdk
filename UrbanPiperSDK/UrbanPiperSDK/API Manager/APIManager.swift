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

//public typealias APISuccess = () -> Void
public typealias APICompletion<T> = (T?) -> Void
public typealias APIFailure = (UPError?) -> Void

@objc public class APIManager: NSObject {

    #if DEBUG
    static let baseUrl: String = "https://staging.urbanpiper.com"
    #elseif RELEASE
    static let baseUrl: String = "https://api.urbanpiper.com"
    #else
    static let baseUrl: String = "https://api.urbanpiper.com"
    #endif

    @objc public static private(set) var shared: APIManager!
    
    static let channel: String = "app_ios"
    static let fetchLimit: Int = 20

    var language: Language {
        didSet {
            updateHeaders(jwt: jwt)
        }
    }

    let bizId: String
    let apiUsername: String
    let apiKey: String
    
    var jwt: JWT?
    
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
    
    private init(language: Language, bizId: String, apiUsername: String, apiKey: String, jwt: JWT?) {
        self.language = language
        self.bizId = bizId
        self.apiUsername = apiUsername
        self.apiKey = apiKey
        super.init()
        
        updateHeaders(jwt: jwt)
    }
    
    internal class func initializeManager(language: Language, bizId: String, apiUsername: String, apiKey: String, jwt: JWT?) {
        shared = APIManager(language: language, bizId: bizId, apiUsername: apiUsername, apiKey: apiKey, jwt: jwt)
    }

    func bizAuth() -> String {
        return "apikey \(apiUsername):\(apiKey)"
    }
    
    @objc internal func authorizationKey() -> String {
        if let token: String = jwt?.token {
            return "Bearer \(token)"
        } else {
            return bizAuth()
        }
    }

    @objc internal func updateHeaders(jwt: JWT?) {
        self.jwt = jwt
        
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        var additionalHeaders: [String: Any] = ["X-App-Src": "ios",
                                                 "X-Bid": bizId,
                                                 "X-App-Version": version,
                                                 "X-Use-Lang": language.rawValue,
                                                 "Content-Type": "application/json"] as [String: Any]

        additionalHeaders["Accept-Encoding"] = "gzip"
        
        additionalHeaders["Authorization"] = authorizationKey()

        sessionConfig.httpAdditionalHeaders = additionalHeaders
        
        session = URLSession(configuration: sessionConfig,
                             delegate: self,
                             delegateQueue: nil)
    }
    
    func apiRequest<T>(urlRequest: URLRequest,
                       responseParser: (([String: Any]) -> T?)?,
                       completion: APICompletion<T>?,
                       failure: APIFailure?) -> URLSessionDataTask? {
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let upError = UPAPIError(httpStatusCode: nil, errorCode: (error as NSError?)?.code, data: data, responseObject: nil)
                DispatchQueue.main.async {
                    failure?(upError)
                }
                return
            }
            
            guard 200 ... 204 ~= httpResponse.statusCode else {
                if let hasTokenExpired = self?.jwt?.tokenExpired, hasTokenExpired, httpResponse.statusCode == 401 {
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: .upSDKTokenExpired, object: nil)
                    }
                }
                
                let upError = UPAPIError(httpStatusCode: nil, errorCode: (error as NSError?)?.code, data: data, responseObject: nil)
                DispatchQueue.main.async {
                    failure?(upError)
                }
                return
            }
            
            guard let responseData = data,
                let jsonObject: Any = try? JSONSerialization.jsonObject(with: responseData, options: []),
                let dictionary: [String: Any] = jsonObject as? [String: Any],
                responseParser != nil else {
                    DispatchQueue.main.async {
                        completion?(nil)
                    }
                return
            }
            
            guard let result = responseParser?(dictionary) else {
                let upError = UPError(type: .responseParseError)
                DispatchQueue.main.async {
                    failure?(upError)
                }
                return
            }
            
            DispatchQueue.main.async {
                completion?(result)
            }
        }
        
        dataTask.resume()
        return dataTask

    }
    
//    func handleAPIError(httpStatusCode: Int?, errorCode: Int?, data: Data?, failureClosure: APIFailure?) {
//        guard errorCode == nil || errorCode != NSURLErrorCancelled else { return }
//        
//        if let code = httpStatusCode, code == 401, jwt != nil, jwt!.tokenExpired {
//            DispatchQueue.main.async {
//                NotificationCenter.default.post(name: .upSDKTokenExpired, object: nil)
//            }
//        }
//        
//        if let closure = failureClosure {
//            DispatchQueue.main.async {
//                if let apiError: UPAPIError = UPAPIError(httpStatusCode: httpStatusCode, errorCode: errorCode, data: data) {
//                    closure(apiError as UPError)
//                } else {
//                    closure(nil)
//                }
//            }
//        }
//    }

}

extension APIManager: URLSessionDelegate {
    
//    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
//        guard session.delegateQueue.operationCount == 0 else { return }
//        print("task count \(session.delegateQueue.operationCount)")
//        session.finishTasksAndInvalidate()
//    }
    
}
