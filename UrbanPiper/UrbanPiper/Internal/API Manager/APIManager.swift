//
//  APIManager.swift
//  WhiteLabel
//
//  Created by Vidhyadharan Mohanram on 30/10/17.
//  Copyright © 2017 UrbanPiper Inc. All rights reserved.
//

import Foundation
import RxSwift

@objc internal class APIManager: NSObject {
    #if DEBUG
        static let baseUrl: String = "https://api.urbanpiper.com"
    #elseif RELEASE
        static let baseUrl: String = "https://api.urbanpiper.com"
    #else
        static let baseUrl: String = "https://api.urbanpiper.com"
    #endif

    @objc internal private(set) static var shared: APIManager!

    static let channel: String = "app_ios"
    static let fetchLimit: Int = 20

    let bizId: String
    let apiUsername: String
    let apiKey: String

    var jwt: JWT?

    let appVersion: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String

    private static let KeyChainUUIDString: String = "KeyChainUUIDStringKey"

    fileprivate var sessionConfig: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return config
    }()

    internal lazy var session: URLSession = {
        let session: URLSession = URLSession(configuration: sessionConfig)
        return session
    }()

    private static let keychain: UPKeychainWrapper = UPKeychainWrapper(serviceName: Bundle.main.bundleIdentifier!)

    static var uuidString: String! {
        guard let uuidStringVal: String = APIManager.keychain.string(forKey: APIManager.KeyChainUUIDString) else {
            let newUUIDString: String = UUID().uuidString
            APIManager.keychain.set(newUUIDString, forKey: APIManager.KeyChainUUIDString)
            return newUUIDString
        }
        return uuidStringVal
    }

    private init(bizId: String, apiUsername: String, apiKey: String, jwt: JWT?) {
        self.bizId = bizId
        self.apiUsername = apiUsername
        self.apiKey = apiKey
        self.jwt = jwt
        super.init()
    }

    internal class func initializeManager(bizId: String, apiUsername: String, apiKey: String, jwt: JWT?) {
        shared = APIManager(bizId: bizId, apiUsername: apiUsername, apiKey: apiKey, jwt: jwt)
    }

    func bizAuth() -> String {
        "apikey \(apiUsername):\(apiKey)"
    }

    @objc internal func authorizationKey() -> String {
        if let token: String = jwt?.token {
            return "Bearer \(token)"
        } else {
            return bizAuth()
        }
    }

    func apiDataTask<T: JSONDecodable>(upAPI: UPAPI,
                                       completion: APICompletion<T>?,
                                       failure: APIFailure?) -> URLSessionDataTask {
        var urlRequest = upAPI.requestWithBaseURL(baseURL: NSURL(string: APIManager.baseUrl)!)

        var additionalHeaders: [String: String] = ["X-App-Src": "ios",
                                                   "X-Bid": bizId,
                                                   "X-App-Version": appVersion,
                                                   "X-Use-Lang": SharedPreferences.language.rawValue,
                                                   "Content-Type": "application/json",
                                                   "Accept-Encoding": "gzip",
                                                   "Authorization": authorizationKey()]

        if let customHeaders: [String: String] = upAPI.headers {
            for header in customHeaders {
                additionalHeaders[header.key] = header.value
            }
        }

        urlRequest.allHTTPHeaderFields = additionalHeaders

        let apiUrl = urlRequest.url

        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil else {
                DispatchQueue.main.async {
                    failure?(error)
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    let userInfo = [NSLocalizedDescriptionKey: "Unknown error" as Any]
                    let error = NSError(domain: "UrbanPiperAPIErrorDomain", code: UPAPIError, userInfo: userInfo)
                    failure?(error)
                }
                return
            }

            guard 200 ... 204 ~= httpResponse.statusCode else {
                if self?.jwt != nil, httpResponse.statusCode == 401 {
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: .sessionExpired, object: nil)
                        UrbanPiper.sharedInstance().callback(.sessionExpired)
                    }
                }
                
                let error: Error
                if let responseData = data,
                    let dictionary: [String : Any] = try? JSONSerialization.jsonObject(with: responseData, options: []) as? [String : Any],
                    let msg = (dictionary["message"] ?? dictionary["error_message"] ?? dictionary["msg"]) as? String {
                    let userInfo = [NSLocalizedDescriptionKey: msg as Any]
                    error = NSError(domain: "UrbanPiperAPIErrorDomain", code: UPAPIServerError, userInfo: userInfo)
                } else {
                    let userInfo = [NSLocalizedDescriptionKey: "Invalid status code",
                                    "status_code": httpResponse.statusCode as Any]
                    error = NSError(domain: "UrbanPiperAPIErrorDomain", code: UPAPIError, userInfo: userInfo)
                }
                
                DispatchQueue.main.async {
                    failure?(error)
                }
                return
            }

            guard httpResponse.statusCode != 204 || (httpResponse.statusCode != 201 && (data?.count ?? 0) > 0) else {
                DispatchQueue.main.async {
                    completion?(GenericResponse() as? T)
                }
                return
            }

            if httpResponse.statusCode == 201 {
                if let responseData = data, let dictionary: [String : Any] = try? JSONSerialization.jsonObject(with: responseData, options: []) as? [String : Any],
                    let msg = (dictionary["message"] ?? dictionary["error_message"] ?? dictionary["msg"]) as? String {
                    let userInfo = [NSLocalizedDescriptionKey: msg as Any]
                    let error = NSError(domain: "UrbanPiperAPIErrorDomain", code: UPAPIServerError, userInfo: userInfo)
                    
                    DispatchQueue.main.async {
                        failure?(error)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion?(GenericResponse() as? T)
                    }
                }
                return
            }

            guard let responseData = data else {
                let userInfo = [NSLocalizedDescriptionKey: "No data from server" as Any]
                let error = NSError(domain: "UrbanPiperAPIErrorDomain", code: UPAPIError, userInfo: userInfo)

                DispatchQueue.main.async {
                    failure?(error)
                }
                return
            }

            do {
                let result = try T(data: responseData)
                DispatchQueue.main.async {
                    completion?(result)
                }
            } catch (let parsingError) {
                print("\nData type \(T.Type.self))\n")
                print("\nAPI Response parsing failure for url \(String(describing: apiUrl?.absoluteString))\n")
                print("\nresponse \(response.debugDescription)")
                print("\nparsing error \(parsingError)")

                if let jsonObject = String(data: responseData, encoding: String.Encoding.utf8) {
                    print("\njsonObject \(jsonObject as AnyObject)\n")
                }

                DispatchQueue.main.async {
                    failure?(parsingError)
                }
            }
        }

        dataTask.resume()
        return dataTask
    }

    func apiObservable<T: JSONDecodable>(upAPI: UPAPI) -> Observable<T> {
        var urlRequest = upAPI.requestWithBaseURL(baseURL: NSURL(string: APIManager.baseUrl)!)

        var additionalHeaders: [String: String] = ["X-App-Src": "ios",
                                                   "X-Bid": bizId,
                                                   "X-App-Version": appVersion,
                                                   "X-Use-Lang": SharedPreferences.language.rawValue,
                                                   "Content-Type": "application/json",
                                                   "Accept-Encoding": "gzip",
                                                   "Authorization": authorizationKey()]

        if let customHeaders: [String: String] = upAPI.headers {
            for header in customHeaders {
                additionalHeaders[header.key] = header.value
            }
        }

        urlRequest.allHTTPHeaderFields = additionalHeaders

        let apiUrl = urlRequest.url
        let urlSession = session

        let observable = Observable<T>.create { [weak self] observer in
            let dataTask: URLSessionDataTask = urlSession.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
                
                guard error == nil else {
                    observer.onError(error!)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    let userInfo = [NSLocalizedDescriptionKey: "Unknown error" as Any]
                    let error = NSError(domain: "UrbanPiperAPIErrorDomain", code: UPAPIError, userInfo: userInfo)
                    observer.onError(error)
                    return
                }

                guard (200 ..< 300) ~= httpResponse.statusCode else {
                    if self?.jwt != nil, httpResponse.statusCode == 401 {
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: .sessionExpired, object: nil)
                            UrbanPiper.sharedInstance().callback(.sessionExpired)
                        }
                    }

                    let error: Error
                    if let responseData = data,
                        let dictionary: [String : Any] = try? JSONSerialization.jsonObject(with: responseData, options: []) as? [String : Any],
                        let msg = (dictionary["message"] ?? dictionary["error_message"] ?? dictionary["msg"]) as? String {
                        let userInfo = [NSLocalizedDescriptionKey: msg as Any]
                        error = NSError(domain: "UrbanPiperAPIErrorDomain", code: UPAPIServerError, userInfo: userInfo)
                    } else {
                        let userInfo = [NSLocalizedDescriptionKey: "Invalid status code",
                                        "status_code": httpResponse.statusCode as Any]
                        error = NSError(domain: "UrbanPiperAPIErrorDomain", code: UPAPIError, userInfo: userInfo)
                    }
                    
                    observer.onError(error)
                    return
                }

                guard httpResponse.statusCode != 204 || (httpResponse.statusCode != 201 && (data?.count ?? 0) > 0) else {
                    observer.onNext(GenericResponse() as! T)
                    observer.onCompleted()
                    return
                }

                if httpResponse.statusCode == 201 {
                    if let responseData = data, let dictionary: [String : Any] = try? JSONSerialization.jsonObject(with: responseData, options: []) as? [String : Any],
                        let msg = (dictionary["message"] ?? dictionary["error_message"] ?? dictionary["msg"]) as? String {
                        let userInfo = [NSLocalizedDescriptionKey: msg as Any]
                        let error = NSError(domain: "UrbanPiperAPIErrorDomain", code: UPAPIServerError, userInfo: userInfo)
                        
                        observer.onError(error)
                    } else {
                        observer.onNext(GenericResponse() as! T)
                        observer.onCompleted()
                    }
                    return
                }

                guard let responseData = data else {
                    let userInfo = [NSLocalizedDescriptionKey: "No data from server" as Any]
                    let error = NSError(domain: "UrbanPiperAPIErrorDomain", code: UPAPIError, userInfo: userInfo)

                    observer.onError(error)
                    return
                }

                do {
                    let result = try T(data: responseData)
                    observer.onNext(result)
                    observer.onCompleted()
                } catch (let parsingError) {
                    print("\nData type \(T.Type.self))\n")
                    print("\nAPI Response parsing failure for url \(String(describing: apiUrl?.absoluteString))\n")
                    print("\nresponse \(response.debugDescription)")
                    print("\nparsing error \(parsingError)")

                    if let jsonObject = String(data: responseData, encoding: String.Encoding.utf8) {
                        print("\njsonObject \(jsonObject as AnyObject)\n")
                    }

                    observer.onError(parsingError)
                }
            }

            dataTask.resume()

            return Disposables.create {
                dataTask.cancel()
            }
        }

        return observable
    }
}
